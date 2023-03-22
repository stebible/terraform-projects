resource "aws_s3_bucket" "bucket-dev" {
  bucket = "bootcamp30-${random_integer.bucket_name.result}-${var.name}"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "bucket-dev-acl" {
  bucket = aws_s3_bucket.bucket-dev.id
  acl    = var.acl
}

resource "aws_s3_bucket_versioning" "bucket-dev-ver" {
  bucket = aws_s3_bucket.bucket-dev.id
  versioning_configuration {
    status = var.versioning
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.bucket-dev.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}


resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "random_integer" "bucket_name" {
  min = 1
  max = 100
  keepers = {
    # Generate a new integer each time we switch to a new listener ARN
    bucket_name = var.name
  }
}

