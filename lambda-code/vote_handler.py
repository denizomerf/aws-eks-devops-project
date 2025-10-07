import json
import os
import uuid
import boto3
from datetime import datetime 

dynamodb = boto3.resource('dynamodb')
TABLE_NAME = os.environ.get('DYNAMODB_TABLE_NAME')
table = dynamodb.Table(TABLE_NAME)

def lambda_handler(event, context):
    try:
        body = json.loads(event.get('body', '{}'))
        poll_id = body.get('poll_id')
        option_id = body.get('option_id')

        if not poll_id or not option_id:
            return {
                'statusCode': 400,
                'headers': { 'Access-Control-Allow-Origin': '*' },
                'body': json.dumps({'message': 'poll_id and option_id are required'})
            }

        vote_id = str(uuid.uuid4())
        timestamp = datetime.utcnow().isoformat()

        item_to_save = {
            'vote_id': vote_id,
            'poll_id': poll_id,
            'option_id': option_id,
            'created_at': timestamp
        }
        
        table.put_item(Item=item_to_save)

        return {
            'statusCode': 201,
            'headers': { 'Access-Control-Allow-Origin': '*' },
            'body': json.dumps({
                'message': 'Vote recorded successfully',
                'vote': item_to_save
            })
        }

    except Exception as e:
        print(f"Error: {e}")
        return {
            'statusCode': 500,
            'headers': { 'Access-Control-Allow-Origin': '*' },
            'body': json.dumps({'message': f'An error occurred: {str(e)}'})
        }