provider "aws" {
  region     = var.AWS_REGION
}

#Resource key pair
resource "aws_key_pair" "terraform_key" {
    key_name      = "terraform_key"
    public_key    = file(var.public_key_path)
}

resource "aws_db_subnet_group" "mariadb-subnets" {
    name        = "mariadb-subnets"
    description = "Amazon RDS subnet group"
    subnet_ids  = [aws_subnet.terraform-vpc-test-private-1.id, aws_subnet.terraform-vpc-test-private-2.id]
}


module "ec2_cluster" {
    source = "github.com/terraform-aws-modules/terraform-aws-ec2-instance.git"


#    ami             = "ami-0d71ea30463e0ff8d"
    ami           = lookup(var.AMIS, var.AWS_REGION)
    instance_type   = "t2.micro"
    subnet_id       = "subnet-088dad867af90fd1e"
#    subnet_id = aws_subnet.terraform-vpc-test-public-2.id       ## test
    count  = var.environment == "Production" ? 2 : 1       # If production environment, then spin up two instances, else spin up one instance
    name            = "my-cluster-${count.index}-${timestamp()}"
    key_name        = aws_key_pair.terraform_key.key_name
    vpc_security_group_ids = [aws_security_group.allow-terraform-ssh.id]   # test



    tags = {
    Terraform       = "true"
    Environment     = var.environment
    }
}
