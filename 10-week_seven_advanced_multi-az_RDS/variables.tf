variable "instance_type" {
    default = "t2.micro"
}

variable "ForgTech_tags" {
    default = {
        "Environment" = "terraformChamps"
        "owner" = "Amer"
    }
}