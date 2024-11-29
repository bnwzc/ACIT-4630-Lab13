provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_ip
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_subnet" "subnets" {
  count        = 2
  vpc_id       = aws_vpc.main.id
  cidr_block   = var.subnet_ips[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true

}

resource "aws_route_table_association" "subnets" {
  count          = 2
  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.main.id

}

resource "aws_security_group" "main" {
  name        = "main"
  description = "Allow ssh access"
  vpc_id      = aws_vpc.main.id
}

resource "aws_vpc_security_group_egress_rule" "main" {
  security_group_id = aws_security_group.main.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  tags = {
    Name = "main"
  }
}

resource "aws_vpc_security_group_ingress_rule" "outside" {
  security_group_id = aws_security_group.main.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"
  tags = {
    Name = "main"
  }
}

resource "aws_vpc_security_group_ingress_rule" "inside" {
  security_group_id = aws_security_group.main.id
  ip_protocol       = "-1"
  cidr_ipv4         = aws_vpc.main.cidr_block
  tags = {
    Name = "main"
  }
}