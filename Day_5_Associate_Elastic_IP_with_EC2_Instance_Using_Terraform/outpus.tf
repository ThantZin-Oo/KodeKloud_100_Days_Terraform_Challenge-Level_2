output "KKE_instance_name" {
  value = aws_instance.datacenter-instance.tags["Name"]
}
output "KKE_eip" {
  value = aws_eip.datacenter-eip.public_ip
}