#AWS ELB Configuration
resource "aws_lb" "terraform-elb" {
  name            = "terraform-elb"
  load_balancer_type = "application"

  subnets         = [aws_subnet.terraform-vpc-test-public-1.id, aws_subnet.terraform-vpc-test-private-2.id]
  security_groups = [aws_security_group.terraform-elb-securitygroup.id]  # added ssh group for test purposes


  enable_cross_zone_load_balancing   = true
  idle_timeout = 200

  tags = {
    Name = "terraform-elb"
  }
}
