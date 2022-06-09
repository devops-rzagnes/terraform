
resource "aws_instance" "MyFirstInstnace" {
  ami           = "ami-0d71ea30463e0ff8d"
  instance_type = "t2.micro"

  tags = {
    Name = "demoinstnce"
  }

}
