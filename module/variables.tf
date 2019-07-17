variable "cidr" {
  description = "The CIDR block for the VPC."
}

variable "aws_region" {
  description = "Region for AWS account"
  default = "us-east-1"
}

variable "vpc_name" {
  description = "VPC name"
}

variable "public_subnets" {
  description = "List of public subnets"
  type        = "list"
}

variable "private_subnets" {
  description = "List of private subnets"
  type        = list
}

variable "use_nat_instances" {
  description = "If true, use EC2 NAT instances instead of the AWS NAT gateway service."
  default     = false
}

variable "nat_instance_type" {
  description = "Only if use_nat_instances is true, which EC2 instance type to use for the NAT instances."
  default     = "t2.nano"
}

variable "use_eip_with_nat_instances" {
  description = "Only if use_nat_instances is true, whether to assign Elastic IPs to the NAT instances. IF this is set to false, NAT instances use dynamically assigned IPs."
  default     = false
}

variable "tags" {
  type        = map
  description = "A map of tags to add to all resources"
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  default     = "Infra"
}

variable "public_subnet_tags" {
  type        = "map"
  description = "Additional tags for the public subnets"
}

variable "private_subnet_tags" {
  type        = "map"
  description = "Additional tags for the private subnets"
}

variable "public_route_table_tags" {
  type        = "map"
  description = "Additional tags for the public route tables"
}

variable "private_route_table_tags" {
  type        = "map"
  description = "Additional tags for the private route tables"
  default     = { Name = "" }
}

variable "name" {
  type        = string
  description = "Name tag, e.g stack"
  default     = ""
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list
  default     = [""]
}

variable "namespace" {
  type        = string
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
  default     = ""
}

variable "stage" {
  type        = string
  description = "Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'"
  default     = ""
}

variable "attributes" {
  type        = list
  description = "Additional attributes (e.g. 1)"
  default     = [""]
}

variable "delimiter" {
  type        = string
  description = "Delimiter to be used between namespace, environment, stage, name and attributes"
  default     = ""
}