#natgateway
resource "aws_eip" "nat" {
vpc=true  
}

resource "aws_nat_gateway" "nat-gw" {
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.app-vpc-public.id
    depends_on= [aws_internet_gateway.app-vpc-gw] 
}

resource "aws_route_table" "main-private" {
  vpc_id = aws_vpc.app-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "main-private-1"
  }
}

#route_association_private
resource "aws_route_table_association" "main-private-1-a" {
  subnet_id      = aws_subnet.app-vpc-private.id
  route_table_id = aws_route_table.main-private.id
}
