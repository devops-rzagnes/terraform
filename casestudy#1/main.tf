# T
module "terraform-vpc" {
    source      = "./module/vpc"

    ENVIRONMENT = var.ENVIRONMENT
    AWS_REGION  = var.AWS_REGION
  AWS_ACCESS_KEY = var.AWS_ACCESS_KEY
  AWS_SECRET_ACCESS_KEY = var.AWS_SECRET_ACCESS_KEY
}

module "terraform-webserver" {
    source      = "./webserver"

    ENVIRONMENT = var.ENVIRONMENT
    AWS_REGION  = var.AWS_REGION
    vpc_private_subnet1 = module.terraform-vpc.private_subnet1_id
    vpc_private_subnet2 = module.terraform-vpc.private_subnet2_id
    vpc_id = module.terraform-vpc.my_vpc_id
    vpc_public_subnet1 = module.terraform-vpc.public_subnet1_id
    vpc_public_subnet2 = module.terraform-vpc.public_subnet2_id

    AWS_SECRET_ACCESS_KEY = var.AWS_SECRET_ACCESS_KEY
    AWS_ACCESS_KEY = var.AWS_ACCESS_KEY
}

#Define Provider
provider "aws" {
  region = var.AWS_REGION
}

output "load_balancer_output" {
  description = "Load Balancer"
  value       = module.terraform-webserver.load_balancer_output
}