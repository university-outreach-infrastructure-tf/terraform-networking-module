// The VPC ID
output "vpc_id" {
  value = aws_vpc.vpc.id
}

// The VPC CIDR
output "vpc_cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

// A comma-separated list of public subnet IDs
output "public_subnets" {
  value = [aws_subnet.public.*.id]
}

// A comma-separated list of private subnet IDs
output "private_subnets" {
  value = [aws_subnet.private.*.id]
}

// The list of availability zones of the VPC.
output "availability_zones" {
  value = [aws_subnet.public.*.availability_zone]
}

// Default Subnet ID for Database
output "default_db_subnet_group" {
  value = aws_db_subnet_group.default.id
}

// The public route table ID.
output "public_rtb_id" {
  value = aws_route_table.public.*.id
}