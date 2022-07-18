output "public_ip" {
  description = "List of public EC2 IPS"
  value = try(module.terraform-rds.rds_prod_endpoint)
}

#output "private_ip" {
#  description = "List of private EC2 IPs"
#  value = try(aws_instance.my-instance.*.private_ip, "")
#}