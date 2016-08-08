provider "aws" {
  region = "${var.region}"
}

module "prd" {
  source = "../../"

  name            = "${var.name}"
  vpc_cidr        = "${var.vpc_cidr}"
  asg_config      = "${var.asg_config}"
  azs             = "${data.aws_availability_zones.az.names}"
  amazon_linux_id = "${data.aws_ami.amazon_linux.id}"
}
