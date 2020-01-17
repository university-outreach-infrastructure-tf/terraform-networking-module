## Public Route
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = "${
   merge(
     module.networking_labels.tags,
     map(
       "Name",  format("%s-public-001", module.networking_labels.id),
       "Type", "Public",
       "Environment", var.stage
     )
   )}"
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
  count  = length(var.private_subnets)
  vpc_id = aws_vpc.vpc.id
  tags   = "${
     merge(
       module.networking_labels.tags,
       map(
         "Name",  format("%s-private-001", module.networking_labels.id),
         "Type", "private",
         "Environment", var.stage
       )
     )}"
}

resource "aws_route" "private" {
  count                  = length(var.private_subnets)
  route_table_id         = element(aws_route_table.public.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.main.*.id, count.index)
}

resource "aws_route_table_association" "public" {
  count          = length(var.private_subnets)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}
