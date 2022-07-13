#AutoScaling Launch Configuration
resource "aws_launch_configuration" "terraform-launchconfig" {
  name_prefix     = "terraform-launchconfig"
  image_id        = lookup(var.AMIS, var.AWS_REGION)
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.terraform_key.key_name
  vpc_security_group_ids = [aws_security_group.allow-terraform-ssh.id]

}

#Generate Key
resource "aws_key_pair" "terraform_key" {
    key_name = "terraform_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

#Autoscaling Group
resource "aws_autoscaling_group" "terraform-autoscaling" {
  name                      = "terraform-autoscaling"
  vpc_zone_identifier       = ["eu-west-1a", "eu-west-1b"]
  launch_configuration      = aws_launch_configuration.terraform-launchconfig.name
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 200
  health_check_type         = "EC2"
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "terraform Custom EC2 instance"
    propagate_at_launch = true
  }
}

#Autoscaling Configuration policy - Scaling Alarm
resource "aws_autoscaling_policy" "terraform-cpu-policy" {
  name                   = "terraform-cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.terraform-autoscaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"    # Scale nodes one at a time
  cooldown               = "200"
  policy_type            = "SimpleScaling"
}

#Auto scaling Cloud Watch Monitoring
resource "aws_cloudwatch_metric_alarm" "terraform-cpu-alarm" {
  alarm_name          = "terraform-cpu-alarm"
  alarm_description   = "Alarm once CPU Uses Increase"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.terraform-autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.terraform-cpu-policy.arn]
}

#Auto Descaling Policy. This is required to minmize cost and ensure the current state of teh machines
resource "aws_autoscaling_policy" "terraform-cpu-policy-scaledown" {
  name                   = "terraform-cpu-policy-scaledown"
  autoscaling_group_name = aws_autoscaling_group.terraform-autoscaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"     # decrease the number of nodes one at a time
  cooldown               = "200"
  policy_type            = "SimpleScaling"
}

#Auto descaling cloud watch 
resource "aws_cloudwatch_metric_alarm" "terraform-cpu-alarm-scaledown" {
  alarm_name          = "terraform-cpu-alarm-scaledown"
  alarm_description   = "Alarm once CPU Uses Decrease"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.terraform-autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.terraform-cpu-policy-scaledown.arn]
}