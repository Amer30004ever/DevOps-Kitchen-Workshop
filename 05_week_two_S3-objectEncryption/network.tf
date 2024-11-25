resource "aws_vpc" "ForgTech_vpc" {
    cidr_block = var.cidr_vpc
    tags = {
        "Environment" = var.tags[0]
        "Owner" = var.tags[1]
    }
}

resource "aws_subnet" "ForgTech_subnet" {
    vpc_id = aws_vpc.ForgTech_vpc.id
    cidr_block = var.cidr_subnet
    tags = {
        "Environment" = var.tags[0]
        "Owner" = var.tags[1]
    }
}

resource "aws_vpc_endpoint" "ForgTech_vpc_endpoint" {
    vpc_id = aws_vpc.ForgTech_vpc.id
    service_name = "com.amazonaws.us-east-1.s3"
    vpc_endpoint_type = "Interface"
}

resource "aws_vpc_endpoint_subnet_association" "ForgTech_vpc_endpoint_subnet_association" {
    vpc_endpoint_id = aws_vpc_endpoint.ForgTech_vpc_endpoint.id
    subnet_id = aws_subnet.ForgTech_subnet.id
}

resource "aws_security_group" "ForgTech_security_group" {
    name = "ForgTech_security_group"
    vpc_id = "aws_vpc.ForgTech_vpc.id"
    ingress {             # incomming traffic
    from_port = 0    # all ports          
    to_port = 0        # all ports                
    protocol = "-1"     # "-1" means all protocols (TCP, UDP, ..) 
    cidr_blocks = ["0.0.0.0/32"]  # Blocks all traffic by using a single host CIDR
  }
}