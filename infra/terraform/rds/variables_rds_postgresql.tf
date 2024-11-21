# defined at terraform runtime
variable "rds_db_name"  {}

variable "rds_username" {}

variable "rds_password" {}

variable "rds_name" {
  type = string 
}

variable "rds_engine" {
  type = string 
}

variable "rds_postgres_version" {
  type = string 
  default = "14"
}

variable "rds_instance_class" {
  type = string 
  default = "db.t3.micro" 
}

variable "rds_storage_size" {
  type = number
  default = 20
}

variable "rds_family" {
  type = string
}

variable "rds_major_engine_version"  {
  type = string
  default = "14"
}

variable "rds_publicly_accessible" {
  type = bool
  default = true
}

variable "rds_muti_az" {
  type = bool
  default = false 
}

variable "rds_port" {
  type = number
}

variable "rds_database_security_group_name" {
  type = string
}

variable "rds_manage_password" {
  type = bool
  default = false
}


variable "vpc_id" {
  type = string
}

variable "database_subnet_group_name" {
    type = string
}

