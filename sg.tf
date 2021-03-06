resource "aws_security_group" "lb_sg" {
  name   = "ugajin-test"
  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "ugajin-test"
  }
}

resource "aws_security_group_rule" "lb_sg" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lb_sg.id
}

resource "aws_security_group" "ec2_sg" {
  name   = "ugajin-ec2-test"
  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "ugajin-test"
  }
}

resource "aws_security_group_rule" "ec2_sg" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  self              = true
  security_group_id = aws_security_group.ec2_sg.id
}

resource "aws_security_group_rule" "ec2_sg1" {
  type              = "egress"
  from_port         = 0
  to_port           = 65536
  protocol          = "-1" # TCP/UDP両方の指定
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_sg.id
}
