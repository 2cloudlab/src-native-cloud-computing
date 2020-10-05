terraform {
  required_version = "= 0.12.19"
}

provider "aws" {
  region = "ap-northeast-1"
}

locals {
  function_name = "HelloWorld"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "test_harness_lambda" {
  filename         = "${local.function_name}.zip"
  function_name    = local.function_name
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = local.function_name
  timeout          = 300 #in seconds
  memory_size      = 128
  source_code_hash = filebase64sha256("${local.function_name}.zip")
  runtime          = "go1.x"
}