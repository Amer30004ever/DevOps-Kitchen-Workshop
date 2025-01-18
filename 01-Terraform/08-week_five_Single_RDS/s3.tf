resource "aws_s3_bucket" "name" {
    bucket = var.bucket_name
    force_destroy = true
    tags = var.tags
}