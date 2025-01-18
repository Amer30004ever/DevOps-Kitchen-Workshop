variable "cidr_block_vpc" {
    default = "10.0.0.0/16"
}
variable "tags" {
    default =  {
        "Environment" = "terraformChamp"
        "Owner" = "Amer"
    }
}
variable "cidr_block_subnet-1" {
    default = "10.0.2.0/24"
}
variable "cidr_block_subnet-2" {
    default = "10.0.3.0/24"
}
variable "instance_type" { 
    default = "t2.micro"
}

variable "availability_zone" {
    default = {
        "subnet-1" = "us-east-1a"
        "subnet-2" = "us-east-1b"
    }
}

variable "aws_db_intance" {
    default = {
        "allocated_storage" = "20"
        "engine" = "postgres"
        "engine_version" = "15.4"
        "instance_class" = "db.t3.micro"
        "username" = "postgres"
        "password" = "securepassword"
    }
  
}
variable "tags_all" {
    default = {
        "Environment" = "terraformChamps"
        "Owner" = "Amer"
    }
}