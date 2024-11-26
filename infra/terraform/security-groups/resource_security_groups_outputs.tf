output "rds_sg_id" {
  value = aws_security_group.rds_postgres_sg.id
}

output "rds_sg_name" {
  value = aws_security_group.rds_postgres_sg.name
}


