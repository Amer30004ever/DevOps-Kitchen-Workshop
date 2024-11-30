module "ForgTech_rds" {
    source = "./modules/rds"
    vpc_id_rds = aws_vpc.ForgTech_vpc.id
    #value_at_source = value_in_current directory
}

module "ForgTech_server" {
    source = "./modules/server"
    vpc_id_server = aws_vpc.ForgTech_vpc.id
    tags_all = var.tags
}