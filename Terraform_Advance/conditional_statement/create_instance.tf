provider "aws" {
  region     = var.AWS_REGION
}

#Resource key pair
resource "aws_key_pair" "terraform_key" {
    key_name      = "terraform_key"
    public_key    = file(var.public_key_path)
}


module "ec2_cluster" {
    source = "github.com/terraform-aws-modules/terraform-aws-ec2-instance.git"

    name            = "my-cluster"
    ami             = "ami-0d71ea30463e0ff8d"
    instance_type   = "t2.micro"
    subnet_id       = "subnet-088dad867af90fd1e"
    count  = var.environment == "Production" ? 2 : 1       # If production environment, then spin up two instances, else spin up one instance
    key_name        = aws_key_pair.terraform_key.key_name
    security_groups = [aws_security_group.allow-terraform-ssh.id]   # test


    tags = {
    Terraform       = "true"
    Environment     = var.environment
    }
}
