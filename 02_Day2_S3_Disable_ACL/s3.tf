resource "aws_s3_bucket" "ForgTech_bucket" {
  bucket = var.bucket_name
  force_destroy = true  #force destroy even if bucket is not empty
  object_lock_enabled = false
  tags = {
    "Environment" = var.tags[0]
    "Owner" = var.tags[1]
  }
}

resource "aws_s3_bucket_versioning" "name" {
  bucket = aws_s3_bucket.ForgTech_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

#Enable bucket ownership controls 
resource "aws_s3_bucket_ownership_controls" "owner_ship_s3" {
  bucket = aws_s3_bucket.ForgTech_bucket.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  } 
}

#ACL to give full access to the bucket owner
resource "aws_s3_bucket_acl" "ForgTech_bucket_acl" {
  bucket = aws_s3_bucket.ForgTech_bucket.id
  depends_on = [ aws_s3_bucket_ownership_controls.owner_ship_s3 ]
  acl = "private" 
}

/*
two ways to allow upload to /log using :
  1-Bucket Policy for Allowing Uploads to /log by user Mohamed
  2-Attach an inline user policy to allow Mohamed to upload files to the /log directory in s3 bucket
*/

/*
#Bucket Policy for Allowing Uploads to /log by user Mohamed
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.ForgTech_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowUploadToLogDirectory"    # Statement ID (for identification)
        Effect    = "Allow"                        # Allows the action (uploading objects)
        Principal = {
          AWS = aws_iam_user.Mohamed.arn          # The IAM user Mohamed
        }
        Action    = "s3:PutObject"                 # Permission to upload objects (PutObject)
        Resource  = "${aws_s3_bucket.ForgTech_bucket.arn}/log/*"  # Allows access only to the /log directory
      }
    ]
  })
}
*/