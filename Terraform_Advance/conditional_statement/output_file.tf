output "public_ip" {
  description = "List of public EC2 IPS"
#  value = try(module.ec2_cluster[0].public_ip, "")
  value = try(module.ec2_cluster.*.public_ip, "")
}

output "upper_name" {
  value = [for i in var.names:upper(i)]
}