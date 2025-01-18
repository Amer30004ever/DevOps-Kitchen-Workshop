resource "aws_s3_bucket" "test_bucket" {
  bucket = "test-forgtech-bucket-unique"
}

# create a bucket with command
# CLI : aws s3api create-bucket --bucket test-forgtech-bucket-unique --region us-east-1
