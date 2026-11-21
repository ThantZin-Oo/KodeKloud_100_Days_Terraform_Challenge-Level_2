# 1. Fetch the latest Amazon Linux 2 AMI from AWS
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
# 2. Assign the retrieved AMI ID to a local variable
locals {
  AMI_ID = data.aws_ami.amazon_linux_2.id
}