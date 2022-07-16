#Define Variable for Custom Module VPC

variable "AWS_REGION" {
    type    = string
    default = "eu-west-1"
}

variable "ENVIRONMENT" {
    type    = string
    default = ""
}

variable "AWS_SECRET_KEY" {}

variable "AWS_ACCESS_KEY" {
    type = string
    default = "AKIAQZ3KABO6QEPZ6U2H"
}
