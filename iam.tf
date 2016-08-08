resource "aws_iam_role" "asg" {
  name               = "${var.name}-asg-role"
  assume_role_policy = "${file("${path.module}/policies/asg_assume_role_policy.json")}"
}

resource "aws_iam_instance_profile" "asg" {
  name  = "${var.name}-asg-role"
  roles = ["${aws_iam_role.asg.name}"]
}

resource "aws_iam_policy_attachment" "asg" {
  name       = "ReadOnlyAccess"
  roles      = ["${aws_iam_role.asg.name}"]
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_role" "codedeploy" {
  name               = "${var.name}-codedeploy-role"
  assume_role_policy = "${file("${path.module}/policies/codedeploy_assume_role_policy.json")}"
}

resource "aws_iam_policy_attachment" "codedeploy" {
  name       = "AWSCodeDeployRole"
  roles      = ["${aws_iam_role.codedeploy.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}
