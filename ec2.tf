
data "aws_ami" "test" {
  name_regex = "^amzn2-ami-hvm-2.0.2021*"	
  most_recent = true
  owners = ["amazon"]
}
resource "aws_launch_template" "test" {
  name = "ugajin-test"
  image_id = data.aws_ami.test.image_id

  iam_instance_profile {
    arn = aws_iam_instance_profile.test.arn
  }

  instance_type = "t2.micro"
  key_name = "ugajin-autoscaling-key"

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ugajin-test"
    }
  }

  user_data = filebase64("./example.sh")
}

resource "aws_iam_instance_profile" "test" {
  name = "ugajin-test"
  role = aws_iam_role.test.name
}