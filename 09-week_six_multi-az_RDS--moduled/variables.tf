variable "cidr_block_vpc" {
    default = "10.0.0.0/16"
}
variable "tags" {
    default =  {
        "Environment" = "terraformChamp"
        "Owner" = "Amer"
    }
}
