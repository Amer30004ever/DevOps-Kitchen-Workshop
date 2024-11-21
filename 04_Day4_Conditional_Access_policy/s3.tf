resource "aws_s3_bucket" "ForgTech_bucket" {
  bucket = "ForgTech_bucket"
  force_destroy = true
  tags = {
    "Environment" = var.tags[0]
    "Owner"       = var.tags[1]
  }
}

