resource "aws_subnet" "rds_subnet" {
    vpc_id = aws_vpc.ForgTech_vpc.id
    cidr_block = var.cidr_block_rds_subnet
}

resource "aws_subnet" "server_subnet" {
    vpc_id = aws_vpc.ForgTech_vpc.id
    cidr_block = var.cidr_block_server_subnet
}

resource "aws_db_subnet_group" "ForgTech_subnet_group" {
    name = "subnet-group"
    subnet_ids = [aws_subnet.rds_subnet.id, aws_subnet.server_subnet.id]
    tags = var.tags
}