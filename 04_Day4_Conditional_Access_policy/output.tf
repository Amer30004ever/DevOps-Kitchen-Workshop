output "mahmoud_role_arn" {
  description = "The ARN of the IAM role for Mahmoud to assume"
  value       = aws_iam_role.iam_role_get_s3_Mahmoud.arn
}