import boto3
import json

SF_CLIENT = boto3.client('stepfunctions')
SSM_CLIENT = boto3.client("ssm")
          
def lambda_handler(event, context):
    print("Starting state machine")

    SF_CLIENT.start_execution(
    stateMachineArn='arn:aws:states:eu-west-1:859662211748:stateMachine:dev-demostepfunction'
    )
    
    print("State machine started")
