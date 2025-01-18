resource "aws_vpc" "ForgTech_vpc" {
    cidr_block = var.cidr_block.vpc
    tags = var.tags
}

resource "aws_subnet" "ForgTech_subnet" {
    cidr_block = var.cidr_block.subnet
    vpc_id = aws_vpc.ForgTech_vpc.id
    tags = var.tags
}

resource "aws_security_group" "ForgTech_sg" {
    name = "allow-all"
    vpc_id = aws_vpc.ForgTech_vpc.id
    ingress {
        from_port = var.ingress_rules.from_port
        to_port = var.ingress_rules.to_port
        protocol = var.ingress_rules.protocol
        cidr_blocks = var.ingress_rules.cidr_blocks
    }
    egress {
        from_port = var.egress_rules.from_port
        to_port = var.egress_rules.to_port
        protocol = var.egress_rules.protocol
        cidr_blocks = var.egress_rules.cidr_blocks
    }
    tags = var.tags
}

resource "aws_db_subnet_group" "ForgTech_subnet_group" {
    name = "subnet-group"
    subnet_ids = [aws_subnet.ForgTech_subnet.id]
    tags = var.tags
}