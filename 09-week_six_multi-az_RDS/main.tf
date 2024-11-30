module "ForgTech_rds" {
    source = "./modules/rds"
    vpc_id_rds = var.vpc_id.id
    aws_db_subnet_group_rds = aws_db_subnet_group.ForgTech_subnet_group.name
    server_subnet_id_rds = module.ForgTech_server.server_subnet_id.id
    #value_at_source = value_in_current directory
}

module "ForgTech_server" {
    source = "./modules/server"
    vpc_id_server = var.vpc_id
    tags_all = var.tags
    server_subnet_id_server = var.server_subnet_id_variable
}