resource "aws_apigatewayv2_api" "main" {
  name          = "InsightPoll-HttpApi"
  protocol_type = "HTTP"
  cors_configuration {
    allow_origins = ["*"] # Tüm domainlerden gelen isteklere izin ver (geliştirme için)
    allow_methods = ["POST", "GET", "OPTIONS"]
    allow_headers = ["Content-Type"]
  }
}

resource "aws_apigatewayv2_integration" "lambda" {
  api_id           = aws_apigatewayv2_api.main.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.vote_handler.invoke_arn
}

resource "aws_apigatewayv2_route" "vote" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "POST /vote" # Sadece POST isteklerini kabul et
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.main.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.vote_handler.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.main.execution_arn}/*/*"
}