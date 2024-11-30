resource "aws_subnet" "rds_subnet" {
    vpc_id = module.root.vpc_id
}

resource "aws_security_group" "sds_sg" {
    vpc_id = module.root.vpc_id
}

