resource "aws_key_pair" "key_pair" {
  key_name   = "${var.name}"
  public_key = "${file("${path.module}/keys/key_pair.pub")}"
}

resource "aws_launch_configuration" "asg" {
  name_prefix                 = "${var.name}-asg-"
  image_id                    = "${var.amazon_linux_id}"
  instance_type               = "${var.asg_config["instance_type"]}"
  key_name                    = "${aws_key_pair.key_pair.key_name}"
  security_groups             = ["${aws_security_group.asg.id}"]
  iam_instance_profile        = "${aws_iam_instance_profile.asg.id}"
  user_data                   = "${file("${path.module}/user_data/asg_cloud_config.yml")}"
  associate_public_ip_address = true
  enable_monitoring           = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
  }

  lifecycle {
    create_before_destroy = true
  }
}

module "blue" {
  source = "./modules/asg/blue"

  name                      = "${var.name}-blue"
  launch_configuration_name = "${aws_launch_configuration.asg.name}"
  public_subnet_id          = "${aws_subnet.public.0.id}"
  asg_config                = "${var.asg_config}"
  load_balancer_id          = "${aws_elb.elb.id}"
  app_name                  = "${aws_codedeploy_app.codedeploy.name}"
  service_role_arn          = "${aws_iam_role.codedeploy.arn}"
}

module "green" {
  source = "./modules/asg/green"

  name                      = "${var.name}-green"
  launch_configuration_name = "${aws_launch_configuration.asg.name}"
  public_subnet_id          = "${aws_subnet.public.0.id}"
  asg_config                = "${var.asg_config}"
  load_balancer_id          = "${aws_elb.elb.id}"
  app_name                  = "${aws_codedeploy_app.codedeploy.name}"
  service_role_arn          = "${aws_iam_role.codedeploy.arn}"
}
