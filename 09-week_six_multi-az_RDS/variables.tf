variable "tags" {
    default =  {
        "Environment" = "terraformChamp"
        "Owner" = "Amer"
    }
}

variable "vpc_id" {
    default = "${aws_vpc.ForgTech_vpc.id}"
}

variable "server_subnet_id_variable" {
    default = "${aws_subnet.ForgTech_server_subnet.id}"
}