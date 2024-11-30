module "ForgTech_rds" {
    source = "./modules/rds"
    vpc_id_rds = aws_vpc.ForgTech_vpc.id
    aws_db_subnet_group_rds = aws_db_subnet_group.ForgTech_subnet_group
    server_subnet_id_for_rds = module.ForgTech_server.server_subnet_id.id
    #value_at_source = value_in_current directory
}

module "ForgTech_server" {
    source = "./modules/server"
    vpc_id_server = aws_vpc.ForgTech_vpc.id
    tags_all = var.tags
}