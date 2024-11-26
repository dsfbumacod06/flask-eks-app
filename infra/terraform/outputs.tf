output "rds_postsgres_db_endpoint" {
  value = module.postgres_rds.rds_postsgres_db_endpoint
}

output "cluster_name" {
  value = module.eks.cluster_name
}