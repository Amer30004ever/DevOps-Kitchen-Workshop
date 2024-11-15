provider "aws" {
  region = "us-east-1"
}

variable cidr_blocks_vpc {
  description = "cidr block for vpc"
  type = string
  }
variable "cidr_blocks_subnet" {
  description = "cidr block for subnet"
  type = string

}
variable "Environment" {
  description = "Environment"
  type = list(string)
}
resource "aws_vpc" "frogtech-vpc" { 
  cidr_block = var.cidr_blocks_vpc
  tags = {
    Name = "frogtech-vpc"
    Environment = var.Environment[0]
    Owner = var.Environment[1]
  }
}

resource "aws_subnet" "frogtech-subnet" {
  vpc_id = aws_vpc.frogtech-vpc.id
  cidr_block = var.cidr_blocks_subnet
  availability_zone = "us-east-1a"
  tags = {
    Name = "frogtech-subnet"
    Environment = var.Environment[0]
    Owner = var.Environment[1]
  }
}

resource "aws_internet_gateway" "frogtech-igw" {
  vpc_id = aws_vpc.frogtech-vpc.id
  tags = {
    Name = "frogtech-igw"
    Environment = var.Environment[0]
    Owner = var.Environment[1]
  }
}

resource "aws_route_table" "frogtech-route-table" {
  vpc_id = aws_vpc.frogtech-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.frogtech-igw.id
  }
  tags = {
    Name = "frogtech-route-table"
    Environment = var.Environment[0]
    Owner = var.Environment[1]
  }
}

resource "aws_route_table_association" "frogtech-route-association" {
  subnet_id = aws_subnet.frogtech-subnet.id
  route_table_id = aws_route_table.frogtech-route-table.id
}