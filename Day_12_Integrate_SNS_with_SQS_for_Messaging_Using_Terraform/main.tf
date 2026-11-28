resource "aws_sns_topic" "datacenter-sns-topic" {
  name = "datacenter-sns-topic"
}

resource "aws_sqs_queue" "datacenter-sqs-queue" {
  name = "datacenter-sqs-queue"
}

data "aws_iam_policy_document" "sqs_queue_policy" {
  statement {
    sid    = "user_updates_sqs_target"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = "sns.amazonaws.com"
    }
    actions = [
      "SQS:SendMessage",
    ]
    resources = [
      aws_sqs_queue.datacenter-sqs-queue.arn,
    ]
  }
}

resource "aws_sqs_queue_policy" "datacenter-sqs-queue-policy" {
  queue_url = aws_sqs_queue.datacenter-sqs-queue.id
  policy = data.aws_iam_policy_document.sqs_queue_policy.json
}

resource "aws_sns_topic_subscription" "datacenter-sns-sub" {
  topic_arn = aws_sns_topic.datacenter-sns-topic.arn
  protocol = "sqs"
  endpoint = aws_sqs_queue.datacenter-sqs-queue.arn
}