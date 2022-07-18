
variable "ENVIRONMENT" {
    type    = string
    default = "development"
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
default = "eu-west-1"
}

variable "AWS_ACCESS_KEY" {
    default = "AKIAQZ3KABO6QEPZ6U2H"
}

variable "AWS_SECRET_ACCESS_KEY" {}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}