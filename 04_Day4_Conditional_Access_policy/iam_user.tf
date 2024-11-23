resource "aws_iam_user" "Ahmed" {
  name = var.iam_user[0]
  tags = {
    "Environment" = var.tags[0]
    "Owner"       = var.tags[1]
  }
}

# Mahmoud: External user with restricted IP-based S3 access
resource "aws_iam_user" "Mahmoud" {
  name = var.iam_user[1]
  tags = {
    "Environment" = var.tags[0]
    "Owner"       = var.tags[1]
  }
}

resource "aws_iam_user" "Mostafa" {
  name = var.iam_user[2]
  tags = {
    "Environment" = var.tags[0]
    "Owner"       = var.tags[1]
  }
}


# Ahmed: Directly uses the AWS-managed policy AmazonS3FullAccess
resource "aws_iam_user_policy_attachment" "Ahmed_policy" {
  user       = aws_iam_user.Ahmed.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess" # AWS-managed policy
}

# Mahmoud: Has a custom policy restricting access to an S3 bucket with a condition for specific IPs.
# Create IAM Role for Mahmoud to AssumeRole - (Consider it as external access)

resource "aws_iam_role" "iam_role_get_s3_Mahmoud" {
  name = "s3_get_access_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "114"
        Effect    = "Allow"
        Action    = "sts:AssumeRole"
        Principal = {
          AWS = aws_iam_user.Mahmoud.arn
        }
      }
    ]
  })
  tags = {
    "Environment" = var.tags[0]
    "Owner"       = var.tags[1]
  }
}

# Create S3 get policy document to give permissions to Mahmoud to read objects from existing S3 buckets.
data "aws_iam_policy_document" "s3_get_access_policy_document" {
  statement {
    sid    = "115"
    effect = "Allow"
    actions = ["s3:GetObject"]
    resources = [
      aws_s3_bucket.ForgTech_bucket.arn,
      "${aws_s3_bucket.ForgTech_bucket.arn}/*"
                ] 
    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"   # Specifies that the action is allowed only if the request originates from the IP address 41.45.34.102.
      values   = ["41.45.34.102"]
    }
  }
}

# Create policy just to hold the S3 get policy document created
# converts the S3 Get policy document into a reusable AWS IAM policy.
resource "aws_iam_policy" "holds_s3_get_policy" {
  name   = "holds_s3_get_policy"
  policy = data.aws_iam_policy_document.s3_get_access_policy_document.json
  tags = {
    "Environment" = var.tags[0]
    "Owner"       = var.tags[1]
  }
}

# attach s3 get policy to the role
resource "aws_iam_role_policy_attachment" "attach_s3_get_role" {
  role       = aws_iam_role.iam_role_get_s3_Mahmoud.name
  policy_arn = aws_iam_policy.holds_s3_get_policy.arn
  
}

# Mostafa: Internal user with S3 GetObject access
#Mostafa as an internal user and his team delegated to fetching files, with IAM Role holds the get-objects policy
resource "aws_iam_role" "Mostafa_s3_role" {
  name = "Mostafa_s3_access_role"

  assume_role_policy = {
    Version = "2012-10-17"
    Statement = {
        Sid    = "AllowMostafaAssumeRole"
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          AWS = "arn:aws:iam::123456789012:user/Mostafa"
        }
      }
  }

  tags = {
    "Environment" = var.tags[0]
    "Owner"       = var.tags[1]
  }
}


# Managed Policy for Mostafa
resource "aws_iam_policy" "Mostafa_s3_policy" {
  name = "Mostafa_s3_policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid      = "AllowS3GetObject",
        Effect   = "Allow",
        Action   = ["s3:GetObject"],
        Resource = [
          aws_s3_bucket.ForgTech_bucket.arn,
          "${aws_s3_bucket.ForgTech_bucket.arn}/*"
        ]
      }
    ]
  })

  tags = {
    Environment = var.tags["Environment"]
    Owner       = var.tags["Owner"]
  }
}


# Attach the Managed Policy to the Role
resource "aws_iam_role_policy_attachment" "Mostafa_policy_attachment" {
  role       = aws_iam_role.Mostafa_s3_role.name
  policy_arn = aws_iam_policy.Mostafa_s3_policy.arn
}