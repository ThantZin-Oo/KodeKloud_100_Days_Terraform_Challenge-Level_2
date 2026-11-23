resource "aws_s3_bucket" "wordpress_bucket" {
  bucket = "xfusion-s3-93304712"
}

resource "aws_s3_bucket_acl" "wordpress_bucket_acl" {
  bucket = aws_s3_bucket.wordpress_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket" "xfusion-bucket" {
  bucket = var.KKE_BUCKET
}

resource "aws_s3_bucket_ownership_controls" "xfusion-bucket" {
  bucket = aws_s3_bucket.xfusion-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "xfusion-bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.xfusion-bucket]
  bucket     = aws_s3_bucket.xfusion-bucket.id
  acl        = "private"
}
resource "terraform_data" "sync_s3" {
  depends_on = [
    aws_s3_bucket.wordpress_bucket,
    aws_s3_bucket.xfusion-bucket,
    aws_s3_bucket_acl.xfusion-bucket_acl
  ]
  provisioner "local-exec" {
    command = "aws s3 sync s3://${aws_s3_bucket.wordpress_bucket.id} s3://${aws_s3_bucket.xfusion-bucket.id}"
  }
}