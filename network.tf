resource "aws_internet_gateway" "ecs_bluegreen_igw" {
  vpc_id = aws_vpc.ecs_bluegreen.id
  
  tags = {
    Name = "ecs_bluegreen_igw"
  }
}

resource "aws_route_table" "ecs_bluegreen_public_crt" {
  vpc_id = aws_vpc.ecs_bluegreen.id

  route {
    cidr_block = "0.0.0.0/0" // Allows IGW to reach internet
    gateway_id = aws_internet_gateway.ecs_bluegreen_igw.id
  }

  tags = {
    Name = "ecs_bluegreen_public_crt"
  }
}

resource "aws_route_table_association" "ecs_bluegreen_public_crt_lb_subnet_1"{
  subnet_id      = aws_subnet.public_lb_subnet_1.id
  route_table_id = aws_route_table.ecs_bluegreen_public_crt.id
}