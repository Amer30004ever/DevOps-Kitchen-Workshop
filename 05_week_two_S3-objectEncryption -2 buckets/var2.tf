variable "tags" {
    type = list(string)
    default = ["terraformChamps", "Amer"]
}

variable "region" {    
    type = string
    default = "us-east-1"
}

variable "backend_bucket_name" {
    description = "The name of the S3 bucket where state will be stored"
    type = string
    default = "my-terraform-state-backend-bucket"
}