variable "bucket_name" {
  type = string
}

variable "tags" {
  type = list(string)
}

variable "region" {
  type = string
}

variable "transition" {
  type = list(string)
}