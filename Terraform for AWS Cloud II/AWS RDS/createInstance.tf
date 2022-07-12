resource "aws_key_pair" "terraform_key" {
  key_name = "terraform_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

#Create AWS Instance
resource "aws_instance" "MyFirstInstnace" {
  count = 1
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  availability_zone = "eu-west-1a"
  key_name      = aws_key_pair.terraform_key.key_name
  vpc_security_group_ids = ["${aws_security_group.allow-terraform-ssh.id}"]
  subnet_id = aws_subnet.terraform-vpc-test-public-1.id

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }


  tags = {
    Name = "terraform_instance_${count.index}"
  }
}

output "public_ip" {
  value = aws_instance.MyFirstInstnace[0].public_ip
}

output "private_ip" {
  value = aws_instance.MyFirstInstnace[0].private_ip
}