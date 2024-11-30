variable "cidr_block_vpc" {
    default = "10.0.0.0/16"
}
variable "tags" {
    default =  {
        "Environment" = "terraformChamp"
        "Owner" = "Amer"
    }
}
variable "cidr_block_rds_subnet" {
    default = "10.0.3.0/24"
}
variable "cidr_block_server_subnet" {
    default = "10.0.2.0/24"
}
variable "instance_type" { 
    default = "t2.micro"
}

variable "availability_zone" {
    default = "us-east-1a"
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