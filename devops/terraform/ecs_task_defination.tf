# Create IAM Role for ECS Task Execution
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Effect = "Allow"
        Sid = ""
      },
    ]
  })
}

# Attach the AmazonECSTaskExecutionRolePolicy to the Rol
resource "aws_iam_policy_attachment" "ecs_task_execution_policy" {
  name       = "ecsTaskExecutionPolicyAttachment"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ECS Task Definition for Production
resource "aws_ecs_task_definition" "production_task" {
  family                   = "production-task"
  execution_role_arn      = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([  
    {
      name         = "production-container"
      image        = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.ecr_repository_name}:${var.image_tag}"  # Updated to use image_tag
      essential    = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        },
      ]
    },
  ])
  
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
}


# ECS Task Definition for Production
resource "aws_ecs_task_definition" "production_task-2" {
  family                   = "production-task"
  execution_role_arn      = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([  
    {
      name         = "production-container-2"
      image        = "nginx:latest"  # Updated to use image_tag
      essential    = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        },
      ]
    },
  ])
  
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
}




# ECS Task Definition for Staging
resource "aws_ecs_task_definition" "staging_task" {
  family                   = "staging-task"
  execution_role_arn      = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name         = "staging-container"
      image        = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.ecr_repository_name}:${var.image_tag}"  # Updated to use image_tag
      essential    = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        },
      ]
    },
  ])
  
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
}

# ECS Task Definition for Dev
resource "aws_ecs_task_definition" "dev_task" {
  family                   = "dev-task"
  execution_role_arn      = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name         = "dev-container"
      image        = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.ecr_repository_name}:${var.image_tag}"  # Updated to use image_tag
      essential    = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        },
      ]
    },
  ])
  
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
}
