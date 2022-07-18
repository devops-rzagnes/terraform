variable "AWS_REGION" {
    type        = string
    default     = "eu-west-1"
}

variable "AWS_ACCESS_KEY" {
  type = "string"
  value = "AKIAQZ3KABO6QEPZ6U2H"
}

variable "AWS_SECRET_ACCESS_KEY" {}

variable "TERRAFORM_VPC_CIDR_BLOC" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "TERRAFORM_VPC_PUBLIC_SUBNET1_CIDR_BLOCK" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.101.0/24"
}

variable "TERRAFORM_VPC_PUBLIC_SUBNET2_CIDR_BLOCK" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.102.0/24"
}

variable "TERRAFORM_VPC_PRIVATE_SUBNET1_CIDR_BLOCK" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.1.0/24"
}

variable "TERRAFORM_VPC_PRIVATE_SUBNET2_CIDR_BLOCK" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.2.0/24"
}

variable "ENVIRONMENT" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = "Development"
}

