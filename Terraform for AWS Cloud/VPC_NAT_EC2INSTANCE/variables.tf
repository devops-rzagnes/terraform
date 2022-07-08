variable "AWS_ACCESS_KEY" {
    type = string
    default = "AKIAQZ3KABO6QEPZ6U2H"
}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
default = "eu-west-1"
}

variable "AMIS" {

    default = {
        eu-west-1 = "ami-0d71ea30463e0ff8d"
        eu-west-2 = "ami-030770b178fa9d374"
        us-west-2 = "ami-078a289ddf4b09ae0"
        us-west-1 = "ami-0f0f1c02e5e4d9d9f"
    }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "terraform_key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "terraform_key.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}