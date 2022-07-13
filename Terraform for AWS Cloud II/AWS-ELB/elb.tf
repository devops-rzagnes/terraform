#AWS ELB Configuration
resource "aws_elb" "terraform-elb" {
  name            = "terraform-elb"
  subnets         = [aws_subnet.terraform-vpc-test-public-1.id, aws_subnet.terraform-vpc-test-private-2.id]
  security_groups = [aws_security_group.terraform-elb-securitygroup.id]  # added ssh group for test purposes

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "terraform-elb"
  }
}
