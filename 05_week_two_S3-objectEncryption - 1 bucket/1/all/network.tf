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

resource "aws_security_group" "ForgTech_security_group" {
    name = "ForgTech_security_group"
    vpc_id = "aws_vpc.ForgTech_vpc.id"
    ingress {           # incomming traffic
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["10.0.10.0/24"]  # Allow traffic from the subnet
    }
    
    egress {              # outgoing traffic
        from_port = 0    # all ports          
        to_port = 0        # all ports                
        protocol = "-1"     # "-1" means all protocols (TCP, UDP, ..) 
        cidr_blocks = ["0.0.0.0/0"]  # Allow all traffic by using a single host CIDR
    }
}