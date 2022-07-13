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

variable "SubnetID" {
  default = {
    eu-west-1a = "subnet-0df6666ad64d5baf6"
    eu-west-1b = "subnet-088dad867af90fd1e"
    eu-west-1c = "subnet-074ec187b4a76d531"
    eu-west-2a= "subnet-00241b81e2914a3a0"
    eu-west-2b = "subnet-07dd9286fd9b57d38"
    eu-west-2c = "subnet-0ed51d256bbb2da6d"

  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "terraform_key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "terraform_key.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ec2-user"
}