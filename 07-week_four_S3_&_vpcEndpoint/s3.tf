resource "aws_s3_bucket" "ForgTech_log_bucket" {
    bucket = var.bucket_name
    object_lock_enabled = false
}

resource "aws_s3_bucket_ownership_controls" "ForgTech_log_bucket_ownership" {
    bucket = aws_s3_bucket.ForgTech_bucket.id
    rule {
        object_ownership = "BucketOwnerEnforced" #the bucket owner owns all the objects
    }
}

resource "aws_s3_bucket_public_access_block" "ForgTech_log_bucket_public_access" {
    bucket = aws_s3_bucket.ForgTech_log_bucket.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "ForgTech_log_bucket__versioning" {
    bucket = aws_s3_bucket.ForgTech_log_bucket.id
    versioning_configuration {
        status = "Enabled"
    }
}