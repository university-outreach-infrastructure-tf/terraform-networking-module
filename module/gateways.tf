resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.vpc.id
  tags   = module.networking_labels.tags
}

resource "aws_nat_gateway" "main" {
  count         = length(var.private_subnets)
  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  tags          = "${
                      merge(
                        module.networking_labels.tags,
                        map(
                          "Name",  format("%s-nat-gw-001", module.networking_labels.id)
                      )
                   )}"
}

resource "aws_eip" "nat" {
  count = length(var.private_subnets)
  vpc   = true
  tags  = "${
              merge(
                module.networking_labels.tags,
                map(
                  "Name",  format("%s-nat-gw-eip-001", module.networking_labels.id)
                )
              )}"
}
