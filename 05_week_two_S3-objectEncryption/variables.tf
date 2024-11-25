variable "cidr_vpc" {
    type = string
}

variable "cidr_subnet" {
    type = string
}


variable "tags" {
    type = list(string)
}

variable "bucket_name" {
    type = string
}

variable "instance_type" {
        type = string
}

variable "region" {    
    type = string
}
