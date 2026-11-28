# Add your code below
resource "aws_sns_topic" "datacenter-sns-topic" {
  name = local.KKE_SNS_TOPIC_NAME
}

resource "aws_iam_role" "datacenter-sns-role" {
  name = local.KKE_ROLE_NAME

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "AllowSNSPublish"
        Principal = {
          Service = ["ec2.amazonaws.com"]
        }
      },
    ]
  })
}

data "aws_iam_policy_document" "sns_publish_doc" {
  statement {
    sid       = "AllowSNSPublish"
    effect    = "Allow"
    actions   = ["sns:Publish"]
    resources = [aws_sns_topic.datacenter-sns-topic.arn]
  }
}
resource "aws_iam_policy" "datacenter-sns-policy" {
  name        = "datacenter-sns-policy"
  description = "A test policy"
  policy      = data.aws_iam_policy_document.sns_publish_doc.json
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.datacenter-sns-role.name
  policy_arn = aws_iam_policy.datacenter-sns-policy.arn
}
