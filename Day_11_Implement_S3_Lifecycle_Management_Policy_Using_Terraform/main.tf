resource "aws_s3_bucket" "xfusion-bucket" {
  bucket = "xfusion-lifecycle-668529588"
}

resource "aws_s3_bucket_versioning" "xfusion-versioning" {
  bucket = aws_s3_bucket.xfusion-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket-config" {
  bucket = aws_s3_bucket.xfusion-bucket.bucket
  rule {
    id     = "xfusion-lifecycle-rule"
    status = "Enabled"
    filter {
      prefix = ""
    }
    expiration {
      days = 365
    }

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }
}