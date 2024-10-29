# Resource to create an ECR repository
resource "aws_ecr_repository" "my_repository" {
  name = var.ecr_repository_name  # Name of the ECR repository
}
