# Create Instance using Custom VPC

module "develop-vpc" {
    source      = "../modules/vpc"

    ENVIRONMENT = var.ENVIRONMENT
    AWS_REGION  = var.AWS_REGION
}

provider "aws" {
  region = var.AWS_REGION
}

# Create Instance Group
resource "aws_instance" "my-instance" {
  ami           = var.AMI_ID
  instance_type = var.INSTANCE_TYPE

  # the VPC subnet
  subnet_id = element(module.develop-vpc.public_subnets, 0)
  availability_zone = "${var.AWS_REGION}a"

  # the security group
  vpc_security_group_ids = [aws_security_group.terrform-allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.terraform_key.key_name

  tags = merge (
  { "Name":"instance-${var.ENVIRONMENT}-${timestamp()}","Environment":var.ENVIRONMENT}
          )
}

