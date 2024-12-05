
#

# Terraform resources

# Source S3 bucket
resource "aws_s3_bucket" "source" {
  bucket = "XXXXXXXXXXXXXXXXXXXX"
}

# Destination S3 bucket
resource "aws_s3_bucket" "destination" {
  bucket = "XXXXXXXXXXXXXXXXXXXX"
}

# IAM role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "s3_copy_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# IAM policy for the Lambda role
resource "aws_iam_role_policy" "lambda_policy" {
  name = "s3_copy_lambda_policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:CopyObject"
        ]
        Resource = [
          "${aws_s3_bucket.source.arn}/*",
          "${aws_s3_bucket.destination.arn}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

# Lambda function
resource "aws_lambda_function" "s3_copy" {
  filename         = "lambda_function.zip"
  function_name    = "s3_copy_function"
  role            = aws_iam_role.lambda_role.arn
  handler         = "lambda_function.lambda_handler"
  runtime         = "python3.9"

  environment {
    variables = {
      SOURCE_BUCKET = aws_s3_bucket.source.id
      DEST_BUCKET  = aws_s3_bucket.destination.id
    }
  }
}

# S3 bucket notification to trigger Lambda
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.source.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_copy.arn
    events              = ["s3:ObjectCreated:*"]
  }
}

# Lambda permission to allow S3 to invoke the function
resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_copy.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.source.arn
}

data "archive_file" "zip_the_python_code" {
  type        = "zip" # Specify the archive type as ZIP
  source_dir  = "/" # Specify the source directory for the code
  output_path = "function.zip" # Specify the output path for the ZIP file
}