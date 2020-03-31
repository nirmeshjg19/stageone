resource "aws_vpc" "app-vpc" {
cidr_block           = "${var.vpc_cidr}"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  
  tags = {
    Name = "APP-VPC"
  } 
}

resource "aws_subnet" "app-vpc-public" {
  vpc_id                  = aws_vpc.app-vpc.id
  cidr_block              = "${public_subnet_cidr}"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "app-vpc-publicsubnet"
  }
}

resource "aws_subnet" "app-vpc-private" {
  vpc_id                  = aws_vpc.app-vpc.id
  cidr_block              = "${private_subnet_cidr}"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "app-vpc-privatesubnet"
  }
}

resource "aws_internet_gateway" "app-vpc-gw" {
  vpc_id = aws_vpc.app-vpc.id

  tags = {
    Name = "app-vpc-gw"
  }
}

resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.app-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app-vpc-gw.id
  }
  tags = {
    Name = "main-public-1"
  }
}

resource "aws_route_table_association" "main-public-1-a" {
  subnet_id      = aws_subnet.app-vpc-public.id
  route_table_id = aws_route_table.main-public.id
}

