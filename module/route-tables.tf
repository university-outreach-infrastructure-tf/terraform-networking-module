resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge( module.networking_labels.tags, { "Name"=  format("%s-public", module.networking_labels.id), "Type" = "Public", "Environment" = var.stage })
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
  depends_on             = [aws_route_table.public]
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
  depends_on     = [aws_subnet.public, aws_route_table.public]
}

resource "aws_route_table" "private"{
  vpc_id = aws_vpc.vpc.id
  tags   = merge( module.networking_labels.tags, { "Name"=  format("%s-private", module.networking_labels.id), "Type" = "Private", "Environment" = var.stage })
}

resource "aws_route" "private" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
  depends_on             = [aws_route_table.private]
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
  depends_on     = [aws_subnet.private, aws_route_table.private]
}
