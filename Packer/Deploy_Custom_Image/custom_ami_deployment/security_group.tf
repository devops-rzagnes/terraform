#Resource key pair
resource "aws_key_pair" "terraform_key" {
  key_name      = "terraform_key"
  public_key    = file(var.public_key_path)
}

#Secutiry Group for Instances
resource "aws_security_group" "terraform-allow-ssh" {
  vpc_id      = module.develop-vpc.my_vpc_id
  name        = "allow-ssh-${var.ENVIRONMENT}"
  description = "security group that allows ssh traffic"

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
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["178.62.11.97/32", "86.20.234.226/32"]
  }

  tags = merge (
  { "Name":"terraform-allow-ssh","Environment":var.ENVIRONMENT }
  )
}
