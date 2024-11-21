# EKS CLUSTER
variable "cluster_name" {
  type = string
  default = "eks-0"
}

variable "cluster_service_ipv4_cidr" {
  type = string
  default = null
}

variable "cluster_version" {
  type = string
  default = null
}
variable "cluster_endpoint_private_access" {
  type = bool
  default = false
}

variable "cluster_endpoint_public_access" {
  type = bool
  default = true
}

variable "cluster_endpoint_public_access_cidrs" {
  type = list(string)
  default = ["0.0.0.0/0"]
}

# EKS Public Node Group 
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



