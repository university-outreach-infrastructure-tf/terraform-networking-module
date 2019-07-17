variable "cidr" {
  description = "The CIDR block for the VPC."
  default     = ""
}

variable "public_subnets" {
  description = "List of public subnets"
  type        = "list"
  default     = []
}

variable "private_subnets" {
  description = "List of private subnets"
  type        = list
  default     = []
}

variable "name" {
  type        = string
  description = "Name tag, e.g stack"
  default     = ""
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list
  default     = []
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
  default     = []
}

variable "delimiter" {
  type        = string
  description = "Delimiter to be used between namespace, environment, stage, name and attributes"
  default     = ""
}