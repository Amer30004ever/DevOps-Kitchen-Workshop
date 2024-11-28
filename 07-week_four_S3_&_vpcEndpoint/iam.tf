#ec2 full access on s3 bucket
resource "aws_iam_role" "ec2_access_role" {
    name = "ec2_full_access_s3"
    assume_role_policy = jsonencode ({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]
    })
    tags = var.common_tags
}

data "aws_iam_policy_document" "s3_full_access_document" {
    statement {
      actions = ["s3:*"]
      resources = ["${aws_s3_bucket.ForgTech_logs.arn}"]
    }
}

resource "aws_iam_policy" "s3_full_access_policy" {
    name = "s3_full_access_policy"
    policy = data.aws_iam_policy_document.s3_full_access_document.json
    tags = var.common_tags
}

resource "aws_iam_role_policy_attachment" "s3_full_access_attachment" {
    role = aws_iam_role.ec2_access_role.name
    policy_arn = aws_iam_policy.s3_full_access_policy.arn
}