#Define Security Groups for RDS Instances
resource "aws_security_group" "terraform-rds-sg" {

  name = "${var.ENVIRONMENT}-terraform-rds-sg-${timestamp()}"
  description = "Created by terraform"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [var.RDS_CIDR]

  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.ENVIRONMENT}-terraform-rds-sg-${timestamp()}"
  }
}
