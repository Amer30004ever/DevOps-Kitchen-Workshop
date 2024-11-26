#backend_bucket
resource "aws_s3_bucket" "backend_bucket" {
    bucket = var.backend_bucket_name
    tags = {
        "Environment" = var.tags[0]
        "Owner" = var.tags[1]
    }
    object_lock_enabled = false
}

resource "aws_s3_bucket_acl" "backend_bucket_acl" {
    depends_on = [aws_s3_bucket_ownership_controls.backend_bucket_ownership]
    bucket = aws_s3_bucket.backend_bucket.id
    access_control_policy {
        grant {
            grantee {
                id   = data.aws_canonical_user_id.Owner.id
                type = "CanonicalUser"
            }
            permission = "FULL_CONTROL"
        }
        owner {
            id = data.aws_canonical_user_id.Owner.id
        }
    }
}

resource "aws_s3_bucket_ownership_controls" "backend_bucket_ownership" {
    bucket = aws_s3_bucket.backend_bucket.id
    rule {
      object_ownership = "BucketOwnerEnforced"
    }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "backend_bucket_encryption" {
    bucket = aws_s3_bucket.backend_bucket.id
    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
        bucket_key_enabled = true
    }
}

resource "aws_s3_bucket_versioning" "backend_bucket_versioning" {
    bucket = aws_s3_bucket.backend_bucket.id
    versioning_configuration {
        status = "Enabled"
    }
}