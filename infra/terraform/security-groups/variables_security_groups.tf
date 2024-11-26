variable "ingress_to_port" {
  type = number
}

variable "ingress_from_port" {
  type = number
}

variable "security_group_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "rds_ingress_cidr" {
  type = list(string)
  default = ["0.0.0.0/0"]
}

variable "rds_ingress_protocol" {
  type = string
  default = "tcp"
}