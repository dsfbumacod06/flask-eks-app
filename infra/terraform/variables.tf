variable "aws_region" {
  type = string
  default = "ap-southeast-1"  
}

variable "environment" {
  type = string
  default = "dev"
}

variable "owner" {
  type = string
  default = "OneByZero"
}

variable "project" {
  type = string
  default = "flask-eks-app"
}

# RDS DB Variables

variable "rds_db_name"  { type = string }

variable "rds_username" { type = string }

variable "rds_password" { type = string }

variable "rds_port" { type = number}

