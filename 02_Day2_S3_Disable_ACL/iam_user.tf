resource "aws_iam_user" "Mohamed" {
  name = var.profile_name
  tags = {
    "Environment" = var.tags[0]
    "Owner" = var.tags[1]
  }
}

/*
# Attach an inline policy to allow Mohamed to upload files to the /log directory
resource "aws_iam_user_policy" "Mohamed_S3_Upload_Policy" {
  name = "MohamedS3UploadPolicy"
  user = aws_iam_user.Mohamed.name
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject"
        ]
        Resource = [
          "${aws_s3_bucket.ForgTech_bucket.arn}/log/*"
        ]
      }
    ]
  })
  
}

*/