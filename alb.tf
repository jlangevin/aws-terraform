resource "aws_lb" "ecs_bluegreen_lb" {
  name               = "ecs-bluegreen-lb"
  internal           = var.LB_IS_INTERNAL
  load_balancer_type = "application"
  
  security_groups    = [
    aws_security_group.ecs_bluegreen_lb_sg.id
  ]

  subnets            = [
    aws_subnet.public_lb_subnet_1,
    aws_subnet.public_lb_subnet_2
  ]

  enable_deletion_protection = false

  tags = {
    Name = "ecs-bluegreen-lb"
  }
}
