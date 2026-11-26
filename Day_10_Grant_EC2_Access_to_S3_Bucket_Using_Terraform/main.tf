resource "aws_instance" "devops_ec2" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t3.micro"

  tags = {
    Name = "devops-ec2"
  }
}


resource "aws_s3_bucket" "devops-logs" {
  bucket = var.KKE_BUCKET_NAME
}

resource "aws_s3_bucket_public_access_block" "devops-logs" {
  bucket = aws_s3_bucket.devops-logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_iam_role" "devops-role" {
  name = var.KKE_ROLE_NAME

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "://amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "devops-access-policy" {
  name        = var.KKE_POLICY_NAME
  description = "Allow EC2 to read and write objects in the specific S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:ListBucket"]
        Resource = [aws_s3_bucket.devops-logs.arn]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = ["${aws_s3_bucket.devops-logs.arn}/*"]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_s3_policy" {
  role       = aws_iam_role.devops-role.name
  policy_arn = aws_iam_policy.devops-access-policy.arn
}