provider "aws" {
  region = "us-east-1"
}

# Local values for common properties
locals {
  environment = var.environment
  owner       = var.owner
  common_tags = {
    Environment = local.environment
    Owner       = local.owner
  }
}

# Variables for dynamic input
variable "environment" {
  default = "terraformChamps"
}

variable "owner" {
  default = "Amer"
}

# Reusable S3 bucket module
module "external_bucket" {
  source      = "./modules/s3_bucket"
  bucket_name = "frogtech-us-external"
  tags        = local.common_tags
}

module "internal_bucket" {
  source      = "./modules/s3_bucket"
  bucket_name = "frogtech-us-internal"
  tags        = local.common_tags
}

# IAM Role for Lambda
module "lambda_role" {
  source = "./modules/lambda_role"
  tags   = local.common_tags
}

# Lambda function setup
module "lambda_function" {
  source         = "./modules/lambda_function"
  function_name  = "s3_copy_lambda_function"
  source_bucket  = module.external_bucket.bucket_id
  dest_bucket    = module.internal_bucket.bucket_id
  lambda_role_arn = module.lambda_role.role_arn
  tags           = local.common_tags
}

# Allow S3 to trigger Lambda
resource "aws_lambda_permission" "allow_s3_trigger" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_function.lambda_function_name
  principal     = "s3.amazonaws.com"
  source_arn    = module.external_bucket.bucket_arn
}

# S3 bucket notification to trigger Lambda
resource "aws_s3_bucket_notification" "s3_notification" {
  bucket = module.external_bucket.bucket_id

  lambda_function {
    lambda_function_arn = module.lambda_function.lambda_function_arn
    events              = ["s3:ObjectCreated:*"]
  }
}
