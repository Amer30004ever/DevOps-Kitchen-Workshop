# Specify the AWS provider and region to use
provider "aws" {
  region = "us-east-1" # Set the AWS region to us-east-1
}

# Define variables for Environment and Owner tags
variable "environment" {
  default = "terraformChamps" # Default value for the Environment tag
}

variable "owner" {
  default = "Amer" # Replace with your first name
}

# Create the external S3 bucket
resource "aws_s3_bucket" "external_bucket" {
  bucket        = "frogtech-us-external" # The name of the source bucket
  force_destroy = true                   # Allow Terraform to destroy the bucket even if it's not empty
  tags = {
    Environment = var.environment # Add the Environment tag
    Owner       = var.owner       # Add the Owner tag
  }
}

# Create the internal S3 bucket
resource "aws_s3_bucket" "internal_bucket" {
  bucket        = "frogtech-us-internal" # The name of the destination bucket
  force_destroy = true                   # Allow Terraform to destroy the bucket even if it's not empty
  tags = {
    Environment = var.environment # Add the Environment tag
    Owner       = var.owner       # Add the Owner tag
  }
}

# Policy document for allowing Lambda to assume the role
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"] # Allow the Lambda service to assume this role
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"] # Specify the Lambda service
    }
  }
}

# Define the IAM role for the Lambda function
resource "aws_iam_role" "lambda_execution_role" {
  name               = "lambda_execution_role"                              # Name of the IAM role
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json # Use the assume role policy defined below

  tags = {
    Environment = var.environment # Add the Environment tag
    Owner       = var.owner       # Add the Owner tag
  }
}

# Create the Lambda function
resource "aws_lambda_function" "s3_copy_function" {
  filename      = "${path.module}/lambda_function/function.zip" # The deployment package (ZIP file) containing the Lambda code
  function_name = "s3_copy_lambda_function"                              # The name of the Lambda function
  role          = aws_iam_role.lambda_execution_role.arn        # Attach the IAM role to the Lambda function
  handler       = "lambda_function.lambda_handler"              # Entry point of the Lambda function
  runtime       = "python3.9"                                   # Specify the runtime for the Lambda function

  # Define environment variables for the Lambda function
  environment {
    variables = {
      SOURCE_BUCKET = aws_s3_bucket.external_bucket.id # Set the source bucket
      DEST_BUCKET   = aws_s3_bucket.internal_bucket.id # Set the destination bucket
    }
  }

  tags = {
    Environment = var.environment # Add the Environment tag
    Owner       = var.owner       # Add the Owner tag
  }
}

# Allow S3 to invoke the Lambda function
resource "aws_lambda_permission" "allow_s3_trigger" {
  statement_id  = "AllowS3Invoke"                                    # A unique identifier for this permission
  action        = "lambda:InvokeFunction"                            # Allow Lambda to be invoked
  function_name = aws_lambda_function.s3_copy_function.function_name # Specify the Lambda function
  principal     = "s3.amazonaws.com"                                 # Specify S3 as the principal that can invoke the Lambda function

  source_arn = aws_s3_bucket.external_bucket.arn # Restrict access to the external bucket
}

# Set up S3 bucket notifications to trigger the Lambda function
resource "aws_s3_bucket_notification" "s3_notification" {
  bucket = aws_s3_bucket.external_bucket.id # Specify the bucket for notifications

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_copy_function.arn # Specify the Lambda function ARN
    events              = ["s3:ObjectCreated:*"]                   # Trigger the function for all object creation events
  }
}

data "archive_file" "zip_the_python_code" {
  type        = "zip"                                         # Specify the archive type as ZIP
  source_dir  = "${path.module}/lambda_function/"             # Specify the source directory for the code
  output_path = "${path.module}/lambda_function/function.zip" # Specify the output path for the ZIP file

}