variable "bucket_name" {
    default = "ForgTech-log-bucket"
}

variable "common_tags" {
    default = {
        "Environment" = "terraformChamps"
        "Owner" = "Amer"
    }
}

variable "instance_type" {
    default = "t2.micro"
}

variable "cidr" {
    default = {
        "vpc" = "10.0.0.0/16"
        "subnet" = "10.0.1.0/24"
    }
  
}

variable "vpc_endpoint" {
    default = {
        service_name = "com.amazonaws.us-east-1.s3"
        type = "Gateway"
    }
}