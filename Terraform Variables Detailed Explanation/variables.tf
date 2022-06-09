variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
default = "eu-west-1"
}

variable "Security_Group"{
  default = ["sg-0ce8a6d06143e251b","sg-067ed0b523ff8c917"]

}

variable "AMIS" {
  default = {
    eu-west-1 = "ami-0d71ea30463e0ff8d"
    eu-west-2 = "ami-030770b178fa9d374"
}

}
