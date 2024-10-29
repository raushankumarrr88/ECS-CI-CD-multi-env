# ECS Task Definition for Staging
resource "aws_ecs_task_definition" "staging_task" {
  family                   = "staging-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"  # Adjust based on application requirements
  memory                   = "512"  # Adjust based on application requirements

  container_definitions = jsonencode([{
    name      = "staging-container"
    image     = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.ecr_repository_name}:latest"
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
  }])
}

# ECS Task Definition for Production
resource "aws_ecs_task_definition" "production_task" {
  family                   = "production-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"  # Adjust based on application requirements
  memory                   = "512"  # Adjust based on application requirements

  container_definitions = jsonencode([{
    name      = "production-container"
    image     = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.ecr_repository_name}:latest"
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
  }])
}
