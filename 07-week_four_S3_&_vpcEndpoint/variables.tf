variable "bucket_name" {
    default = "ForgTech-log-bucket"
}

variable "common_tags" {
    default = {
        "Environment" = "terraformChamps"
        "Owner" = "Amer"
    }
}