output "kke_sns_topic_name" {
  value = aws_sns_topic.datacenter-sns-topic.name
}

output "kke_role_name" {
  value = aws_iam_role.datacenter-sns-role.name
}

output "kke_policy_name" {
  value = aws_iam_policy.datacenter-sns-policy.name
}