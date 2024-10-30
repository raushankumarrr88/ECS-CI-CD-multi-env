# Security Group for Production
resource "aws_security_group" "production_sg" {
  name        = "production-sg"
  description = "Allow HTTP traffic for production service"
  vpc_id      = aws_vpc.production_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to the world; adjust for tighter security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for Staging
resource "aws_security_group" "staging_sg" {
  name        = "staging-sg"
  description = "Allow HTTP traffic for staging service"
  vpc_id      = aws_vpc.staging_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

