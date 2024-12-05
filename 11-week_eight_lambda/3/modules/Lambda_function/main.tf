resource "aws_lambda_function" "lambda" {
  filename      = "${path.module}/function.zip"
  function_name = var.function_name
  role          = var.lambda_role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"

  environment {
    variables = {
      SOURCE_BUCKET = var.source_bucket
      DEST_BUCKET   = var.dest_bucket
    }
  }

  tags = var.tags
}

data "archive_file" "zip_the_python_code" {
  type        = "zip"
  source_dir  = "${path.module}/lambda_code/"
  output_path = "${path.module}/function.zip"
}

output "lambda_function_name" {
  value = aws_lambda_function.lambda.function_name
}

output "lambda_function_arn" {
  value = aws_lambda_function.lambda.arn
}
