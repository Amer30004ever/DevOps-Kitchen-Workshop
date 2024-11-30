variable "vpc_id_server" {}
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

variable "server_subnet_id_server" {
    default = "${aws_subnet.server_subnet}"
}