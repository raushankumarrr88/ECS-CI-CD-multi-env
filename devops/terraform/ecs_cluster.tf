# ECS Cluster for Staging Environment
resource "aws_ecs_cluster" "staging_cluster" {
  name = "staging-ecs-cluster"
  tags = {
    Environment = "staging"
  }
}

# ECS Cluster for Production Environment
resource "aws_ecs_cluster" "production_cluster" {
  name = "production-ecs-cluster"
  tags = {
    Environment = "production"
  }
}

# ECS Cluster for Dev Environment
resource "aws_ecs_cluster" "dev_cluster" {
  name = "dev-ecs-cluster"
  tags = {
    Environment = "dev"
  }
}

