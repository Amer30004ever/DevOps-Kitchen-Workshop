# Create an S3 bucket
resource "aws_s3_bucket" "ForgTech_logs" {
    bucket = var.bucket_name
    tags = var.common_tags
    object_lock_enabled = false
    force_destroy = true
}

  # Enable versioning
resource "aws_s3_bucket_versioning" "ForgTech_logs_versioning" {
    bucket = aws_s3_bucket.ForgTech_logs.id
    versioning_configuration {
        status = "Enabled"
    }
}

  # Block public access
resource "aws_s3_bucket_public_access_block" "ForgTech_bucket_block_public_access" {
    bucket                  = aws_s3_bucket.ForgTech_logs.id
    block_public_acls       = true # Block ACLs for public
    block_public_policy     = true # Block public bucket policies
    ignore_public_acls      = true # Ignore public ACLs
    restrict_public_buckets = true # Restrict access to only bucket policies
}

  # Enable server-side encryption (SSE-S3)
resource "aws_s3_bucket_server_side_encryption_configuration" "ForgTech_logs_encryption" {
    bucket = aws_s3_bucket.ForgTech_logs.id
    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"  # Use Amazon S3 managed keys
        }
        bucket_key_enabled = true  # Enable bucket key for additional performance
    }
}

# Attach a lifecycle policy to the bucket
resource "aws_s3_bucket_lifecycle_configuration" "ForgTech_logs_lifecycle" {
    bucket = aws_s3_bucket.ForgTech_logs.id
    rule {
        id     = "expiration"
        status = "Enabled"
        filter {
            prefix = "commit_logs/" # This prefix setting specifies that the lifecycle rule only applies to objects in the 
                                    # "commit_logs/" folder within the S3 bucket. Objects outside this prefix are not affected
                                    # by the expiration rule.
        }
        expiration {
            days = 7  # Delete objects after 7 days
        }
    }
}

# Ensure the bucket owner owns all uploaded objects
resource "aws_s3_bucket_ownership_controls" "S3_object_ownership" {
    bucket = aws_s3_bucket.ForgTech_logs.id
    rule {
      object_ownership = "BucketOwnerEnforced" # Ensure bucket owner owns all objects
    }
}
