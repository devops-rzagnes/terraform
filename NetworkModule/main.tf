#Provider
provider "aws" {
	region = var.region
    access_key = var.AWS_ACCESS_KEY
    secret_key = var.AWS_SECRET_KEY
}

#Module
module "myvpc" {
    source = "./module/network"
}

#Resource key pair
resource "aws_key_pair" "terraform_key" {
  key_name      = "terraform_key"
  public_key    = file(var.public_key_path)
}

#EC2 Instance
resource "aws_instance" "terraform_instance" {
  ami                       = var.instance_ami
  instance_type             = var.instance_type
  subnet_id                 = module.myvpc.public_subnet_id     # from ./module/network/output.tf
  vpc_security_group_ids    = module.myvpc.sg_22_id             # from ./module/network/output.tf
  key_name                  = aws_key_pair.terraform_key.key_name

  tags = merge (
  {"Environment":var.environment_tag, "Region": var.region}
  )
}