data "aws_canonical_user_id" "current" {
    depends_on = [aws_s3_bucket.ForgTech_bucket]
}

data "aws_iam_policy_document" "S3FullAccess" {
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
      identifiers = [data.aws_canonical_user_id.current.id]  # Grant access to the canonical user ID (your AWS account)
    }
  }
}

# converts the (S3FullAccess) policy document into a reusable AWS IAM policy
resource "aws_iam_policy" "S3FullAccessPolicy" {
    name        = "S3FullAccessPolicy"
    description = "S3 Full Access Policy for bucket"
    policy      = data.aws_iam_policy_document.S3FullAccess.json
    tags = {
        "Environment" = var.tags[0]
        "Owner" = var.tags[1]
    }
}

# converts json policy document into arn for "root" user 
resource "aws_iam_policy_attachment" "S3FullAccess" {
    name       = "Root_S3FullAccess"
    users      = ["root"]
    policy_arn = aws_iam_policy.S3FullAccessPolicy.arn
}