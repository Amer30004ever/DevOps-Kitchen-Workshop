# Configure backend for storing Terraform state in S3
terraform {
  backend "s3" {
    bucket         = "forgtech-logs-bucket" # Replace with your S3 bucket for state
    key            = "terraform/state"         # State file location in the bucket
    region         = "eu-central-1"               # Backend bucket region
    encrypt        = true                      # Encrypt the state file
  }
}
