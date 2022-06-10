variable "AWS_ACCESS_KEY" {
    type = string
    default = "AKIASMSIZOF42P2VUDSZ"
}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
default = "eu-west-1"
}

variable "Security_Group"{
    default = ["sg-067ed0b523ff8c917", "sg-0ce8a6d06143e251b", "sg-0064055deeb03cb44"]
}

variable "AMIS" {
    default = {
        eu-west-2 = "ami-030770b178fa9d374"
        eu-east-1 = "ami-0d71ea30463e0ff8d"
        eu-west-1 = "ami-0f0f1c02e5e4d9d9f"
        eu-west-2 = "ami-078a289ddf4b09ae0"
    }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "terra_rz_key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "terra_rz_key.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
