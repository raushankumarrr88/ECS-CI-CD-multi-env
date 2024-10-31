variable "aws_region" {
  description = "The AWS region"
  type        = string
}

variable "ecr_repository_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "aws_account_id" {
  description = "This is the account is"
  type = string
}

# Variable for image tag
variable "image_tag" {
  description = "The Docker image tag for each environment"
  type        = string
}