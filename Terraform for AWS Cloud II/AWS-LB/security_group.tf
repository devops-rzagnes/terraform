#Security group for AWS ELB
resource "aws_security_group" "terraform-elb-securitygroup" {
  vpc_id      = aws_vpc.terraform-vpc-test.id
  name        = "terraform-elb-sg"
  description = "security group for Elastic Load Balancer"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0", "86.20.234.226/32"]
  }

  tags = {
    Name = "terraform-elb-sg"
  }
}

#Security group for the Instances
resource "aws_security_group" "terraform-instance" {
  vpc_id      = aws_vpc.terraform-vpc-test.id
  name        = "terraform-instance"
  description = "security group for instances"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0", "86.20.234.226/32"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.terraform-elb-securitygroup.id]
  }

  tags = {
    Name = "terraform-instance-sg"
  }
}