variable "AWS_REGION" {
    type        = string
    default     = "eu-west-1"
}

variable "AWS_ACCESS_KEY" {
    type = string
    default = "AKIAQZ3KABO6QEPZ6U2H"
}

variable "AWS_SECRET_KEY" {}

variable "environment" {
    type        = string
    default     = "Development"
}

variable "public_key_path" {
    description = "Public key path"
    default = "~/.ssh/terraform_key.pub"
}