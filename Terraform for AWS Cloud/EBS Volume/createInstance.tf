
resource "aws_key_pair" "terraform_key" {
    key_name = "terraform_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

#Create AWS Instance
resource "aws_instance" "MyFirstInstnace" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  availability_zone = "eu-west-1a"
  key_name      = aws_key_pair.terraform_key.key_name
  vpc_security_group_ids = ["${aws_security_group.allow-terraform-ssh.id}"]

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }


  tags = {
    Name = "custom_instance"
  }
}

#Second EBS resource Creation
resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "eu-west-1a"
  size              = 10
  type              = "gp2"

  tags = {
    Name = "Secondary Volume Disk"
  }
}

#Atatch Second EBS volume with AWS Instance
resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.ebs-volume-1.id
  instance_id = aws_instance.MyFirstInstnace.id
  stop_instance_before_detaching = true
}