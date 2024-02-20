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

# # Create a internet gateway
# resource "aws_internet_gateway" "cr_igw" {
#   vpc_id = aws_vpc.coderunner_vpc.id
#   tags = {
#     Name = "${var.environment_name}_igw"
#   }
# }

# #  Create a subnet inside your VPC
# resource "aws_subnet" "cr_subnet" {
#   vpc_id = aws_vpc.coderunner_vpc.id
#   cidr_block = "10.0.1.0/24"
#   map_public_ip_on_launch = true # Enable auto-assign public IP
#   tags = {
#     Name = "${var.environment_name}_subnet"
#   }
# }

# # Create a route table for the VPC
# resource "aws_route_table" "cr_rt1" {
#   vpc_id = aws_vpc.coderunner_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.cr_igw.id
#   }

#   tags = {
#     Name = "cr_rt1"
#   }
# }

# # Associate the route table to the subtnet you created
# resource "aws_route_table_association" "cr_a" {
#   subnet_id = aws_subnet.cr_subnet.id
#   route_table_id = aws_route_table.cr_rt1.id
# }






# # Associate the elastic IP with your EC2 public IP address
# output "public_ip" {
#   value = aws_eip.coderunner_eip.public_ip
# }