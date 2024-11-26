# EKS CLUSTER
variable "iam_cluster_role_name" {
  type = string
  default = "master-role"
}


variable "iam_ng_role_name" {
  type = string
  default = "ng-role"
}

variable "aws_managed_roles" {
  type = list(string)
  default = [ "" ]
}



