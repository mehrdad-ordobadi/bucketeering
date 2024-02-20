provider "aws" {
  region = "<REGION>" # Replace with your region
}

resource "aws_s3_bucket" "backend-config" {
  bucket = "<BUCKET_NAME>" # Replace with your bucket name

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "backend-config" {
  bucket = aws_s3_bucket.backend-config.id

  rule {
    id     = "expire-objects"
    status = "Enabled"

    expiration {
      days = 1
    }
  }
}

resource "aws_dynamodb_table" "backend-config" {
  name           = "<TABLE_NAME>" # Replace with your DynamoDB table name
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
