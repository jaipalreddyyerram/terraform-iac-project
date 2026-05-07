variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  default = "iac-vpc"
}

variable "public_subnets" {
  default = [
    "subnet1",
    "subnet2"
  ]
}

variable "azs" {
  default = [
    "ap-south-1a",
    "ap-south-1b"
  ]
}

variable "common_tags" {
  type = map(string)
}