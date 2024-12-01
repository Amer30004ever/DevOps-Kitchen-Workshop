resource "aws_subnet" "ForgTech_subnet" {
    vpc_id = aws_vpc.ForgTech_vpc.id
    cidr_block = "10.0.1.0/24"
}

resource "aws_db_subnet_group" "ForgTech_subnet_group" {
    name = "forgtech-db-subnet-group"
    subnet_ids = [aws_subnet.ForgTech_subnet.id]
}