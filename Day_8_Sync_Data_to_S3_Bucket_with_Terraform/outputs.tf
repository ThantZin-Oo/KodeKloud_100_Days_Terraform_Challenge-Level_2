output "new_kke_bucket_name" {
  value = aws_s3_bucket_ownership_controls.xfusion-bucket.bucket
}

output "new_kke_bucket_acl" {
  value = aws_s3_bucket_acl.xfusion-bucket_acl.acl
}