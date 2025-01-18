resource "aws_subnet" "server_subnet" {
    vpc_id = var.vpc_id_server
    cidr_block = var.cidr_block_server_subnet
}

resource "aws_security_group" "server_sg" {
    vpc_id = var.vpc_id_server
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