import json  # module for converting Python objects to JSON
import os
# decimal module support correctly-rounded decimal floating point arithmetic.
from decimal import Decimal
import boto3  # import Boto3


def load_data(devices, dynamodb=None):
    dynamodb = boto3.resource(
        'dynamodb',
        aws_access_key_id=os.environ["AWS_ACCESS_KEY"],
        aws_secret_access_key=os.environ["AWS_SECRET_ACCESS_KEY"]
    )

    devices_table = dynamodb.Table('Devices')
    # Loop through all the items and load each
    for device in devices:
        device_id = (device['device_id'])
        datacount = device['datacount']
        # Print device info
        print("Loading Devices Data:", device_id, datacount)
        devices_table.put_item(Item=device)


if __name__ == '__main__':
    # open file and read all the data in it
    with open("data.json") as json_file:
        device_list = json.load(json_file, parse_float=Decimal)
    load_data(device_list)
