
output "ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = aws_ecr_repository.poll_api.repository_url
}
output "fluent_bit_role_arn" {
  description = "The ARN of the IAM role for Fluent Bit"
  value       = aws_iam_role.fluent_bit_role.arn
}
output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.main.address
}

output "db_password_secret_arn" {
  description = "The ARN of the Secrets Manager secret for the DB password"
  value       = aws_secretsmanager_secret.db_password.arn
}

output "api_endpoint_url" {
  description = "The invoke URL for the API Gateway"
  value       = aws_apigatewayv2_api.main.api_endpoint
}

output "frontend_bucket_name" {
 description  = "S3 bucket"
 value = aws_s3_bucket.frontend.bucket 
}