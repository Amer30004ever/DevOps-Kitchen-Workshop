resource "aws_s3_bucket" "ForgTech_bucket" {
  bucket = var.bucket_name
  force_destroy = true  #force destroy even if bucket is not empty
  tags = {
    "Environment" = var.tags[0]
    "Owner"       = var.tags[1]
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle_1" {
  bucket = aws_s3_bucket.ForgTech_bucket.id
  # Rules for /log directory
  rule {
    id     = "ForgetTech_bucket_lifecycle_configuration_1"
    status = "Enabled"
    filter {
      prefix = "/log"  # Apply to /log directory
    }
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    transition {
      days = 90
      storage_class = "GLACIER"
    }
    transition {
      days = 180
      storage_class = "DEEP_ARCHIVE"
    }
    expiration {  #Remove files after 365 days
      days = 365
    }
  }

  # Rules for /outgoing directory
  rule {
    id = "ForgetTech_bucket_lifecycle_configuration_2"
    status = "Enabled"
    filter {
      prefix = "/outgoing"  # Apply to /outgoing directory
      tag {
        key = "storage_class"
        value = "notDeepArchive"
      }
    }
    transition {
      days = 30
      storage_class = "STANDARD_IA"
    }
    transition {
      days = 90
      storage_class = "GLACIER"
    }
  }

  # Rules for /incoming directory
  rule {
    id = "ForgetTech_bucket_lifecycle_configuration_3"
    status = "Enabled"
    filter {
      prefix = "/incoming" # Apply to /incoming directory
      object_size_greater_than = 1048576 # 1MB
      object_size_less_than = 1073741824 # 1GB
    }
    transition {
      days = 30
      storage_class = "STANDARD_IA"
    }
    transition {
      days = 90
      storage_class = "GLACIER"
    }
  }
}

