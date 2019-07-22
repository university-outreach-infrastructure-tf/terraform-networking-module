// The VPC ID
output "vpc_id" {
  value = module.networking_setup.vpc_id
}

// The VPC CIDR
output "vpc_cidr_block" {
  value = module.networking_setup.vpc_cidr_block
}

// A comma-separated list of public subnet IDs
output "public_subnets" {
  value = [module.networking_setup.public_subnets]
}

// A comma-separated list of private subnet IDs
output "private_subnets" {
  value = [module.networking_setup.private_subnets]
}

// The list of availability zones of the VPC.
output "availability_zones" {
  value = [module.networking_setup.availability_zones]
}

// Default Subnet ID for Database
output "default_db_subnet_group" {
  value = module.networking_setup.default_db_subnet_group
}

// The public route table ID.
output "public_rtb_id" {
  value = module.networking_setup.public_rtb_id
}