variable cidr_blocks_vpc {
  description = "cidr block for vpc"
  type = string
  }
  
variable "cidr_blocks_subnet" {
  description = "cidr block for subnet"
  type = string

}
variable "Environment" {
  description = "Environment"
  type = list(string)
}