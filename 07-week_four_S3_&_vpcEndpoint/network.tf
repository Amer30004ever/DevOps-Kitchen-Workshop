resource "aws_vpc" "ForgTech_log_bucket_vpc" {
    cidr_block = "10.0.0.0/16"
      tags = var.common_tags
}

resource "aws_subnet" "ForgTech_log_bucket_subnet" {
    vpc_id = aws_vpc.ForgTech_log_bucket_vpc.id
    cidr_block = "10.0.1.0/24"
      tags = var.common_tags
}

resource "aws_route_table" "ForgTech_log_bucket_route_table" {
    vpc_id = aws_vpc.ForgTech_log_bucket_vpc.id
      tags = var.common_tags
}
resource "aws_vpc_endpoint" "s3" {
    vpc_id = aws_vpc.ForgTech_log_bucket_vpc.id
    service_name = "com.amazonaws.us-east-1.s3"
    vpc_endpoint_type = "Gateway"
    # Route Table IDs associated with the endpoint
    route_table_ids = [aws_route_table.ForgTech_log_bucket_route_table.id]
    tags = var.common_tags
}   