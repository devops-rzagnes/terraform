
resource "aws_key_pair" "terraform_key" {
    key_name = "terraform_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "MyFirstInstnaceVPC2" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.terraform_key.key_name

  vpc_security_group_ids = [aws_security_group.allow-terraform-ssh.id]
  subnet_id = aws_subnet.terraform-vpc-test-public-2.id

  tags = {
    Name = "custom_instance"
  }

}