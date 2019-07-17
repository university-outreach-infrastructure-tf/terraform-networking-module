## Public Route
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = "${
   merge(
     module.networking_labels.tags,
     map(
       "Name",  format("%s-public-001", module.networking_labels.id),
       "Type", "Public",
       "Environment", "${var.stage}"
     )
   )}"
}

resource "aws_route" "public" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main.id}"
  depends_on               = ["aws_route_table.public"]
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.public_subnets)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
  depends_on     = ["aws_subnet.public", "aws_route_table.public"]
}