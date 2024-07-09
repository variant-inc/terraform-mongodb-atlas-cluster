output "clusterinfo" {
  description = "MongoDB Cluster Info"
  value       = mongodbatlas_advanced_cluster.cluster
}

output "ca_secret_arn" {
  description = "Mongodb CA Certificate Secret ARN"
  value       = aws_secretsmanager_secret.secret.arn
}
