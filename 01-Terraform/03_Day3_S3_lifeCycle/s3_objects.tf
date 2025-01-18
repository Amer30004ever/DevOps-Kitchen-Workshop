resource "aws_s3_object" "log-dir" {
  bucket = aws_s3_bucket.ForgTech_bucket.id
  key = "log/"
  tags = {
    "Environment" = var.tags[0]
    "Owner"       = var.tags[1]
  }
}
resource "aws_s3_object" "outgoing-dir" {
  bucket = aws_s3_bucket.ForgTech_bucket.id
  key = "outgoing/"
  tags = {
    "Environment" = var.tags[0]
    "Owner"       = var.tags[1]
  }
}
resource "aws_s3_object" "incoming-dir" {
  bucket = aws_s3_bucket.ForgTech_bucket.id
  key = "incoming/"
  tags = {
    "Environment" = var.tags[0]
    "Owner"       = var.tags[1]
  }
}