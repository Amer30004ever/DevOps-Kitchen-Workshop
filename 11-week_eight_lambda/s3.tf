resource "aws_s3_bucket" "frogtech_us_external" {
    bucket = "ForgTech_bucket"
    force_destroy = true
}

resource "aws_s3_bucket" "frogtech_us_internal" {
    bucket = "ForgTech_bucket"
    force_destroy = true
}