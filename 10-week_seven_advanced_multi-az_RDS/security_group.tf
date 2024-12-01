resource "aws_vpc" "ForgTech_vpc" {
    cidr_block = "10.0.0.0/16"
}



resource "aws_security_group" "ForgTech_sg" {
    vpc_id = aws_vpc.ForgTech_vpc.id
}

