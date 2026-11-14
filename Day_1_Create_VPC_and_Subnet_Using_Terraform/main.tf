resource "aws_vpc" "nautilus-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = var.KKE_VPC_NAME
    }
}

resource "aws_subnet" "nautilus-subnet" {
    depends_on = [aws_vpc.nautilus-vpc]
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.nautilus-vpc.id
    tags = {
        Name = var.KKE_SUBNET_NAME
    }
}