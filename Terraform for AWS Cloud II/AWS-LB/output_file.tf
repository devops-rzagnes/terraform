output "ELB" {
  value = aws_lb.terraform-elb.dns_name
}