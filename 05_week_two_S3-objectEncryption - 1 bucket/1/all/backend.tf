terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
   backend "s3" {
        bucket = "ForgTech_bucket" #bucket name
        key    = "terraform.tfstate" #the path where the state file will be stored in the S3 bucket
        region = "us-east-1"
        encrypt = true
        profile = "amer"

    } 
}

