# EKS CLUSTER
variable "cluster_name" {
  type = string
}

variable "vpc_public_subnets" {
  type = list(string)
}

variable "node_group_role_arn" {
  type = string
}

variable "node_group_name" {
  type = string
  default = "eks-ng-public"
}

variable "node_group_ami_type" {
  type = string
    default = "AL2_x86_64"
}

variable "node_group_capacity_type" {
  type = string
  default = "ON_DEMAND"
}

variable "node_group_disk_size" {
  type = number
  default = 20
}

variable "node_group_instance_types" {
  type = list(string)
  default = ["t2.small"]
}

variable "node_group_scaling_min" {
  type = number
  default = 1
}

variable "node_group_scaling_max" {
  type = number
  default = 1
}

variable "node_group_scaling_desired" {
  type = number
  default = 1
}

variable "node_group_update_percent" {
  type = number
  default = 25
}





