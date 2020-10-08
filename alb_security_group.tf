resource "aws_security_group" "ecs_bluegreen_lb_sg" {
  vpc_id = aws_vpc.ecs_bluegreen.id

  # Allow traffic from any target on the internet on port 80
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Allow traffic out to any target on the internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs_bluegreen_lb_sg"
  }
}