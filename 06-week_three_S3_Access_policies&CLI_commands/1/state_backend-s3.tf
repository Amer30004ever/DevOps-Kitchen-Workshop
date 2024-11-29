terraform {
  backend "s3" {
    bucket = "forgtech-logs-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}