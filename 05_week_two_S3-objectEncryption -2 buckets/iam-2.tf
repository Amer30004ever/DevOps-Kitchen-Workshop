data "aws_canonical_user_id" "Owner" {
  depends_on = [aws_s3_bucket.backend_bucket]
}