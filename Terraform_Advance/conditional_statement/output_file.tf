output "public_ip" {
  value = try(module.ec2_cluster[0].public_ip, "")
}