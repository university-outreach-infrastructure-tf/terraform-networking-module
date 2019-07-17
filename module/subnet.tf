resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${element(var.private_subnets, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  count             = "${length(var.private_subnets)}"
  tags              = "${(map("Name", format("%s-private-%03d", var.name, count.index+1), "Environment", "${var.stage}"))}"
}

resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${element(var.public_subnets, count.index)}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  count                   = "${length(var.public_subnets)}"
  map_public_ip_on_launch = true
  tags                    = "${merge(var.public_subnet_tags, map("Name", format("%s-public-%03d", var.name, count.index+1), "Environment", "${var.stage}"))}"
}

resource "aws_db_subnet_group" "default" {
  description = "Default database subnet group for ${aws_vpc.vpc.id}"
  subnet_ids  = ["${aws_subnet.private.*.id}"]
  tags        = "${(map("Name", format("%s-default-db-subnet-group", var.name), "Environment", "${var.stage}"))}"
}

