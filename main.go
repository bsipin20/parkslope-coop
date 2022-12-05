
package main


import (
	"context"
	"fmt"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/aws/aws-sdk-go-v2/aws"
//	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
//	"github.com/pkg/errors"
)

func create_table() {
	cfg, err := config.LoadDefaultConfig(context.TODO(), func(opts *config.LoadOptions) error {
		opts.Region = "us-east-1"
		return nil
	})
	if err != nil {
		panic(err)
	}

	svc := dynamodb.NewFromConfig(cfg)
	out, err := svc.CreateTable(context.TODO(), &dynamodb.CreateTableInput{
		AttributeDefinitions: []types.AttributeDefinition{
			{
				AttributeName: aws.String("id"),
				AttributeType: types.ScalarAttributeTypeS,
			},
		},
		KeySchema: []types.KeySchemaElement{
			{
				AttributeName: aws.String("id"),
				KeyType:       types.KeyTypeHash,
			},
		},
		TableName:   aws.String("groceries"),
		BillingMode: types.BillingModePayPerRequest,
	})
	if err != nil {
		panic(err)
	}
	fmt.Println(out)
}

func main() {
	create()
}


