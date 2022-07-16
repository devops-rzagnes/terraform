# Create Resource for Development Environment

provider "aws" {
    region = var.AWS_REGION
}

module "dev-vpc" {
    source      = "../modules/vpc"

    ENVIRONMENT = var.Env
    AWS_REGION  = var.AWS_REGION
    AWS_ACCESS_KEY = var.AWS_ACCESS_KEY
    AWS_SECRET_KEY = var.AWS_SECRET_KEY
}

module "dev-instances" {
    source          = "../modules/instances"

    ENVIRONMENT     = var.Env
    AWS_REGION      = var.AWS_REGION 
    VPC_ID          = module.dev-vpc.my_vpc_id
    PUBLIC_SUBNETS  = module.dev-vpc.public_subnets
}
