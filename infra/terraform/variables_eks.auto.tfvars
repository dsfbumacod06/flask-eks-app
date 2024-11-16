# EKS CLUSTER
cluster_name = "eks-cluster"
cluster_service_ipv4_cidr = "172.20.0.0/16"
cluster_version = "1.30"
cluster_endpoint_private_access = false
cluster_endpoint_public_access = true
cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"] // all - for dev only

# NODE GROUP
node_group_name ="eks-ng-public"
node_group_ami_type ="AL2_x86_64" 
node_group_capacity_type = "ON_DEMAND"
node_group_disk_size = 20
node_group_instance_types = ["t3.medium"]
node_group_scaling_min = 2
node_group_scaling_max = 3
node_group_scaling_desired = 2
node_group_update_percent = 50


