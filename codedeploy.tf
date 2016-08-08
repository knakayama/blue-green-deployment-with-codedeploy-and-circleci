resource "aws_s3_bucket" "codedeploy" {
  bucket        = "${var.name}-app"
  acl           = "private"
  force_destroy = true
}

resource "aws_codedeploy_app" "codedeploy" {
  name = "${var.name}-app"
}
