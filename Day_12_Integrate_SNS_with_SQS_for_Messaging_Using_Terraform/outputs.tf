output "kke_sns_topic_arn" {
  value = aws_sns_topic.datacenter-sns-topic.arn
}
output "kke_sqs_queue_url" {
  value = aws_sqs_queue.datacenter-sqs-queue.url
}
