variable "instance_type" {
    default = "t2.micro"
}

variable "ForgTech_tags" {
    default = {
        "Environment" = "terraformChamps"
        "owner" = "Amer"
    }
}

variable "db_instance" {
    default = {
        "name" = "forgtech"
        "allocated_storage" = 20
        "username" = "postgres"
        "password" = "postgres"
        "engine" = "postgres"
        "engine_version" = "15.4"
        "class" = "db.t3.micro"
        "backup_retention_period" = 7
    }
}

variable "cidr_block" {
    default = {
        "subnet" = "10.0.1.0/24"
        "vpc" = "10.0.0.0/16"
    }
  
}