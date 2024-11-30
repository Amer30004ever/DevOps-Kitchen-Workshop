resource "aws_vpc" "ForgTech_vpc" {
    cidr_block = var.cidr_block_vpc
}

resource "aws_db_subnet_group" "ForgTech_subnet_group" {
    name = "subnet-group"
    subnet_ids = [module.ForgTech_rds.aws_subnet.rds_subnet.id, module.ForgTech_server.aws_subnet.server_subnet.id]
    tags = var.tags
}