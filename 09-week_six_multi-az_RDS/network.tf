resource "aws_vpc" "name" {
    cidr_block = var.cidr_block.vpc
}

resource "aws_db_subnet_group" "ForgTech_subnet_group" {
    name = "subnet-group"
    subnet_ids = [aws_subnet.rds_subnet.id, aws_subnet.server_subnet.id]
    tags = var.tags
}