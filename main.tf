provider "aws" {
  region = "us-east-1" # Replace with your preferred AWS region
}

variable "environment_name" {
  description = "The name of the environment"
  type        = string
}

# Create your VPC
resource "aws_vpc" "coderunner_vpc" {
  cidr_block = "10.0.0.0/16" # CIDR block for the VPC
  tags = {
    Name = "${var.environment_name}" # Name of your VPC
  }
}
terraform {
  backend "s3" {
    bucket         = "<BUCKET_NAME>" # Replace with your bucket name
    region         = "<REGION>"      # Replace with your bucket region
    dynamodb_table = "<TABLE_NAME>"  # Replace with your DynamoDB table name
    key            = "<STATE_PATH>"  # Replace with your state file name
    encrypt        = true
  }

}
