resource "aws_s3_bucket" "ForgTech_logs" {
    bucket = var.bucket_name
    object_lock_enabled = false
    tags = var.common_tags
    force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "ForgTech_ownership" {
    bucket = aws_s3_bucket.ForgTech_logs.id
    rule {
      object_ownership = "BucketOwnerEnforced"
    }

}

resource "aws_s3_bucket_public_access_block" "ForgTech_block_public_access" {
    bucket = aws_s3_bucket.ForgTech_logs.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "ForgTech_versioning" {
    bucket = aws_s3_bucket.ForgTech_logs.id
    versioning_configuration {
      status = "Enabled"
    }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "ForgTech_encryption" {
    bucket = aws_s3_bucket.ForgTech_logs.id
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = true
    }
}