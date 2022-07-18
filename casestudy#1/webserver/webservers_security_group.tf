
resource "aws_security_group" "terraform_webservers"{
  tags = {
    Name = "${var.ENVIRONMENT}-terraform-webservers"
  }

  name          = "${var.ENVIRONMENT}-terraform-webservers"
  description   = "Created by terraform"
  vpc_id        = var.vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.SSH_CIDR_WEB_SERVER]

  }

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

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}