output "master-creds" {
  description = "DB Admin User"
  value       = local.master-creds
}

output "clusterinfo" {
  description = "MongoDB Cluster Info"
  value       = mongodbatlas_advanced_cluster.cluster
}
