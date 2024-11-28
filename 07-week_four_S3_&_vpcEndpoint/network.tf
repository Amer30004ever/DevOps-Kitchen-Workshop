resource "aws_vpc" "ForgTech_log_bucket_vpc" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "ForgTech_log_bucket_subnet" {
    vpc_id = aws_vpc.ForgTech_log_bucket_vpc.id
    cidr_block = "10.0.1.0/24"
}