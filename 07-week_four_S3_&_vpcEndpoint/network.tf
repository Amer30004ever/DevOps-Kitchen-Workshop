resource "aws_vpc" "ForgTech_log_bucket_vpc" {
    cidr_block = var.cidr_block.vpc
      tags = var.common_tags
}

resource "aws_subnet" "ForgTech_log_bucket_subnet" {
    vpc_id = aws_vpc.ForgTech_log_bucket_vpc.id
    cidr_block = var.cidr_block.subnet
      tags = var.common_tags
}

resource "aws_route_table" "ForgTech_log_bucket_route_table" {
    vpc_id = aws_vpc.ForgTech_log_bucket_vpc.id
      tags = var.common_tags
}
resource "aws_vpc_endpoint" "s3" {
    vpc_id = aws_vpc.ForgTech_log_bucket_vpc.id
    service_name = var.vpc_endpoint.service_name
    vpc_endpoint_type = var.vpc_endpoint.type
    # Route Table IDs associated with the endpoint
    route_table_ids = [aws_route_table.ForgTech_log_bucket_route_table.id]
    tags = var.common_tags
}   