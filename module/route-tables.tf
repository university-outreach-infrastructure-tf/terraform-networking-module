resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = "${merge(var.public_route_table_tags, map("Name", format("%s-public-001", var.name), "Environment", "${var.stage}"))}"
}

resource "aws_route" "public" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main.id}"
  depends_on               = ["aws_route_table.public"]
}

resource "aws_route_table" "private" {
  count  = "${length(var.private_subnets)}"
  vpc_id = "${aws_vpc.vpc.id}"
  tags   = "${merge(var.public_route_table_tags, map("Name", format("%s-private-%03d", var.name, count.index+1), "Environment", "${var.stage}"))}"
}

resource "aws_route" "private" {
  count                  = "${(1 - var.use_nat_instances) * length(compact(var.private_subnets))}"
  route_table_id         = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.main.*.id, count.index)}"
}

/**
 * Route associations
 */

resource "aws_route_table_association" "private" {
  count          = "${length(var.private_subnets)}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.public_subnets)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}
