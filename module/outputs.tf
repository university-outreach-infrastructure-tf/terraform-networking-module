// The VPC ID
output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

// The VPC CIDR
output "vpc_cidr_block" {
  value = "${aws_vpc.vpc.cidr_block}"
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

// The list of EIPs associated with the private subnets.
output "private_nat_ips" {
  value = ["${aws_eip.nat.*.public_ip}"]
}

// The private route table ID.
output "private_rtb_id" {
  value = "${join(",", aws_route_table.private.*.id)}"
}

// The public route table ID.
output "public_rtb_id" {
  value = "${aws_route_table.public.id}"
}