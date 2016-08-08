resource "aws_autoscaling_group" "blue" {
  name                      = "${var.name}"
  launch_configuration      = "${var.launch_configuration_name}"
  vpc_zone_identifier       = ["${var.public_subnet_id}"]
  desired_capacity          = "${var.asg_config["desired"]}"
  max_size                  = "${var.asg_config["max"]}"
  min_size                  = "${var.asg_config["min"]}"
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  load_balancers            = ["${var.load_balancer_id}"]

  tag {
    key                 = "Name"
    value               = "Blue"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_codedeploy_deployment_group" "blue" {
  app_name              = "${var.app_name}"
  deployment_group_name = "Blue"
  service_role_arn      = "${var.service_role_arn}"
  autoscaling_groups    = ["${aws_autoscaling_group.blue.id}"]
}
