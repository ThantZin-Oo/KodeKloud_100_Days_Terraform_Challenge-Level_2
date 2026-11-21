resource "aws_instance" "datacenter-instance" {
  ami           = local.AMI_ID
  instance_type = "t2.micro"
  tags = {
    Name = var.KKE_instance_name
  }
}

resource "aws_eip" "datacenter-eip" {
  domain = "vpc"

  tags = {
    Name = var.KKE_eip
  }
}

# 4. Associate the Elastic IP with the EC2 instance
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.datacenter-instance.id
  allocation_id = aws_eip.datacenter-eip.id
}