resource "aws_subnet" "rds_subnet" {
    vpc_id = var.vpc_id_rds
    cidr_block = var.cidr_block_rds_subnet
}

resource "aws_security_group" "rds_sg" {
    vpc_id = var.vpc_id_rds
    ingress  {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = ["${var.server_subnet}"]
    }
    egress  {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

