resource "aws_vpc" "ecs_bluegreen" {
  cidr_block            = "10.0.0.0/16"  # this makes 65,536 available in the VPC
  enable_dns_support    = "true" #gives you an internal domain name
  enable_dns_hostnames  = "true" #gives you an internal host name
  enable_classiclink    = "false"
  instance_tenancy      = "default"    
  
  tags = {
    Name = "ECS Bluegreen VPC"
  }
}

# We'll be using an ALB to route public traffic to ECS.  An ALB must have at least two subnets.
resource "aws_subnet" "public_lb_subnet_1" {
  vpc_id                  = aws_vpc.ecs_bluegreen.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true" // Make this a public subnet
  availability_zone       = "us-east-1a"
  
  tags = {
    Name = "Public ALB Subnet 1 (us-east-1a)"
  }
}

resource "aws_subnet" "public_lb_subnet_2" {
  vpc_id                  = aws_vpc.ecs_bluegreen.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true" // Make this a public subnet
  availability_zone       = "us-east-1b"
  
  tags = {
    Name = "Public ALB Subnet 2 (us-east-1b)"
  }
}

# We'll have our ECS tasks in two availability zones as well, so we'll create two private subnets
resource "aws_subnet" "private_container_subnet_1" {
  vpc_id                  = aws_vpc.ecs_bluegreen.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "false" // Make this a private subnet
  availability_zone       = "us-east-1a"
  
  tags = {
    Name = "Private Container Subnet 1 (us-east-1a)"
  }
}

resource "aws_subnet" "private_container_subnet_2" {
  vpc_id                  = aws_vpc.ecs_bluegreen.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false" // Make this a private subnet
  availability_zone       = "us-east-1b"
  
  tags = {
    Name = "Private Container Subnet 2 (us-east-1b)"
  }
}
