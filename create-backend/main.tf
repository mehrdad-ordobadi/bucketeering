provider "aws" {
  region = "<REGION>" # Replace with your region
}

resource "aws_s3_bucket" "this" {
  bucket = "<BUCKET_NAME>" # Replace with your bucket name
  region = "<REGION>"      # Replace with your bucket region

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    id      = "expire-objects"
    enabled = true

    expiration {
      days = 1
    }
  }
}

resource "aws_dynamodb_table" "this" {
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
