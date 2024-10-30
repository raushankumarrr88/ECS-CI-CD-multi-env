# Production Load Balancer
resource "aws_lb" "production_alb" {
  name               = "production-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.production_sg.id]
  subnets            = [aws_subnet.production_subnet_1.id, aws_subnet.production_subnet_2.id]  # Updated to include both subnets
}

# Staging Load Balancer
resource "aws_lb" "staging_alb" {
  name               = "staging-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.staging_sg.id]
  subnets            = [aws_subnet.staging_subnet_1.id, aws_subnet.staging_subnet_2.id]  # Updated to include both subnets
}

# Target Group for Production
resource "aws_lb_target_group" "production_tg" {
  name        = "production-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.production_vpc.id
  target_type = "ip"
}

# Target Group for Staging
resource "aws_lb_target_group" "staging_tg" {
  name        = "staging-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.staging_vpc.id
  target_type = "ip"
}

# Listener for Production ALB on port 80
resource "aws_lb_listener" "production_http_listener" {
  load_balancer_arn = aws_lb.production_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404 Not Found"
      status_code  = "404"
    }
  }
}

# Listener for Staging ALB on port 80
resource "aws_lb_listener" "staging_http_listener" {
  load_balancer_arn = aws_lb.staging_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404 Not Found"
      status_code  = "404"
    }
  }
}

# Listener Rule for Production
resource "aws_lb_listener_rule" "production_listener_rule" {
  listener_arn = aws_lb_listener.production_http_listener.arn
  priority     = 100  # Unique priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.production_tg.arn
  }

  condition {
    path_pattern {
      values = ["/production/*"]
    }
  }
}

# Listener Rule for Staging
resource "aws_lb_listener_rule" "staging_listener_rule" {
  listener_arn = aws_lb_listener.staging_http_listener.arn
  priority     = 200  # Unique priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.staging_tg.arn
  }

  condition {
    path_pattern {
      values = ["/staging/*"]
    }
  }
}
