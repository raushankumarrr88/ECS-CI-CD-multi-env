# Provider configuration
provider "aws" {
  region = var.aws_region  # AWS region from variable
}

# Specify the required Terraform version
terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket = "ecs-deployment-terraform-statefile"  # Replace with your S3 bucket name
    key    = "terraform/state"        # Path to the state file in the bucket
    region = us-east-1        # Use the variable for region
  }
}