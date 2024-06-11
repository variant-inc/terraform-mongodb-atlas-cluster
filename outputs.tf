output "clusterinfo" {
  description = "MongoDB Cluster Info"
  value       = mongodbatlas_advanced_cluster.cluster
}

output "ca_certificate" {
  description = "ca certificates for user"
  value = tls_self_signed_cert.cert.cert_pem
  sensitive = true
}
