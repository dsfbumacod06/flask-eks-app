data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.15.0"

  # VPC Config
  name = var.vpc_name
  cidr = var.vpc_cidr_block
  azs = data.aws_availability_zones.available.names
  public_subnets = var.vpc_public_subnets
  create_private_nat_gateway_route = false
  map_public_ip_on_launch = true

  # RDS Subnets for RDS
  database_subnets = var.vpc_database_subnets
  database_subnet_group_name = var.vpc_database_subnet_group_name
  create_database_subnet_group = var.vpc_create_database_subnet_group
  create_database_subnet_route_table = var.vpc_create_database_subnet_route_table

  enable_nat_gateway = var.vpc_enable_nat_gateway 
  single_nat_gateway = var.vpc_single_nat_gateway

  enable_dns_hostnames = true
  enable_dns_support   = true
}