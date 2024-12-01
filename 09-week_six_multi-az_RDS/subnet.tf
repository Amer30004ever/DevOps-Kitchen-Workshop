resource "aws_subnet" "subnet-1" {
    vpc_id = aws_vpc.ForgTech_vpc.id
    cidr_block = var.cidr_block_subnet-1
    availability_zone = var.availability_zone.subnet-1
}

resource "aws_subnet" "subnet-2" {
    vpc_id = aws_vpc.ForgTech_vpc.id
    cidr_block = var.cidr_block_subnet-2
    availability_zone = var.availability_zone.subnet-2
}

resource "aws_db_subnet_group" "ForgTech_subnet_group" {
    name = "subnet-group"
    subnet_ids = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]
    tags = var.tags
}