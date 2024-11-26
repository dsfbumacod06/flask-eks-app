resource "aws_security_group" "security-group" {
  name = var.security_group_name
  vpc_id = var.vpc_id

  ingress {
    from_port = var.ingress_from_port
    to_port = var.ingress_to_port
    protocol = var.rds_ingress_protocol
    cidr_blocks = var.rds_ingress_cidr
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }
}
