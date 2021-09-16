resource "aws_autoscaling_group" "test" {
  name                = "ugajin-test"
  min_size            = 2
  max_size            = 2
  desired_capacity    = 2
  vpc_zone_identifier = module.vpc.private_subnets
  target_group_arns   = [aws_lb_target_group.test.arn]

  launch_template {
    id = aws_launch_template.test.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }
}
