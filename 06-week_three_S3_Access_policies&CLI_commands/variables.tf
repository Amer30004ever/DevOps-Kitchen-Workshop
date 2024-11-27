variable "common_tags" {
  default = {
    Environment = "terraformChamps"
    Owner       = "Amer"
  }
}

variable "bucket_name" {
  default = "forgtech-logs-bucket" # Change to a unique bucket name
}