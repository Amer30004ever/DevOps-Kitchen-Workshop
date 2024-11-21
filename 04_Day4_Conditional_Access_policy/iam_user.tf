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


/*
# Custom policy not a managed policy like AmazonS3FullAccess
resource "aws_iam_policy" "Ahmed_policy" {
  name = "Ahmed_policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "s3:*" # Full access to S3 actions
        ],
        Resource = [
          "${aws_s3_bucket.ForgTech_bucket.arn}",            # Bucket itself
          "${aws_s3_bucket.ForgTech_bucket.arn}/*"          # Objects within the bucket
        ]
      }
    ]
  })
}
*/

# Mahmoud: Has a custom policy restricting access to an S3 bucket with a condition for specific IPs.
# Create IAM Role for Mahmoud to AssumeRole - (Consider it as external access)
resource "aws_iam_role" "iam_role_get_s3_Mahmoud" {
  name = "s3_get_access_role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "114",
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Principal": {
                "AWS": "${aws_iam_user.Mahmoud.arn}"
            }
        }
    ]
}
EOF
}

# Create S3 get policy document to give permissions to Mahmoud to read objects from S3 buckets.
data "aws_iam_policy_document" "s3_get_access_policy_document" {
  statement {
    sid    = "115"
    effect = "Allow"
    actions = "s3:GetObject"
    resources = [
                "${aws_s3_bucket.ForgTech_bucket.arn}/*",     # Restricts the permission to objects inside the S3 bucket ForgTech_bucket
                 "${aws_s3_bucket.ForgTech_bucket.arn}/Mahmoud/*"      #  Restricts the permission to objects inside Mahmoud folder
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
}

# attach s3 get policy to the role
resource "aws_iam_role_policy_attachment" "attach_s3_get_role" {
  role       = aws_iam_role.iam_role_get_s3_Mahmoud.name
  policy_arn = aws_iam_policy.holds_s3_get_policy.arn
}

/*
# iam_policy for Mahmoud with restricted IP-based S3 access - by "chatgpt"
resource "aws_iam_policy" "Mahmoud_s3_policy" {
  name        = "MahmoudS3Policy"
  description = "Policy for Mahmoud to get objects from S3 with IP restriction"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:GetObject"
        Resource = "arn:aws:s3:::${aws_s3_bucket.ForgTech_bucket}/*" #  bucket name : ${aws_s3_bucket.ForgTech_bucket}
        Condition = {
          IpAddress = {
            "aws:SourceIp" = "203.0.113.0/24" # Replace with Mahmoud's company public IP range
          }
        }
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "Mahmoud_policy_attachment" {
  user       = aws_iam_user.Mahmoud.name
  policy_arn = aws_iam_policy.Mahmoud_s3_policy.arn
}
*/



/*
#Mostafa: Uses an IAM role, enabling his team to assume it for fetching files with a GetObject policy - by "chatgpt".
resource "aws_iam_policy" "Mostafa_s3_policy" {
  name        = "MostafaS3Policy"
  description = "Policy for fetching S3 objects"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:GetObject"
        Resource = "arn:aws:s3:::{aws_s3_bucket.ForgTech_bucket}/*" # Replace with your bucket name
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "Mostafa_policy_attachment" {
  role       = aws_iam_role.Mostafa_team_role.name
  policy_arn = aws_iam_policy.Mostafa_s3_policy.arn
}

# Output the IAM Role ARN for Mostafa's team to assume role
output "Mostafa_team_role_arn" {
  value = aws_iam_role.Mostafa_team_role.arn
}
*/