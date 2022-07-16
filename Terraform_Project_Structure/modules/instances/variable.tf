# Variable for Create Instance Module
variable "public_key_path" {
  description = "Public path to ssh key"
  default = "~/.ssh/terraform_key.pub"
}

variable "VPC_ID" {
    type = string
    default = ""
}

variable "ENVIRONMENT" {
    type    = string
    default = ""
}

variable "AWS_REGION" {
default = "eu-west-1"
}

variable "AMIS" {

    default = {
      eu-west-1 = "ami-0d71ea30463e0ff8d"
      eu-west-2 = "ami-030770b178fa9d374"
      eu-west-2 = "ami-078a289ddf4b09ae0"
      eu-west-1 = "ami-0f0f1c02e5e4d9d9f"
    }
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "PUBLIC_SUBNETS" {
#  type = "list"
  default = []
}