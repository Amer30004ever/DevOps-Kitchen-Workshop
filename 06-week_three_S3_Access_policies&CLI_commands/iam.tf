resource "aws_iam_user" "Taha" {
    name = "Taha"
    tags = var.common_tags
}

resource "aws_iam_user" "Mostafa" {
    name = "Mostafa"
    tags = var.common_tags
}

#Taha
#Taha assume role
resource "aws_iam_role" "Taha_assume_role" {
    name = "Taha_assume_role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Principal = {
                    AWS = aws_iam_user.Taha.arn
                }
                Effect = "Allow"
            }
        ]
    })
    tags = var.common_tags
}

#Taha policy document
data "aws_iam_policy_document" "Taha_s3_GetObject" {
    statement {
      actions = ["s3:GetObject"]
      resources = ["${aws_s3_bucket.ForgTech_logs.arn}/logs/"]
    }
}

#Taha iam policy
resource "aws_iam_policy" "Taha_policy" {
    name = "Taha_policy"
    policy = data.aws_iam_policy_document.Taha_s3_GetObject.json
    tags = var.common_tags
}

#Taha policy attachmen
resource "aws_iam_role_policy_attachment" "Taha_policy_attach" {
    role = aws_iam_role.Taha_assume_role.name
    policy_arn = aws_iam_policy.Taha_policy.arn
}

#Mostafa
#Mostafa assume role
resource "aws_iam_role" "Mostafa_assume_role" {
    name = "Mostafa_assume_role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Principal = {
                    AWS = aws_iam_user.Mostafa.arn
                }
                Effect = "Allow"
            }
        ]
    })
    tags = var.common_tags
}

#Taha policy document
data "aws_iam_policy_document" "Mostafa_s3_GetObject" {
    statement {
      actions = ["s3:PutObject"]
      resources = ["${aws_s3_bucket.ForgTech_logs.arn}/*"]
    }
}

#Mostafa iam policy
resource "aws_iam_policy" "Mostafa_policy" {
    name = "Mostafa_policy"
    policy = data.aws_iam_policy_document.Mostafa_s3_GetObject.json
    tags = var.common_tags
}

#Mostafa policy attachmen
resource "aws_iam_role_policy_attachment" "Mostafa_policy_attach" {
    role = aws_iam_role.Mostafa_assume_role.name
    policy_arn = aws_iam_policy.Mostafa_policy.arn
}