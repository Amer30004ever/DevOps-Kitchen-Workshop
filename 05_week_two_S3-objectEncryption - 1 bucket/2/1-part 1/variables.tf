
variable "tags" {
    type = list(string)
    default = ["terraformChamps", "Amer"]
}

variable "ForgTech_bucket_name" {
    description = "The name of the S3 bucket where logs will be stored"
    type = string
    default = "FrogTech_bucket"
}

variable "region" {    
    type = string
    default = "us-east-1"
}