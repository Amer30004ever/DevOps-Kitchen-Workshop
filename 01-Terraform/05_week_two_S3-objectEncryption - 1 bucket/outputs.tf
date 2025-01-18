# Output the S3 bucket name
output "s3_bucket_name" {
  value       = aws_s3_bucket.ForgTech_logs.bucket # Display the bucket name
  description = "Name of the S3 bucket created for FrogTech logs"
#Outputs: s3_bucket_name = "forgtech-logs-bucket"
}
