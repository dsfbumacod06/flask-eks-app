# Create AWS EKS Node Group - Public
resource "aws_eks_node_group" "eks_ng_public" {
  cluster_name    = aws_eks_cluster.eks_cluster.name

  node_group_name = "${var.node_group_name}"
  node_role_arn   = aws_iam_role.eks_nodegroup_role.arn
  subnet_ids      = module.vpc.public_subnets 
  
  ami_type = var.node_group_ami_type
  capacity_type = var.node_group_capacity_type
  disk_size = var.node_group_disk_size
  instance_types = var.node_group_instance_types

  scaling_config {
    desired_size = var.node_group_scaling_desired
    min_size     = var.node_group_scaling_min
    max_size     = var.node_group_scaling_max
  }

  update_config { 
    max_unavailable_percentage = var.node_group_update_percent    
  }


}