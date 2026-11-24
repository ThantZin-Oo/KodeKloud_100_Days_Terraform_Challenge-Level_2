resource "aws_s3_bucket" "devops-s3" {
  bucket = var.KKE_BUCKET_NAME
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Name = var.KKE_BUCKET_NAME
  }
}