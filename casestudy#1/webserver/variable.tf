variable "SSH_CIDR_WEB_SERVER" {
    type = string
    default = "0.0.0.0/0"
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "AMIS" {

  default = {
    eu-west-1 = "ami-0d71ea30463e0ff8d"
    eu-west-2 = "ami-030770b178fa9d374"
    eu-west-2 = "ami-078a289ddf4b09ae0"
    eu-west-1 = "ami-0bba0a4cb75835f71"
    us-west-2 = "ami-098e42ae54c764c35"
  }
}

variable "AWS_REGION" {
    type        = string
    default     = "eu-west-1"
}

variable "ENVIRONMENT" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = "Development"
}

variable "public_key_path" {
  description = "Public key path"
  default = "~/.ssh/terraform_key.pub"
}

variable "vpc_private_subnet1" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}

variable "vpc_private_subnet2" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}


variable "vpc_public_subnet1" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}

variable "vpc_public_subnet2" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}

variable "AWS_SECRET_ACCESS_KEY" {}

variable "AWS_ACCESS_KEY" {
  type = string
  default = "AKIAQZ3KABO6QEPZ6U2H"
}