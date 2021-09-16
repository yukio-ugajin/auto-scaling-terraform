resource "aws_lb" "test" {
  name               = "ugajin-test"
  internal           = false
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnets
  security_groups    = [
    aws_security_group.lb_sg.id,
    aws_security_group.ec2_sg.id
  ]

  tags = {
    Name = "ugajin-test"
  }
}

resource "aws_lb_listener" "test" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}

resource "aws_lb_target_group" "test" {
  name     = "ugajin-test"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}


resource "aws_lb_target_group" "test2" {
  name     = "tgimporttest"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}

#  terraform import aws_lb_target_group.test2 arn:aws:elasticloadbalancing:us-west-2:167855287371:targetgroup/tgimporttest/bde410f5f80458c8 
