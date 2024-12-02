resource "aws_security_group" "ForgTech_sg" {
    vpc_id = aws_vpc.ForgTech_vpc.id
}

