# Variable for Create Instance Module
variable "public_key_path" {
  description = "Public key path"
  default = "~/.ssh/terraform_key.pub"
}

variable "ENVIRONMENT" {
    type    = string
    default = "Development"
}

variable "AMI_ID" {
    type    = string
    default = ""
}

variable "AWS_REGION" {
default = "eu-west-1"
}

variable "AWS_ACCESS_KEY" {
  type = string
  default = "AKIAQZ3KABO6QEPZ6U2H"
}

variable "AWS_SECRET_ACCESS_KEY" {}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}