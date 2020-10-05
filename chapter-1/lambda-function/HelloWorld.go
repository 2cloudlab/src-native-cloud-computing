package main

import (
	"context"

	"github.com/aws/aws-lambda-go/lambda"
)

func LambdaHandler(ctx context.Context) (string, error) {
	return "Hello, World!", nil
}

func main() {
	lambda.Start(LambdaHandler)
}
