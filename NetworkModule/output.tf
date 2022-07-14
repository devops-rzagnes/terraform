output "public_instance_ip" {
  value = [aws_instance.terraform_instance.public_ip]
}

output "private_instance_ip" {
  value = [aws_instance.terraform_instance.private_ip]
}