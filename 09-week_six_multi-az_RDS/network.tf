resource "aws_vpc" "ForgTech_vpc" {
    cidr_block = var.cidr_block_vpc
}

resource "aws_subnet" "rds_subnet" {
    vpc_id = aws_vpc.ForgTech_vpc.id
    cidr_block = var.cidr_block_rds_subnet
}

resource "aws_security_group" "rds_sg" {
    vpc_id = aws_vpc.ForgTech_vpc.id
    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = ["10.0.2.0/24"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_subnet" "server_subnet" {
    vpc_id = aws_vpc.ForgTech_vpc.id
    cidr_block = var.cidr_block_server_subnet
}

resource "aws_security_group" "server_sg" {
    vpc_id = aws_vpc.ForgTech_vpc.id
    ingress {
        #for SSH
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_db_subnet_group" "ForgTech_subnet_group" {
    name = "subnet-group"
    subnet_ids = [aws_subnet.rds_subnet.id, aws_subnet.server_subnet.id]
    tags = var.tags
}