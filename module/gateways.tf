resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.vpc.id
  tags   = module.networking_labels.tags
}

resource "aws_nat_gateway" "main" {
  count         = length(var.private_subnets)
  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  tags          = merge( module.networking_labels.tags, { "Name"=  format("%s-nat-gw-00%s", module.networking_labels.id, count.index)})
}

resource "aws_eip" "nat" {
  count = length(var.private_subnets)
  vpc   = true
  tags  = merge( module.networking_labels.tags, { "Name"=  format("%s-nat-gw-eip-00%s", module.networking_labels.id, count.index)})
}
