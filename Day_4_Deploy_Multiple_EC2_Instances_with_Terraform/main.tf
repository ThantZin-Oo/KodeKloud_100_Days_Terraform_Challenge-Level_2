resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_key" {
  filename        = "${path.module}/datacenter-key.pem"
  content         = tls_private_key.pk.private_key_pem
  file_permission = "0400"
}

resource "aws_key_pair" "datacenter-key" {
  key_name   = var.KKE_KEY_NAME
  public_key = tls_private_key.pk.public_key_openssh
}

resource "aws_instance" "datacenter-instance" {
  count         = var.KKE_INSTANCE_COUNT
  ami           = local.AMI_ID
  instance_type = var.KKE_INSTANCE_TYPE
  key_name      = aws_key_pair.datacenter-key.key_name

  tags = {
    Name = "${var.KKE_INSTANCE_PREFIX}-${count.index + 1}"
  }
}