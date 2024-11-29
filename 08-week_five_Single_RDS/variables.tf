variable "cidr_block" {
    default = {
        "vpc" = "10.0.0.0/16"
        "subnet" = "10.0.0.0/24"
    }
  
}

variable "bucket_name" {
    default = "s3-bucket-from-terraform"
}