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
    default     = "Production"
}

variable "public_key_path" {
    description = "Public key path"
    default = "~/.ssh/terraform_key.pub"
}

variable "AMIS" {

    default = {
        eu-west-1 = "ami-0d71ea30463e0ff8d"
        eu-west-2 = "ami-030770b178fa9d374"
        us-west-2 = "ami-078a289ddf4b09ae0"
        us-west-1 = "ami-0f0f1c02e5e4d9d9f"
    }
}

variable "names" {
    description = "Test for list of names"
    default = ['mark','trinity','john']
}