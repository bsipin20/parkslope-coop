import boto3  # import Boto3
import os
"""
Usage examples for `DynamoTable` class.
"""
from typing import Optional

import boto3
#from mypy_boto3_dynamodb.service_resource import DynamoDBServiceResource, Table

from dynamo_query.dictclasses.dynamo_dictclass import DynamoDictClass
from dynamo_query.dynamo_table import DynamoTable
from dynamo_query.dynamo_table_index import DynamoTableIndex




def create_devices_table(dynamodb=None):
    dynamodb = boto3.resource(
        'dynamodb',
        aws_access_key_id=os.environ["AWS_ACCESS_KEY"],
        aws_secret_access_key=os.environ["AWS_SECRET_ACCESS_KEY"]
    )

    # Table defination
    table = dynamodb.create_table(
        TableName='Grocery',
        KeySchema=[
            {
                'AttributeName': 'idid',
                'KeyType': 'HASH'  # Partition key
            },
        ],
        AttributeDefinitions=[
            {
                'AttributeName': 'dateid',
                # AttributeType defines the data type. 'S' is string type and 'N' is number type
                'AttributeType': 'S'
            },
            {
                'AttributeName': 'datacount',
                'AttributeType': 'N'
            },
        ],
        ProvisionedThroughput={
            # ReadCapacityUnits set to 10 strongly consistent reads per second
            'ReadCapacityUnits': 10,
            'WriteCapacityUnits': 10  # WriteCapacityUnits set to 10 writes per second
        }
    )
    return table


class GroceryItem(DynamoDictClass):
    date: str
    item_str:str
    price: float

#    @DynamoDictClass.compute_key("pk")
#    def get_pk(self) -> str:
#        return self.project_id

#    @DynamoDictClass.compute_key("sk")
#    def get_sk(self) -> str:
#        return self.company


class GroceryTable(DynamoTable[GroceryItem]):
#    gsi_name_age = DynamoTableIndex("name_age", "name", "age", sort_key_type="N")
#    global_secondary_indexes = [gsi_name_age]
    record_class = GroceryItem

    read_capacity_units = 50
    write_capacity_units = 10

    @property
    def table(self):# -> Table:
        resource = boto3.resource(
            'dynamodb',
            aws_access_key_id=os.environ["AWS_ACCESS_KEY"],
            aws_secret_access_key=os.environ["AWS_SECRET_ACCESS_KEY"]
        )

        return resource.Table("groceries_table")  # pylint: disable=no-member


def main() -> None:
    user_dynamo_table = GroceryTable()
#    user_dynamo_table.create_table()
#    user_dynamo_table.wait_until_exists()
#    user_dynamo_table.clear_table()

    user_dynamo_table.batch_upsert_records(
        [
            GroceryItem(
                date="2022-10-03",
                item_str="apples",
                price=4.0
            ),
            GroceryItem(
                date="2022-10-04",
                item_str="apples",
                price=5.5
            ),
        ]
    )

    print("Get all records:")
    for user_record in user_dynamo_table.scan():
        print(user_record)

    print("Get John's record:")
    print(
        user_dynamo_table.get_record(
            UserRecord({"item_str": "applies"})
        )
    )

#    print("Query by a specific index:")
#    print(
#        list(
#            user_dynamo_table.query(
#                index=UserDynamoTable.gsi_name_age, partition_key="Mary", sort_key=34
#            )
#        )
#    )

#    print("Using iterators for batch methods:")
#    record = UserRecord({"email": "john_student@gmail.com", "company": "IBM"})
#    for full_record in user_dynamo_table.batch_get_records((i for i in [record])):
#        print(full_record)

#    user_dynamo_table.batch_upsert_records([record])
#    user_dynamo_table.batch_delete_records((i for i in [record]))


if __name__ == "__main__":
    main()
_
