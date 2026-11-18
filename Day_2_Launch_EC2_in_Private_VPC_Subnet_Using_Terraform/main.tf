resource "aws_vpc" "nautilus-priv-vpc" {
  cidr_block = var.KKE_VPC_CIDR
  tags = {
    Name = "nautilus-priv-vpc"
  }
}

resource "aws_subnet" "nautilus-priv-subnet" {
  vpc_id     = aws_vpc.nautilus-priv-vpc.id
  cidr_block = var.KKE_SUBNET_CIDR
  tags = {
    Name = "nautilus-priv-subnet"
  }
}

resource "aws_security_group" "nautilus-sg" {
  name        = "nautilus-sg"
  description = "Allow inbound traffic only from within the VPC"
  vpc_id      = aws_vpc.nautilus-priv-vpc.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.nautilus-priv-vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "nautilus-sg"
  }
}

resource "aws_instance" "nautilus-priv-ec2" {
  ami                         = "ami-0c55b159cbfafe1f0"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.nautilus-priv-subnet.id
  vpc_security_group_ids      = [aws_security_group.nautilus-sg.id]
  associate_public_ip_address = false
  tags = {
    Name = "nautilus-priv-ec2"
  }
  lifecycle {
    ignore_changes = [
      vpc_security_group_ids,
    ]
  }
}