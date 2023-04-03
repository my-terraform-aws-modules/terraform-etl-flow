
# def lambda_handler(event,context):
#     print(event)
    

import json
import boto3

def lambda_handler(event, context):
    dynamodb = boto3.client('dynamodb')

    table_name = 'dev-demoddb'
    item = {
        'UserId': {'S': 'demouser'},
        'name': {'S': 'jane'},
        
    }

    dynamodb.put_item(TableName=table_name, Item=item)

    return {
        'statusCode': 200,
        'body': 'Data inserted successfully!'
    }