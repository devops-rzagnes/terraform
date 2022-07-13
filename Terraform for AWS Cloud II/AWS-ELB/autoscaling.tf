#AutoScaling Launch Configuration
resource "aws_launch_configuration" "terraform-launchconfig" {
  name_prefix     = "terraform-launchconfig"
  image_id        = lookup(var.AMIS, var.AWS_REGION)
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.terraform_key.key_name
  security_groups = [aws_security_group.terraform-instance.id]
  user_data       = "#!/bin/bash\nyum -y update\nyum -y install httpd nginx\nsystemctl start nginx\nsystemctl enable nginx\nMYIP=`ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'Hello Team\nThis is my IP: '$MYIP  and $(hostname -f) at $(date +'%Y-%m-%d %H:%M:%S')> /var/www/html/index.html"

  lifecycle {
    create_before_destroy = true
  }
}

#Generate Key
resource "aws_key_pair" "terraform_key" {
    key_name = "terraform_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

#Autoscaling Group
resource "aws_autoscaling_group" "levelup-autoscaling" {
  name                      = "levelup-autoscaling"
  vpc_zone_identifier       = [aws_subnet.terraform-vpc-test-public-1.id, aws_subnet.terraform-vpc-test-public-2.id]
  launch_configuration      = aws_launch_configuration.terraform-launchconfig.name
  min_size                  = 2
  max_size                  = 2
  health_check_grace_period = 200
  health_check_type         = "ELB"
  load_balancers            = [aws_elb.terraform-elb.name]
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "LevelUp Custom EC2 instance via LB"
    propagate_at_launch = true
  }
}
