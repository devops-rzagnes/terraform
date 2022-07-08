#Define External IP 
resource "aws_eip" "terraform-nat" {
  vpc = true
}

resource "aws_nat_gateway" "terraform-nat-gw" {
  allocation_id = aws_eip.terraform-nat.id
  subnet_id     = aws_subnet.terraform-vpc-test-public-1.id
  depends_on    = [aws_internet_gateway.terraform-vpc2-gw]
}

resource "aws_route_table" "terraform-private" {
  vpc_id = aws_vpc.terraform-vpc-test.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.terraform-nat-gw.id
  }

  tags = {
    Name = "terraform-private"
  }
}

# route associations private
resource "aws_route_table_association" "level-private-1-a" {
  subnet_id      = aws_subnet.terraform-vpc-test-private-1.id
  route_table_id = aws_route_table.terraform-private.id
}

resource "aws_route_table_association" "level-private-1-b" {
  subnet_id      = aws_subnet.terraform-vpc-test-private-2.id
  route_table_id = aws_route_table.terraform-private.id
}

resource "aws_route_table_association" "level-private-1-c" {
  subnet_id      = aws_subnet.terraform-vpc-test-private-3.id
  route_table_id = aws_route_table.terraform-private.id
}
