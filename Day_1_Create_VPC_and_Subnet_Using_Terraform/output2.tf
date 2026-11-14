output "kke_vpc_name" {
    value = aws_vpc.nautilus-vpc.tags["Name"]
}

output "kke_subnet_name" {
    value = aws_subnet.nautilus-subnet.tags["Name"]
}