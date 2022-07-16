# Create Resource for Development Environment

module "prod-vpc" {
    source      = "../modules/vpc"

    ENVIRONMENT = var.Env
    AWS_REGION  = var.AWS_REGION
    AWS_SECRET_KEY = var.AWS_SECRET_KEY
    AWS_ACCESS_KEY = var.AWS_ACCESS_KEY
}

module "prod-instances" {
    source          = "../modules/instances"

    ENVIRONMENT     = var.Env
    AWS_REGION      = var.AWS_REGION 
    VPC_ID          = module.prod-vpc.my_vpc_id
    PUBLIC_SUBNETS  = module.prod-vpc.public_subnets
}

provider "aws" {
  region = var.AWS_REGION
}