# ECS Service for Production
resource "aws_ecs_service" "production_service" {
  name            = "production-service"
  cluster         = aws_ecs_cluster.production_cluster.id
  task_definition = aws_ecs_task_definition.production_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.production_subnet.id]
    security_groups  = [aws_security_group.production_sg.id]
    assign_public_ip = true
  }
}

# ECS Service for Staging
resource "aws_ecs_service" "staging_service" {
  name            = "staging-service"
  cluster         = aws_ecs_cluster.staging_cluster.id
  task_definition = aws_ecs_task_definition.staging_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.staging_subnet.id]
    security_groups  = [aws_security_group.staging_sg.id]
    assign_public_ip = true
  }
}