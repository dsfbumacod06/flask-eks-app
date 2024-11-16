resource "aws_security_group" "rds_postgres_sg" {
  name = "${local.resource_prefix}-${var.rds_database_security_group_name}"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port = var.rds_port 
    to_port = var.rds_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "rds" {
  identifier = "${local.resource_prefix}-${var.rds_name}"
  source  = "terraform-aws-modules/rds/aws"
  engine = var.rds_engine
  engine_version = var.rds_postgres_version
  instance_class = var.rds_instance_class
  allocated_storage = var.rds_storage_size
  db_name = var.rds_db_name
  username = var.rds_username
  password = var.rds_password 
  skip_final_snapshot = true  
  publicly_accessible = var.rds_publicly_accessible
  vpc_security_group_ids = [aws_security_group.rds_postgres_sg.id]
  multi_az = var.rds_muti_az
  db_subnet_group_name = module.vpc.database_subnet_group_name
  family  = var.rds_family
  major_engine_version = var.rds_major_engine_version 
  manage_master_user_password = var.rds_manage_password

  depends_on = [
    aws_security_group.rds_postgres_sg,
    module.vpc
  ]
}