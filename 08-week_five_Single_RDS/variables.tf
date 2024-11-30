variable "cidr_block" {
    default = {
        "vpc" = "10.0.0.0/16"
        "subnet" = "10.0.0.0/24"
    }
  
}

variable "bucket_name" {
    default = "s3-bucket-from-terraform"
}

variable "tags" {
    default = {
        "Environment" = "terraformChamps"
        "Owner" = "Amer"
    }
}

variable "ingress_rules" {
  default = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "egress_rules" {
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "rds_orderable_db_instance" {
    default = {
        "engine" = "postgres"
        "engine_version" = "15.3"
        "instance_class" = "db.t3.micro"
    }
  
}

variable "db_instance" {
    default = {
        "username" = "testdb"
        "password" = "secretpassword"
    }
}