# networking-module

This module produces following resources:

1. VPC
2. Subnets in multiple AZs
3. Internet Gateway
4. Route Table, Route, Route Table Association

Usage:
```
module "networking_setup" {
    source             = "../../module/"
    namespace          = "${var.namespace}"
    stage              = "${var.stage}"
    attributes         = "${var.attributes}"
    name               = "${var.name}"
    delimiter          = "${var.delimiter}"
    cidr               = "${var.cidr_block}"
    private_subnets    = "${var.private_subnets}"
    public_subnets     = "${var.public_subnets}"
    availability_zones = "${var.availability_zones}"
}
```

## INPUT VALUES

| Input             | Description                                                                    | Type    | Default | Required |
| ------------------| -------------------------------------------------------------------------------| --------|---------|----------|
| namespace         | Namespace, which could be your organization name or abbreviation"              |`string` | ""      | yes      |
| stage             | Stage, e.g. 'prod', 'staging', 'dev'                                           |`string` | ""      | yes      |
| name              | Solution name, e.g. 'app' or 'jenkins'                                         |`string` | ""      | yes      |
| attributes        | Additional attributes                                                          |`list`   | <list>  | no       |           
| delimiter         | Delimiter to be used between namespace, environment, stage, name and attributes|`string` | "-"     | no       |
| public_subnets    | List of public subnets  (Value needs to be in CIDR Block range)                |`list`   | <list>  | yes      |
| private_subnets   | List of private subnets  (Value needs to be in CIDR Block range)               |`list`   | <list>  | yes      |
| availability_zones| List of availability zones                                                     |`list`   | <list>  | yes      |
| cidr              | CIDR block for the VPC                                                         |`string` | ""      | yes      |

## OUTPUT VALUE NAMES

| Name                    | Description                                 | 
| ------------------------| --------------------------------------------| 
| vpc_id                  | VPC ID                                      | 
| vpc_cidr_block          | VPC CIDR                                    | 
| public_subnets          | Comma-separated list of public subnet IDs.  | 
| private_subnets         | Comma-separated list of private subnet IDs. | 
| availability_zones      | List of availability zones of the VPC.      |
| default_db_subnet_group | Default Subnet ID for Database              | 
| public_rtb_id           | Public route table ID.                      | 