output "kke_kinesis_stream_name" {
  value = aws_kinesis_stream.xfusion-kinesis-stream.name
}

output "kke_kinesis_alarm_name" {
  value = aws_cloudwatch_metric_alarm.xfusion-kinesis-alarm.alarm_name
}