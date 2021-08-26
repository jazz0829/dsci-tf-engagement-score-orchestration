from datetime import datetime
import boto3
import traceback
import json
import os
import re
from functools import reduce


def set_param_value(d, field, value):
    ''' set dict param, for each category-product with a same value '''
    for category in d:
        for product in d[category]:
            d[category][product][field] = value
    return d
    
def get_mode(event):
    return event['mode']
    
    
def get_last_update_lake(s3_client, path_domain):
    ''' get field last update lake, for each category-product with a same value '''
    curr_date = datetime.now()
    response = s3_client.list_objects_v2(
        Bucket= path_domain,
        Delimiter='/part',
        MaxKeys=1000,
        Prefix='Data/ActivityDaily/',
        FetchOwner=True,
        StartAfter='Data/ActivityDaily/year={}'.format(curr_date.year-1))
    pattern = r'.+year=(\d+)\/month=(\d+)\/day=(\d+)\/.+'
    list_str = reduce(lambda y, x: y + re.findall(pattern, x.get('Prefix')), response.get('CommonPrefixes'), [])
    last_update = max([datetime(*(int(x) for x in y)) for y in list_str]).strftime("%Y-%m-%d")
    return last_update

def get_product_model(product, category, s3, path_model):
    ''' get a singel previous trained model based on category and product '''
    key_prefix = 'artifacts/{}/{}/'.format(product, category)
    curr_date = datetime.now()
    response = s3.list_objects_v2(
        Bucket=path_model,
        Delimiter='/model',
        MaxKeys=1000,
        Prefix=key_prefix,
        FetchOwner=True,
        StartAfter='{}{}'.format(key_prefix, curr_date.year-1))
    items_found = response.get('CommonPrefixes')
    if items_found:
        list_key = [x.get('Prefix') for x in items_found]
        latest_model = 's3://{}/{}'.format(path_model, max(list_key))
        return latest_model
    else:
        return None
        
def get_last_models(d, s3, path_model):
    ''' get all the previous trained model based on category-product pair '''
    for category in d:
        for product in d[category]:
            d[category][product]['prev_model'] = get_product_model(product, category, s3, path_model)
    return d
    
def get_prev_execution(bookmark_table, mode):
    categories = ['churn', 'downgrade']
    products = ['accounting_established', 'accounting_onboarding', 'accountancy', 'manufacturing', 'professional_services', 'wholesale_distribution']
    
    prev_executions = {}
    
    for category in categories:
        for product in products:
            response = bookmark_table.get_item(Key = {'Mode' : mode, 'Category': category + '-' + product})
            
            if ("Item" in response):
                prev_executions.update({category + '-' + product : response['Item']['Execution Date']})
            
            
    return prev_executions
    
def get_execution_flag(params, d_prev):
    
    for key, date in d_prev.items():

        split_key = key.split("-")
        
        if(params[split_key[0]][split_key[1]]['reference_date'] <= date):
            params[split_key[0]][split_key[1]]['execute'] = False
    return params
def lambda_handler(event, context):
    s3 = boto3.client('s3')
    dynamodb = boto3.resource('dynamodb', region_name='eu-west-1')
    bookmark_table = dynamodb.Table(event['dynamo'])
    
    params = {
        'churn': {
            'accounting_established':{'execute': True},
            'accounting_onboarding':{'execute': True},
            'accountancy':{'execute': True},
            'manufacturing':{'execute': True},
            'professional_services':{'execute': True},
            'wholesale_distribution':{'execute': True}
        },
        'downgrade': {
            'accounting_established':{'execute': True},
            'accounting_onboarding':{'execute': True},
            'accountancy':{'execute': True},
            'manufacturing':{'execute': True},
            'professional_services':{'execute': True},
            'wholesale_distribution':{'execute': True}
        }
    }
    
    mode = get_mode(event)
    last_update = get_last_update_lake(s3, event['path_domain'])
    d_prev = get_prev_execution(bookmark_table, mode)
    params = set_param_value(params, 'mode', mode)
    params = set_param_value(params, 'reference_date', last_update)
    params = get_last_models(params, s3, event['path_model'])
    params = get_execution_flag(params, d_prev)
    return params
