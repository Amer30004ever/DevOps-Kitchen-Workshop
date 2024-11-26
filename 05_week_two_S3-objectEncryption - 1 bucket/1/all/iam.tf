
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
