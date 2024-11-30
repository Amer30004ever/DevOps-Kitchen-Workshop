variable "vpc_id_server" {}
variable "cidr_block_server_subnet" {
    default = "10.0.2.0/24"
}
variable "instance_type" { 
    default = "t2.micro"
}

variable "availability_zone" {
    default = "us-east-1a"
}

variable "tags_all" {
    default = {
        "Environment" = "terraformChamps"
        "Owner" = "Amer"
    }
}