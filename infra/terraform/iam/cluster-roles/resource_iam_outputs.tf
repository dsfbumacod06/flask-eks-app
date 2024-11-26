output "cluster_role_name" {
  value = aws_iam_role.eks_cluster_role.name
}

output "cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "ng_role_name" {
  value = aws_iam_role.eks_nodegroup_role.name
}

output "ng_role_arn" {
  value = aws_iam_role.eks_nodegroup_role.arn
}

