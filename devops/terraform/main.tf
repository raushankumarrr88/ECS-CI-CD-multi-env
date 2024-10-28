# Specify the required Terraform version
terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket = "ecs-deployment-terraform-statefile"  # Replace with your S3 bucket name
    key    = "terraform/state"        # Path to the state file in the bucket
    region = var.aws_region           # Use the variable for region
  }
}

# Provider configuration
provider "aws" {
  region = var.aws_region  # AWS region from variable
}

# Resource to create an ECR repository
resource "aws_ecr_repository" "my_repository" {
  name = var.ecr_repository_name  # Name of the ECR repository
}
