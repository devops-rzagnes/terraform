provider "aws" {
  region     = var.AWS_REGION
}

data "aws_availability_zones" "available" {
  state = "available"
}

# Main  vpc
resource "aws_vpc" "terraform-vpc" {
  cidr_block       = var.TERRAFORM_VPC_CIDR_BLOC
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "${var.ENVIRONMENT}-vpc-${timestamp()}"
  }
}

# Public subnets

#public Subnet 1
resource "aws_subnet" "terraform_vpc_public_subnet_1" {
  vpc_id     = aws_vpc.terraform-vpc.id
  cidr_block = var.TERRAFORM_VPC_PUBLIC_SUBNET1_CIDR_BLOCK
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = "true"
  tags = {
    Name = "${var.ENVIRONMENT}-terraform-vpc-public-subnet-1-${timestamp()}"
  }
}
#public Subnet 2
resource "aws_subnet" "terraform_vpc_public_subnet_2" {
  vpc_id     = aws_vpc.terraform-vpc.id
  cidr_block = var.TERRAFORM_VPC_PUBLIC_SUBNET2_CIDR_BLOCK
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = "true"
  tags = {
    Name = "${var.ENVIRONMENT}-terraform-vpc-public-subnet-2-${timestamp()}"
  }
}

# private subnet 1
resource "aws_subnet" "terraform_vpc_private_subnet_1" {
  vpc_id     = aws_vpc.terraform-vpc.id
  cidr_block = var.TERRAFORM_VPC_PRIVATE_SUBNET1_CIDR_BLOCK
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "${var.ENVIRONMENT}-terraform-vpc-private-subnet-1-${timestamp()}"
  }
}
# private subnet 2
resource "aws_subnet" "terraform_vpc_private_subnet_2" {
  vpc_id     = aws_vpc.terraform-vpc.id
  cidr_block = var.TERRAFORM_VPC_PRIVATE_SUBNET2_CIDR_BLOCK
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "${var.ENVIRONMENT}-terraform-vpc-private-subnet-2-${timestamp()}"
  }
}

# internet gateway
# Used by the custom VPC to communicate with the internet
resource "aws_internet_gateway" "terraform_igw" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name = "${var.ENVIRONMENT}-terraform-vpc-internet-gateway-${timestamp()}"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "terraform_nat_eip" {
  vpc      = true
  depends_on = [aws_internet_gateway.terraform_igw] # To set explicitly a dependency on the IGW
}

# NAT gateway for private ip address
resource "aws_nat_gateway" "terraform_ngw" {
  allocation_id = aws_eip.terraform_nat_eip.id
  subnet_id     = aws_subnet.terraform_vpc_public_subnet_1.id
  depends_on = [aws_internet_gateway.terraform_igw]   # To set explicitly a dependency on the IGW
  tags = {
    Name = "${var.ENVIRONMENT}-terraform-vpc-NAT-gateway-${timestamp()}"
  }
}

# Route Table for public Architecture
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.terraform-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_igw.id
  }

  tags = {
    Name = "${var.ENVIRONMENT}-terraform-public-route-table-${timestamp()}"
  }
}

# Route table for Private subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.terraform-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.terraform_ngw.id
  }

  tags = {
    Name = "${var.ENVIRONMENT}-terraform-private-route-table-${timestamp()}"
  }
}

# Route Table association with public subnets
resource "aws_route_table_association" "to_public_subnet1" {
  subnet_id      = aws_subnet.terraform_vpc_public_subnet_1.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "to_public_subnet2" {
  subnet_id      = aws_subnet.terraform_vpc_public_subnet_2.id
  route_table_id = aws_route_table.public.id
}

# Route table association with private subnets
resource "aws_route_table_association" "to_private_subnet1" {
  subnet_id      = aws_subnet.terraform_vpc_private_subnet_1.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "to_private_subnet2" {
  subnet_id      = aws_subnet.terraform_vpc_private_subnet_2.id
  route_table_id = aws_route_table.private.id
}



#Output Specific to Custom VPC
output "my_vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.terraform-vpc.id
}

output "private_subnet1_id" {
  description = "Subnet ID"
  value       = aws_subnet.terraform_vpc_private_subnet_1.id
}

output "private_subnet2_id" {
  description = "Subnet ID"
  value       = aws_subnet.terraform_vpc_private_subnet_2.id
}

output "public_subnet1_id" {
  description = "Subnet ID"
  value       = aws_subnet.terraform_vpc_public_subnet_1.id
}

output "public_subnet2_id" {
  description = "Subnet ID"
  value       = aws_subnet.terraform_vpc_private_subnet_2.id
}