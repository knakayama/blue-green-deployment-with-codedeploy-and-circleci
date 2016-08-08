output "s3_bucket" {
  value = "${module.prd.s3_bucket}"
}

output "elb_dns_name" {
  value = "${module.prd.elb_dns_name}"
}
