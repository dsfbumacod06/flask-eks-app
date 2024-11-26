# EKS CLUSTER
variable "iam_role_name" {
  type = string
  default = "master-role"
}


variable "aws_managed_roles" {
  type = list(string)
  default = [ "" ]
}

variable "aws_service" {
  description = "AWS service to assume this role"  
}



