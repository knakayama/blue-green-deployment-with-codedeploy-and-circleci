variable "name" {}

variable "launch_configuration_name" {}

variable "public_subnet_id" {}

variable "asg_config" {
  type = "map"
}

variable "app_name" {}

variable "service_role_arn" {}

variable "load_balancer_id" {}
