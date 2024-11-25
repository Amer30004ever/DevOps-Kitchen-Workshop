resource "aws_s3_bucket" "ForgTech_bucket" {
    bucket = var.bucket_name
    tags = {
        "Environment" = var.tags[0]
        "Owner" = var.tags[1]
    }
    object_lock_enabled = true
}

resource "aws_s3_bucket_ownership_controls" "S3_ownership" {
    bucket = aws_s3_bucket.ForgTech_bucket.id
    rule {
      object_ownership = "BucketOwnerEnforced"
    }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
    bucket = aws_s3_bucket.ForgTech_bucket.id
    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
        bucket_key_enabled = true
    }
}

resource "aws_s3_bucket_acl" "acl" {
    depends_on = [aws_s3_bucket_ownership_controls.S3_ownership]
    bucket = aws_s3_bucket.ForgTech_bucket.id
    access_control_policy {
        grant {
            grantee {
                id   = data.aws_canonical_user_id.current.id
                type = "CanonicalUser"
            }
            permission = "FULL_CONTROL"
        }
        owner {
            id = data.aws_canonical_user_id.current.id
        }
    }
}

resource "aws_s3_bucket_versioning" "versioning" {
    bucket = aws_s3_bucket.ForgTech_bucket.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
    bucket = aws_s3_bucket.ForgTech_bucket.id
    rule {
        id     = "expiration"
        status = "Enabled"
        filter {
            prefix = "commit_logs/"
        }
        expiration {
            days = 7
        }
    }
}


