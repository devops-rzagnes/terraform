variable "AWS_ACCESS_KEY" {
    type = string
    default = "AKIAQZ3KABO6QEPZ6U2H"
}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
default = "eu-west-1"
}

variable "Security_Group"{
    default = ["sg-24077", "sg-90989", "sg-456234"]
}

variable "AMIS" {
    default = {
        eu-west-2 = "ami-030770b178fa9d374"
        eu-east-1 = "ami-0d71ea30463e0ff8d"
        eu-west-1 = "ami-0bba0a4cb75835f71"
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
