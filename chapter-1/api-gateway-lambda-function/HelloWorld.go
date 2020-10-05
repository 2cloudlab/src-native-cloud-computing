package main

import (
	"encoding/json"
	"net/http"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

type Response struct {
	MSG string `json:"msg"`
}

func LambdaHandler(events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	res := &Response{
		MSG: "Hello, World!",
	}
	js, _ := json.Marshal(res)
	return events.APIGatewayProxyResponse{
		StatusCode: http.StatusOK,
		Body:       string(js),
	}, nil
}

func main() {
	lambda.Start(LambdaHandler)
}
