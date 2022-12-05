# import Boto3 exceptions and error handling module
from botocore.exceptions import ClientError
import os
import boto3  # import Boto3


def get_device(device_id, datacount, dynamodb=None):
    dynamodb = boto3.resource(
        'dynamodb',
        aws_access_key_id=os.environ["AWS_ACCESS_KEY"],
        aws_secret_access_key=os.environ["AWS_SECRET_ACCESS_KEY"]
    )

    devices_table = dynamodb.Table('Devices')

    try:
        response = devices_table.get_item(
            Key={'device_id': device_id, 'datacount': datacount})
    except ClientError as e:
        print(e.response['Error']['Message'])
    else:
        return response['Item']


if __name__ == '__main__':
    device = get_device("10001", 3,)
    if device:
        print("Get Device Data Done:")
        # Print the data read
        print(device)
    else:
        print('could not find data')
