output "kke_dynamodb_table" {
  value = aws_dynamodb_table.xfusion-table.name
}

output "kke_iam_role_name" {
  value = aws_iam_role.xfusion-role.name
}

output "kke_iam_policy_name" {
  value = aws_iam_policy.xfusion-readonly-policy.name
}