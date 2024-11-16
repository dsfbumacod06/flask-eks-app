vpc_name = "tf-vpc"
vpc_cidr_block = "10.2.0.0/16"
vpc_public_subnets = [ "10.2.200.0/24", "10.2.201.0/24" ]
vpc_database_subnets = [ "10.2.220.0/24", "10.2.221.0/24" ]
vpc_create_database_subnet_group = true
vpc_create_database_subnet_route_table = true   
vpc_enable_nat_gateway = true  
vpc_single_nat_gateway = true
