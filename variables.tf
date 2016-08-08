variable "name" {}

variable "vpc_cidr" {}

variable "asg_config" {
  type = "map"
}

variable "azs" {
  type = "list"
}

variable "amazon_linux_id" {}
