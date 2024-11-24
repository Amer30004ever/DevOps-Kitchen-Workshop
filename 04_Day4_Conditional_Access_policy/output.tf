output "mahmoud_role_arn" {
  description = "The ARN of the IAM role for Mahmoud to assume"
  value       = aws_iam_role.Mahmoud_assume_role.arn
}