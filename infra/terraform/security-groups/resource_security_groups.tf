resource "aws_security_group" "rds_postgres_sg" {
  name = var.rds_database_security_group_name
  vpc_id = var.vpc_id

  ingress {
    from_port = var.rds_port 
    to_port = var.rds_port
    protocol = var.ingress_protocol
    cidr_blocks = var.ingress_cidr
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }
}
