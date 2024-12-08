# This resource creates an IAM role that Lambda functions can assume. 
# The assume role policy allows the Lambda service to assume this role.
resource "aws_iam_role" "lambda_assume_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow", 
      Principal = {
        Service = "lambda.amazonaws.com",
      },
    }],
  })
}

# This resource creates an IAM policy that grants permissions for CloudWatch Logs.
# It allows the Lambda function to create log groups/streams and write log events.
resource "aws_iam_policy" "lambda_policy" {
  name   = "lambda_policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream", 
        "logs:PutLogEvents",
      ],
      Effect   = "Allow",
      Resource = "arn:aws:logs:*:*:*",
    }],
  })
}

# This resource attaches the IAM policy to the IAM role.
# This gives the Lambda function the permissions defined in the policy.
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_assume_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}


