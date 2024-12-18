
module "vpc" {
  source = "./vpc"
  vpc_name = "${local.resource_prefix}-tf-vpc"
  vpc_cidr_block = "10.2.0.0/16"
  vpc_public_subnets = [ "10.2.200.0/24", "10.2.201.0/24" ]
  vpc_database_subnets = [ "10.2.220.0/24", "10.2.221.0/24" ]
  vpc_database_subnet_group_name="${local.resource_prefix}-db_subnet"
  vpc_create_database_subnet_group = true
  vpc_create_database_subnet_route_table = true   
  vpc_enable_nat_gateway = true  
  vpc_single_nat_gateway = true
}

module "eks" {
  source = "./eks"

  # EKS
  cluster_name = "${local.resource_prefix}-eks-cluster"
  cluster_service_ipv4_cidr = "172.20.0.0/16"
  cluster_version = "1.30"
  cluster_endpoint_private_access = false
  cluster_endpoint_public_access = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"] // for dev only
  cluster_role_arn = module.iam_cluster_role.role_arn
  vpc_public_subnets = module.vpc.vpc_public_subnets

  depends_on = [module.iam_cluster_role] 
}

module "iam_cluster_role" {
  source = "./iam"
  iam_role_name = "${local.resource_prefix}-eks-cluster-role"
  aws_managed_roles = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy", 
    "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  ]
  aws_service = "eks.amazonaws.com"
}


module "iam_nodegroup_role" {
  source = "./iam"
  iam_role_name = "${local.resource_prefix}-eks-ng-role"
  aws_managed_roles = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly", 
  ]
  aws_service = "ec2.amazonaws.com"
}

module "postgres_rds" {
  source = "./rds"

  rds_db_name = var.rds_db_name
  rds_username = var.rds_username
  rds_password = var.rds_password
  rds_name = "${local.resource_prefix}-tf-rds"
  rds_engine = "postgres"
  rds_postgres_version = "14"
  rds_instance_class  = "db.t3.micro" 
  rds_storage_size = 20
  rds_publicly_accessible = true
  rds_port = var.rds_port
  rds_family = "postgres14"
  rds_major_engine_version = "14"
  rds_muti_az = false
  rds_manage_password = false
  vpc_id = module.vpc.vpc_id
  database_subnet_group_name = module.vpc.db_subnet_name
  vpc_security_group_ids = [module.db_security_group.sg_id]

  depends_on = [ module.vpc, module.db_security_group ]
}

module "db_security_group" {
  source = "./security-groups"
  security_group_name = "${local.resource_prefix}-db-sg-extracted"
  vpc_id = module.vpc.vpc_id
  ingress_from_port = var.rds_port
  ingress_to_port = var.rds_port
}

module "node_group" {
  source = "./node-groups"
  cluster_name = module.eks.cluster_name
  vpc_public_subnets = module.vpc.vpc_public_subnets
  node_group_role_arn = module.iam_nodegroup_role.role_arn
  node_group_name ="${local.resource_prefix}-eks-ng-public"
  node_group_ami_type ="AL2_x86_64" 
  node_group_capacity_type = "ON_DEMAND"
  node_group_disk_size = 20
  node_group_instance_types = ["t3.medium"]
  node_group_scaling_min = 2
  node_group_scaling_max = 3
  node_group_scaling_desired = 2
  node_group_update_percent = 50

  depends_on = [ module.eks, module.iam_nodegroup_role ]
}
