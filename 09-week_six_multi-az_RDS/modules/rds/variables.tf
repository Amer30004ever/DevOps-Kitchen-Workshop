variable "vpc_id_rds" {}
variable "cidr_block_rds_subnet" {
    default = "10.0.3.0/24"
}
variable "aws_db_subnet_group_rds" {}
variable "aws_db_intance" {
    default = {
        "allocated_storage" = "20"
        "engine" = "postgres"
        "engine_version" = "15.3"
        "instance_class" = "db.t3.micro"
        "username" = "admin"
        "password" = "securepassword"
    }
  
}
variable "tags_all" {
    default = {
        "Environment" = "terraformChamps"
        "Owner" = "Amer"
    }
}

variable "server_subnet_id_for_rds" {}