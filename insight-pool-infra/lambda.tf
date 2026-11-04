
resource "aws_iam_role" "lambda_exec_role" {
  name = "InsightPoll-LambdaExecRole"


  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


resource "aws_iam_role_policy" "lambda_dynamodb_policy" {
  name = "InsightPoll-LambdaDynamoDBPolicy"
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "dynamodb:PutItem"
        ],
        Effect   = "Allow",
        Resource = aws_dynamodb_table.votes.arn
      }
    ]
  })
}


data "archive_file" "vote_handler_zip" {
  type        = "zip"
  source_dir  = "../lambda-code/"
  output_path = "${path.module}/vote_handler.zip"
}

resource "aws_lambda_function" "vote_handler" {
  function_name    = "InsightPoll-VoteHandler"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "vote_handler.lambda_handler"
  runtime          = "python3.11"
  filename         = data.archive_file.vote_handler_zip.output_path
  source_code_hash = data.archive_file.vote_handler_zip.output_base64sha256

  environment {
    variables = {

      DYNAMODB_TABLE_NAME = aws_dynamodb_table.votes.name
    }
  }
}