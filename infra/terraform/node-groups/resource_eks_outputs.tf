# EKS PUBLIC NODE GROUP

output "node_group_public_id" {
  value = aws_eks_node_group.eks_ng_public.id
}

output "node_group_public_arn" {
  value = aws_eks_node_group.eks_ng_public.arn
}

output "node_group_public_status" {
  value = aws_eks_node_group.eks_ng_public.status 
}

output "node_group_public_version" {
  value = aws_eks_node_group.eks_ng_public.version
}

