variable "vpc_id_rds" {}
variable "cidr_block_rds_subnet" {
    default = "10.0.3.0/24"
}

variable "server_subnet" {
    default = "10.0.2.0/24"
}

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

variable "subnet_group" {
    type = string
}