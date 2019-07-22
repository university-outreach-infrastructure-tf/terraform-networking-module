variable "cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = ""
}

variable "public_subnets" {
  description = "List of public subnets"
  type        = list
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
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
  type        = string
  default     = ""
}

variable "stage" {
  description = "Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'"
  type        = string
  default     = ""
}

variable "attributes" {
  description = "Additional attributes (e.g. 1)"
  type        = list
  default     = []
}

variable "delimiter" {
  description = "Delimiter to be used between namespace, environment, stage, name and attributes"
  type        = string
  default     = ""
}