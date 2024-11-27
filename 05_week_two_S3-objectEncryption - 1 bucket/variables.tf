# Bucket name variable
variable "bucket_name" {
  default = "forgtech-logs-bucket" # Change to a unique bucket name
}

# Common tags as a map
variable "common_tags" {
  default = {
    Environment = "terraformChamps"
    Owner       = "Amer"
  }
}
