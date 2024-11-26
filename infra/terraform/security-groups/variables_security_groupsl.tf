variable "rds_port" {
  type = number
}

variable "rds_database_security_group_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ingress_cidr" {
  type = list(string)
  default = ["0.0.0.0/0"]
}

variable "ingress_protocol" {
  type = string
  default = "tcp"
}