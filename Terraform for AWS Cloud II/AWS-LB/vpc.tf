#Create AWS VPC
resource "aws_vpc" "terraform-vpc-test" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags = {
    Name = "terraform-vpc-test"
  }
}

# Public Subnets in Custom VPC
resource "aws_subnet" "terraform-vpc-test-public-1" {
  vpc_id                  = aws_vpc.terraform-vpc-test.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-1a"

  tags = {
    Name = "terraform-vpc-test-public-1"
  }
}

resource "aws_subnet" "terraform-vpc-test-public-2" {
  vpc_id                  = aws_vpc.terraform-vpc-test.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-1b"

  tags = {
    Name = "terraform-vpc-test-public-2"
  }
}

resource "aws_subnet" "terraform-vpc-test-public-3" {
  vpc_id                  = aws_vpc.terraform-vpc-test.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-1c"

  tags = {
    Name = "terraform-vpc-test-public-3"
  }
}

# Private Subnets in Custom VPC
resource "aws_subnet" "terraform-vpc-test-private-1" {
  vpc_id                  = aws_vpc.terraform-vpc-test.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-1a"

  tags = {
    Name = "terraform-vpc-test-private-1"
  }
}

resource "aws_subnet" "terraform-vpc-test-private-2" {
  vpc_id                  = aws_vpc.terraform-vpc-test.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-1b"

  tags = {
    Name = "terraform-vpc-test-private-2"
  }
}

resource "aws_subnet" "terraform-vpc-test-private-3" {
  vpc_id                  = aws_vpc.terraform-vpc-test.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-1c"

  tags = {
    Name = "terraform-vpc-test-private-3"
  }
}

# Custom internet Gateway
resource "aws_internet_gateway" "terraform-vpc2-gw" {
  vpc_id = aws_vpc.terraform-vpc-test.id

  tags = {
    Name = "terraform-vpc2-gw"
  }
}

#Routing Table for the Custom VPC
resource "aws_route_table" "terraform-vpc2-public" {
  vpc_id = aws_vpc.terraform-vpc-test.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform-vpc2-gw.id
  }

  tags = {
    Name = "terraform-vpc2-public-1"
  }
}

resource "aws_route_table_association" "terraform-vpc2-public-1-a" {
  subnet_id      = aws_subnet.terraform-vpc-test-public-1.id
  route_table_id = aws_route_table.terraform-vpc2-public.id
}

resource "aws_route_table_association" "terraform-vpc2-public-2-a" {
  subnet_id      = aws_subnet.terraform-vpc-test-public-2.id
  route_table_id = aws_route_table.terraform-vpc2-public.id
}

resource "aws_route_table_association" "terraform-vpc2-public-3-a" {
  subnet_id      = aws_subnet.terraform-vpc-test-public-3.id
  route_table_id = aws_route_table.terraform-vpc2-public.id
}
