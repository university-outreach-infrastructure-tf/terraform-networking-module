resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${element(var.private_subnets, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  count             = "${length(var.private_subnets)}"
  tags              = "${merge(var.tags, map("Name", format("%s-private-%03d", var.name, count.index+1), "Environment", "${var.environment}"))}"
}

resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${element(var.public_subnets, count.index)}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  count                   = "${length(var.public_subnets)}"
  map_public_ip_on_launch = true
  tags                    = "${merge(var.tags, var.public_subnet_tags, map("Name", format("%s-public-%03d", var.name, count.index+1), "Environment", "${var.environment}"))}"
}


resource "aws_db_subnet_group" "default" {
  description = "Default database subnet group for ${aws_vpc.vpc.id}"
  subnet_ids  = ["${aws_subnet.private.*.id}"]
  tags        = "${merge(var.tags, map("Name", format("%s-default-db-subnet-group", var.name)))}"
}

// A comma-separated list of subnet IDs.
output "public_subnets" {
  value = ["${aws_subnet.public.*.id}"]
}

// A list of subnet IDs.
output "private_subnets" {
  value = ["${aws_subnet.private.*.id}"]
}

// The list of availability zones of the VPC.
output "availability_zones" {
  value = ["${aws_subnet.public.*.availability_zone}"]
}

output "default_db_subnet_group" {
  value = "${aws_db_subnet_group.default.id}"
}