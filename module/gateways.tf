resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = "${merge(var.tags, map("Name", format("%s", var.name), "Environment", "${var.environment}"))}"
}

resource "aws_nat_gateway" "main" {
  # Only create this if not using NAT instances.
  count         = "${(1 - var.use_nat_instances) * length(var.private_subnets)}"
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"
  depends_on    = ["aws_internet_gateway.main"]

  tags = "${merge(var.tags, map("Name", format("%s", var.name), "Environment", "${var.environment}"))}"
}

resource "aws_eip" "nat" {
  # Create these only if:
  # NAT instances are used and Elastic IPs are used with them,
  # or if the NAT gateway service is used (NAT instances are not used).
  count = "${signum((var.use_nat_instances * var.use_eip_with_nat_instances) + (var.use_nat_instances == 0 ? 1 : 0)) * length(var.private_subnets)}"

  vpc = true

  tags = "${merge(var.tags, map("Name", format("%s-%03d", var.name, element(var.availability_zones, count.index)), "Environment", "${var.environment}"))}"
}

// The list of EIPs associated with the private subnets.
output "private_nat_ips" {
  value = ["${aws_eip.nat.*.public_ip}"]
}