provider "aws" {
  region = var.aws_region
}

resource "aws_ecr_repository" "my_repository" {
  name = var.ecr_repository_name
}
