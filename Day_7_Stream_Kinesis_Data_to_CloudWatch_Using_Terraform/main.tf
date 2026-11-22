resource "aws_kinesis_stream" "xfusion-kinesis-stream" {
  name             = "xfusion-kinesis-stream"
  shard_count      = 1
  retention_period = 48

  shard_level_metrics = [
    "IncomingBytes",
    "IncomingRecords",
    "WriteProvisionedThroughputExceeded",
    "ReadProvisionedThroughputExceeded",
  ]

  stream_mode_details {
    stream_mode = "PROVISIONED"
  }
}

resource "aws_cloudwatch_metric_alarm" "xfusion-kinesis-alarm" {
  alarm_name                = "xfusion-kinesis-alarm"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 1
  metric_name               = "WriteProvisionedThroughputExceeded"
  namespace                 = "AWS/Kinesis"
  period                    = 60
  statistic                 = "Sum"
  threshold                 = 1
  alarm_description         = "Triggers when write provisioned throughput is exceeded for xfusion-kinesis-stream"
  insufficient_data_actions = []

  dimensions = {
    StreamName = aws_kinesis_stream.xfusion-kinesis-stream.name
  }
}


