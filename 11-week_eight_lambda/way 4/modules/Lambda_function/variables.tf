variable "function_name" {}
variable "source_bucket" {}
variable "dest_bucket" {}
variable "lambda_role_arn" {}
variable "tags" {
  type = map(string)
}
