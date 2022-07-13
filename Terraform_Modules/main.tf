module "ec2_cluster" {
    source = "github.com/terraform-aws-modules/terraform-aws-ec2-instance.git"

    name    = "my-terraform-cluster"
    ami     = "ami-0d71ea30463e0ff8d"
    instance_type          = "t2.micro"
    subnet_id   = "subnet-088dad867af90fd1e"

    tags = {
    Terraform   = "true"
    Environment = "dev"
    }
}