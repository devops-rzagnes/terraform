variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
default = "eu-west-1"
}

variable "Security_Group"{
  type = "list"
  default = ["sg-0ce8a6d06143e251b","sg-067ed0b523ff8c917"]

}
