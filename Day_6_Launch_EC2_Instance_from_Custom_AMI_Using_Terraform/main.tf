# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    "sg-b73f5635dd7263a5f"
  ]

  tags = {
    Name = "datacenter-ec2"
  }
}

resource "aws_ami_from_instance" "ami" {
  depends_on         = [aws_instance.ec2]
  name               = "datacenter-ec2-ami"
  source_instance_id = aws_instance.ec2.id
}

resource "aws_instance" "new-ec2" {
  depends_on    = [aws_ami_from_instance.ami]
  ami           = aws_ami_from_instance.ami.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    "sg-b73f5635dd7263a5f"
  ]

  tags = {
    Name = "datacenter-ec2-new"
  }
}
