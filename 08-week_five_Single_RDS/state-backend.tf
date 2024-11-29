terraform {
    backend "s3" {
        bucket = "s3-bucket-from-terraform"
        key = "terraform.tfstate"
        region = "us-east-1"
        dynamodb_table = "terraform-backend-lock"
        encrypt = true
    }
}