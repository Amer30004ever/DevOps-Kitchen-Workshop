variable "backend_bucket_name" {
    description = "The name of the S3 bucket where state will be stored"
    type = string
    default = "my-terraform-state-backend-bucket"
}

variable "tags" {
    type = list(string)
    default = ["terraformChamps", "Amer"]
}