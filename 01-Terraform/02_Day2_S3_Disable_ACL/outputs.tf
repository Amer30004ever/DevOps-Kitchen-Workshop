output "bucket_name" {
  value = aws_s3_bucket.ForgTech_bucket.id
}

output "iam_user" {
  value = aws_iam_user.Mohamed.name
}