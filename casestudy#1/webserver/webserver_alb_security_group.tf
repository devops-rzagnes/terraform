resource "aws_security_group" "terraform_webservers_alb" {
  tags = {
    Name = "${var.ENVIRONMENT}-terraform-webservers-ALB-${timestamp()}"
  }
  name = "${var.ENVIRONMENT}-terraform-webservers-ALB-${timestamp()}"
  description = "Created by terraform"
  vpc_id      = var.vpc_id 

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["178.62.11.97/32", "86.20.234.226/32"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
