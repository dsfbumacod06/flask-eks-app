# VPC Variables
variable "vpc_name" {
  type = string 
  default = "tf-vpc"
}

variable "vpc_cidr_block" {
  type = string 
  default = "10.1.0.0/16"
}

variable "vpc_public_subnets" {
  type = list(string)
  default = ["10.1.101.0/24", "10.1.102.0/24"]
}

variable "vpc_create_database_subnet_group" {
  type = bool
  default = true 
}

variable "vpc_database_subnet_group_name" {
  type = string
  default = "db_subnet"
}
variable "vpc_database_subnets" {
  type = list(string)
  default = ["10.1.151.0/24", "10.1.152.0/24"]
}

variable "vpc_create_database_subnet_route_table" {
  type = bool
  default = true   
}

variable "vpc_enable_nat_gateway" {
  type = bool
  default = true  
}

variable "vpc_single_nat_gateway" {
  type = bool
  default = true
}





