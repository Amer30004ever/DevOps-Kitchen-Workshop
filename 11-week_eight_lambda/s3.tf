resource "aws_s3_bucket" "ForgTech_bucket" {
    bucket = "ForgTech_bucket"
    force_destroy = true
}