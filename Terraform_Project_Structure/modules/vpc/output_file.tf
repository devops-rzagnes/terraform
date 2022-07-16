#Output Specific to Custom VPC
output "my_vpc_id" {
  description = "VPC ID"
  value       = module.terraform-vpc.vpc_id
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.terraform-vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.terraform-vpc.public_subnets
}