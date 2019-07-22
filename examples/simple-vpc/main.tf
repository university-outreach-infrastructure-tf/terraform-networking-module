provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "networking_setup" {
  source             = "../../module/"
  namespace          = "ex"
  stage              = "test"
  attributes         = ["xyz"]
  name               = "app"
  delimiter          = "-"
  cidr               = "10.0.0.0/16"
  private_subnets    = ["10.0.32.0/20", "10.0.96.0/20"]
  public_subnets     = ["10.0.0.0/19", "10.0.64.0/19"]
  availability_zones = ["us-east-1a", "us-east-1b"]
}