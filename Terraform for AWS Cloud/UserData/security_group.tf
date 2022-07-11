#Security Group for terraform
resource "aws_security_group" "allow-terraform-ssh" {
  name        = "allow-terraform-ssh"
  description = "security group that allows ssh connection"

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
    cidr_blocks = ["178.62.11.97/32", "86.20.234.226/32"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["178.62.11.97/32", "86.20.234.226/32"]
  }

  tags = {
    Name = "allow-terraform-ssh"
  }
}