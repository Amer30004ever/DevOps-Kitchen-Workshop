provider "aws" {
    region = "us-east-1"
}

/*

terraform {
  backend "s3" {
    bucket         = "your-s3-bucket-name"
    key            = "path/to/terraform/state"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "your-lock-table"  # optional for state locking
  }
}
*/
