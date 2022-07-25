variable "cluster-name" {
  default = "terraform-test-eks"
  type    = string
}

variable "AWS_REGION" {
  default = "eu-west-1"
}


variable "AWS_SECRET_ACCESS_KEY" {}

variable "AWS_ACCESS_KEY" {
  type = string
  default = "AKIAQZ3KABO6QEPZ6U2H"
}