
data "aws_canonical_user_id" "Owner" {
  depends_on = [aws_s3_bucket.ForgTech_bucket, aws_s3_bucket.backend_bucket]
}

# ForgTech_bucket_policy

# IAM Role for EC2 instances
resource "aws_iam_role" "ForgTech_bucket_access_role" {
  name = "ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}

# IAM Policy document for full access to the ForgTech S3 bucket
data "aws_iam_policy_document" "S3FullAccess_document_ForgTech_bucket" {
  version = "2012-10-17"
  statement {
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = [
      "${aws_s3_bucket.ForgTech_bucket.arn}",
      "${aws_s3_bucket.ForgTech_bucket.arn}/*"
    ]
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.ec2_role.arn]  # Grant access to the EC2 instance role
    }
  }
}

# Convert the policy document into a reusable AWS IAM policy
resource "aws_iam_policy" "S3FullAccessPolicy_ForgTech_bucket" {
  name        = "S3FullAccessPolicy"
  description = "S3 Full Access Policy for ForgTech bucket"
  policy      = data.aws_iam_policy_document.S3FullAccess_document_ForgTech_bucket.json
  tags = {
    "Environment" = var.tags[0]
    "Owner"       = var.tags[1]
  }
}

# Attach the S3 Full Access Policy to the EC2 role
resource "aws_iam_role_policy_attachment" "ec2_s3_full_access" {
  policy_arn = aws_iam_policy.S3FullAccessPolicy_ForgTech_bucket.arn
  role       = aws_iam_role.ForgTech_bucket_access_role.name
}

# backend_bucket_policy

# IAM Policy document for full access to the backend S3 bucket
data "aws_iam_policy_document" "S3FullAccess_document_backend_bucket" {
  version = "2012-10-17"
  statement {
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = [
      "${aws_s3_bucket.backend_bucket.arn}",
      "${aws_s3_bucket.backend_bucket.arn}/*"
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::*:role/ec2-*"]  # Allows access from any EC2 instance role that starts with "ec2-"
    }
  }
}

# Convert the policy document into a reusable AWS IAM policy for backend S3 bucket
resource "aws_iam_policy" "S3FullAccessPolicy_backend_bucket" {
  name        = "S3FullAccessPolicy"
  description = "S3 Full Access Policy for backend S3 bucket"
  policy      = data.aws_iam_policy_document.S3FullAccess_document_backend_bucket.json
  tags = {
    "Environment" = var.tags[0]
    "Owner"       = var.tags[1]
  }
}

# Attach the S3FullAccessPolicy_backend_bucket Policy to the ForgTech_bucket_access_role
resource "aws_iam_role_policy_attachment" "ec2_s3_full_access_backend" {
  policy_arn = aws_iam_policy.S3FullAccessPolicy_backend_bucket.arn
  role       = aws_iam_role.ForgTech_bucket_access_role.name
}
# converts json policy document into arn for "root" user 
# Add a policy for the root user (xx in production)
resource "aws_iam_policy_attachment" "root_S3FullAccess_ForgTech_bucket" {
  name       = "Root_S3FullAccess_ForgTech"
  users      = ["root"]  # Attach the policy to the root user for administrative access
  policy_arn = aws_iam_policy.S3FullAccessPolicy_ForgTech_bucket.arn
}

# converts json policy document into arn for "root" user 
# Add a policy for the root user
resource "aws_iam_policy_attachment" "root_S3FullAccess_backend_bucket" {
  name       = "Root_S3FullAccess_backend"
  users      = ["root"]  # Attach the policy to the root user for administrative access
  policy_arn = aws_iam_policy.S3FullAccessPolicy_backend_bucket.arn
}
