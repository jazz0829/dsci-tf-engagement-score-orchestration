from __future__ import print_function

import argparse
from datetime import datetime
from dateutil.relativedelta import relativedelta
from slackclient import SlackClient
from pyspark.sql import SparkSession
from common.config import get_config
from common.model_operation import ModelOperation
from common.utils import write_churn_output, write_train_statistics

SLACK_TOKEN = "xoxb-28674668403-605322818656-UC8IGyHQo40z4IhwvhrG3lPe"
PROJECTNAME = 'HealthScorePredictions'
SCRIPTNAME = 'contractprediction.py'

def send_to_slack(message, target_channel="GHQKCTSNN"): # cig-lago-log
    """
    send to slack function
    """
    try:
        message = str(message)
        print(message)
        slackclient = SlackClient(SLACK_TOKEN)
        slackclient.api_call(
            "chat.postMessage",
            channel=target_channel,
            text="%s: %s- %s"%(PROJECTNAME, SCRIPTNAME, message))
    except Exception as general_exception:
        print("cannot send on slack")
        print(general_exception)

def run_operations(spark, category, mode, config_name, current_date):
    """ orechestration set up """
    # extend with generalized columns
    config_json = get_config(category, config_name)
    config_json['unique_id'] = ["environment", "account_code", "package_code"]
    config_json['mode'] = mode
    config_json['category'] = category
    config_json['current_date'] = current_date
    config_json['past_date'] = current_date - relativedelta(days=config_json.get('window_contract'))

    # create objects
    model_ops_obj = ModelOperation(spark, config_json)
    dataset_obj = config_json['dataset_obj'](spark, config_json)

    # operations
    if (mode == 'train' or mode == 'all'):
        train_df = dataset_obj.get_dataset(current_date, mode)
        print(config_json.get('training_data_path'))
        train_df.write.mode('overwrite').parquet(config_json.get('training_data_path'))
        auc, reg_param = model_ops_obj.select_and_train()
        write_train_statistics(spark, config_json, auc, reg_param)
    elif (mode == 'predict' or mode == 'all'):
        flag = False #TODO check whether healthscore already exists or not
        if not flag:
            test_df = dataset_obj.get_dataset(current_date, mode)
            scores = model_ops_obj.predict(test_df)
            write_churn_output(config_json, scores)
        else:
            print('Health scores for {} already exist'.format(current_date)) #TODO dump into logfile
    elif (mode == 'evaluate' or mode == 'all'):
        pass
    elif (mode == 'validate' or mode == 'all'):
        pass

def main():
    """ entry point, triggers model operation tasks.
    """
    parser = argparse.ArgumentParser("OPERATIONS")
    parser.add_argument("--category", '-hc', metavar="category", type=str, required=True, help="churn or downgrade")
    parser.add_argument("--mode", '-hm', metavar="mode", type=str, required=True, help="train or predict or validate or evaluate")
    parser.add_argument("--config_name", '-hn', metavar="config_name", type=str, required=True, help="accounting_established")
    parser.add_argument("--current_date", '-hd', metavar="current_date", type=str, required=True, help="currentdate")
    conf = parser.parse_args()
    arg_category = conf.category
    arg_mode = conf.mode
    arg_config_name = conf.config_name
    print(conf.config_name)
    arg_current_date = datetime.strptime(conf.current_date, "%Y-%m-%d")
    spark_session = SparkSession.builder.appName('HealthScoreTrainingAndPrediction').getOrCreate()
    run_operations(spark_session, arg_category, arg_mode, arg_config_name, arg_current_date)
    spark_session.stop()

if __name__ == '__main__':
    main()
