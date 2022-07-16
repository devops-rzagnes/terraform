# Create Instance Group
resource "aws_instance" "my-instance" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = var.INSTANCE_TYPE

  # the VPC subnet
  subnet_id = element(var.PUBLIC_SUBNETS, 0)
  availability_zone = "${var.AWS_REGION}a"

  # the security group
  vpc_security_group_ids = [aws_security_group.terraform-allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.terraform_key.key_name

  tags = merge (
  { "Name" : "instance-${var.ENVIRONMENT}-${timestamp()}", "Environment": var.ENVIRONMENT }
          )
}
