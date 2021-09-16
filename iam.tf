resource "aws_iam_role" "test" {
  name = "ugajin-test"
  assume_role_policy = data.aws_iam_policy_document.test.json
}

# コンソールでいうところの信頼関係の記述部分
# 信頼関係はroleにしかない概念
data "aws_iam_policy_document" "test" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy_attachment" "test" {
  name       = "ugajin-test"
  roles      = [aws_iam_role.test.name]
  policy_arn = data.aws_iam_policy.AmazonSSMManagedInstanceCore.arn
}

data "aws_iam_policy" "AmazonSSMManagedInstanceCore" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}