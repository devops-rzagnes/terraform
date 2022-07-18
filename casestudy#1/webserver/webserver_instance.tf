 module "terraform-vpc" {
     source      = "../module/vpc"

     ENVIRONMENT = var.ENVIRONMENT
     AWS_REGION  = var.AWS_REGION
   AWS_ACCESS_KEY = var.AWS_ACCESS_KEY
   AWS_SECRET_ACCESS_KEY = var.AWS_SECRET_ACCESS_KEY
 }

module "terraform-rds" {
    source      = "../module/rds"

    ENVIRONMENT = var.ENVIRONMENT
    AWS_REGION  = var.AWS_REGION
    vpc_private_subnet1 = var.vpc_private_subnet1
    vpc_private_subnet2 = var.vpc_private_subnet2
    vpc_id = var.vpc_id
  AWS_SECRET_ACCESS_KEY = var.AWS_SECRET_ACCESS_KEY
  AWS_ACCESS_KEY = var.AWS_ACCESS_KEY
}


#Resource key pair
resource "aws_key_pair" "terraform_key" {
  key_name      = "terraform_key"
  public_key    = file(var.public_key_path)
}

# This is required for ASGs
resource "aws_launch_configuration" "launch_config_webserver" {
  name   = "launch_config_webserver"
  image_id      = lookup(var.AMIS, var.AWS_REGION)
  instance_type = var.INSTANCE_TYPE
  user_data = "#!/bin/bash\nyum -y update\nyum -y install httpd\nsystemctl start httpd\nsystemctl enable httpd\nMYIP=`ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'Hello Team\nThis is my IP\t '$MYIP  and my hostname is $(hostname -f) at $(date +'%Y-%m-%d %H:%M:%S')> /var/www/html/index.html"
  security_groups = [aws_security_group.terraform_webservers.id]
  key_name = aws_key_pair.terraform_key.key_name
  
  root_block_device {
    volume_type = "gp2"
    volume_size = "10"
  }
}

resource "aws_autoscaling_group" "terraform_webserver" {
  name                      = "Terraform_WebServers-${var.ENVIRONMENT}"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 30
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = true
  launch_configuration      = aws_launch_configuration.launch_config_webserver.name
  vpc_zone_identifier       = [var.vpc_public_subnet1, var.vpc_public_subnet2]
  target_group_arns         = [aws_lb_target_group.load-balancer-target-group.arn]
}

#Application load balancer for app server
resource "aws_lb" "terraform-load-balancer" {
  name               = "${var.ENVIRONMENT}-terraform-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.terraform_webservers_alb.id]
  subnets            = [var.vpc_public_subnet1, var.vpc_public_subnet2]

}

# Add Target Group
resource "aws_lb_target_group" "load-balancer-target-group" {
  name     = "load-balancer-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# Adding HTTP listener
resource "aws_lb_listener" "webserver_listener" {
  load_balancer_arn = aws_lb.terraform-load-balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.load-balancer-target-group.arn
    type             = "forward"
  }
}

output "load_balancer_output" {
  value = aws_lb.terraform-load-balancer.dns_name
}
