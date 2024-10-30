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
  load_balancer {
    target_group_arn = aws_lb_target_group.production_tg.arn
    container_name   = "production-container"  # Replace with the container name
    container_port   = 80                      # Replace with the container port
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
  load_balancer {
    target_group_arn = aws_lb_target_group.staging_tg.arn
    container_name   = "staging-container"  # Replace with the container name
    container_port   = 80                   # Replace with the container port
  }
}