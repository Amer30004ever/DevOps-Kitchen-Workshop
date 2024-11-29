resource "aws_vpc" "name" {
    cidr_block = var.cidr_block.vpc
}

resource "aws_subnet" "name" {
    cidr_block = var.cidr_block.aws_subnet
    vpc_id = aws_vpc.vpc.id
}

resource "aws_security_group" "name" {
    name = "allow-all"
    vpc_id = aws_vpc.vpc.id
    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_db_subnet_group" "name" {
    name = "subnet-group"
    subnet_ids = [aws_subnet.name.id]
}