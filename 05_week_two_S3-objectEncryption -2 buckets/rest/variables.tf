variable "cidr_vpc" {
    type = string
    default = "10.10.0.0/16"
}

variable "cidr_subnet" {
    type = string
    default = "10.0.10.0/24"
}

/*
variable "tags" {
    type = list(string)
    default = ["terraformChamps", "Amer"]
}
*/

variable "ForgTech_bucket_name" {
    description = "The name of the S3 bucket where logs will be stored"
    type = string
    default = "FrogTech_bucket"
}

/*
variable "region" {    
    type = string
    default = "us-east-1"
}


variable "backend_bucket_name" {
    description = "The name of the S3 bucket where state will be stored"
    type = string
    default = "my-terraform-state-backend-bucket"
}
*/