# Ahmed: Internal user with S3 acces
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

# Mostafa: External user with restricted IP-based S3 acces
resource "aws_iam_user" "Mostafa" {
  name = var.iam_user[2]
  tags = {
    "Environment" = var.tags[0]
    "Owner"       = var.tags[1]
  }
}


# Ahmed Policy
# AWS-managed policy AmazonS3FullAccess Directly used
data "aws_iam_policy_document" "S3FullAccess" {
  statement {
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = [
      "${aws_s3_bucket.ForgTech_bucket.arn}",
      "${aws_s3_bucket.ForgTech_bucket.arn}/*"
    ]  
  }
}

# converts the (S3FullAccess) policy document into a reusable AWS IAM policy
resource "aws_iam_policy" "S3FullAccessPolicy" {
  name        = "S3FullAccessPolicy"
  description = "S3FullAccessPolicy"
  policy      = data.aws_iam_policy_document.S3FullAccess.json
  tags = {
    "Environment" = var.tags[0]
    "Owner"       = var.tags[1]
  }
}

# connects the previously defined policy (Ahmed_policy) to the IAM user Ahmed
resource "aws_iam_policy_attachment" "Ahmed_S3FullAccess" {
  name       = "Ahmed_S3FullAccess"
  users      = [aws_iam_user.Ahmed.name]
  policy_arn = aws_iam_policy.S3FullAccessPolicy.arn
}
# Mahmoud Policy
# Create IAM Role for Mahmoud to AssumeRole - (Consider it as external access)
resource "aws_iam_role" "Mahmoud_assume_role" {
  name = "iam_role_assume_Mahmoud"

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
# Create S3 get policy document
data "aws_iam_policy_document" "s3_get_object_policy_document" {
  statement {
    sid    = "115"
    effect = "Allow"
    actions = ["s3:GetObject"] 
resources = [
    aws_s3_bucket.ForgTech_bucket.arn,     # the S3 bucket
    "${aws_s3_bucket.ForgTech_bucket.arn}/*"  # all objects within the bucket
                ] 
    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"   
      values   = ["41.45.34.102"]
    }
  }
}

# Create policy just to hold the S3 get policy document created, converts the S3 Get policy document into a reusable AWS IAM policy.
resource "aws_iam_policy" "holds_s3_document_policy" {
  name   = "holds_s3_get_policy"
  policy = data.aws_iam_policy_document.s3_get_object_policy_document.json
  tags = {
    "Environment" = var.tags[0]
    "Owner"       = var.tags[1]
  }
}

# attach s3 get policy to the role
resource "aws_iam_role_policy_attachment" "attach_s3_get_role" {
  role       = aws_iam_role.Mahmoud_assume_role.name
  policy_arn = aws_iam_policy.holds_s3_document_policy.arn
  
}

# Mostafa Policy: 
#Mostafa as an internal user and his team delegated to fetching (GetObject) files, with IAM Role holds the get-objects policy
resource "aws_iam_role" "Mostafa_assume_role" {
  name = "Mostafa_s3_access_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
        Sid    = "AllowMostafaAssumeRole"
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          AWS = aws_iam_user.Mostafa.arn
        }
    }]
  })
  tags = {
    "Environment" = var.tags[0]
    "Owner"       = var.tags[1]
  }
}


# Managed Policy for Mostafa
resource "aws_iam_policy" "Mostafa_s3_policy" {
  name = "Mostafa_s3_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid      = "AllowS3GetObject"
      Effect   = "Allow"
      Action   = ["s3:GetObject"]
      Resource = [
        aws_s3_bucket.ForgTech_bucket.arn,
        "${aws_s3_bucket.ForgTech_bucket.arn}/*"
      ]
    }]
  })  
  tags = {
    "Environment" = var.tags[0]
    "Owner"       = var.tags[1]
  }
}


# Attach the Managed Policy to the Role
resource "aws_iam_role_policy_attachment" "Mostafa_policy_attachment" {
  role       = aws_iam_role.Mostafa_assume_role.name
  policy_arn = aws_iam_policy.Mostafa_s3_policy.arn
}
