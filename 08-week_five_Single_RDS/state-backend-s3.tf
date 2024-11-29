terraform {
    backend "s3" {
        bucket = "s3-bucket-from-terraform"
        key = "terraform.tfstate"
        tags = var.tags
    }
}