from datetime import date
import boto3
import os

def lambda_handler(event, context):

    table_name = os.environ['dynamodb_table']
    mode = event['Mode']
    data = event['Data']

    dynamodb = boto3.resource('dynamodb')
    bookmark_table = dynamodb.Table(table_name)

    current_date = date.today().strftime("%Y-%m-%d")

    for trend in data.keys():
        for product in data[trend].keys():
            if data[trend][product]['execute']:
                item = {
                    "Mode"              : mode,
                    "Category"          : f"{trend} - {product}",
                    "execution_date"    : current_date,
                    "reference_date"    : data[trend][product]['reference_date'],
                    "model"             : data[trend][product]['model']
                }

                bookmark_table.put_item(Item = item)


    return {'Success':True}