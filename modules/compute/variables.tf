variable "instance_count" {
  default = 2
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ami" {
  default = "ami-0f5ee92e2d63afc18"
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "common_tags" {
  type = map(string)
}