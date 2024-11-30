resource "aws_vpc" "ForgTech_vpc" {
    cidr_block = var.cidr_block.vpc
}

resource "aws_db_subnet_group" "ForgTech_subnet_group" {
    name = "subnet-group"
    subnet_ids = [module.ForgTech_rds.rds_subnet_id.id, module.ForgTech_server.server_subnet_id.id]
    tags = var.tags
}