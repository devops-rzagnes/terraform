variable "region" {
  default = "eu-west-2"
}

variable "public_key_path" {
  description = "Public key path"
  default = "~/.ssh/terraform_key.pub"
}

variable "instance_ami" {
  description = "AMI for aws EC2 instance"
  default = "ami-030770b178fa9d374"
}

variable "instance_type" {
  description = "type for aws EC2 instance"
  default = "t2.micro"
}

variable "environment_tag" {
  description = "Environment tag"
  default = "Production"
}
