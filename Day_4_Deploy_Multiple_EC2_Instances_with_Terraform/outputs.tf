output "kke_instance_names" {
  value = [for instance in aws_instance.datacenter-instance : instance.tags["Name"]]
}