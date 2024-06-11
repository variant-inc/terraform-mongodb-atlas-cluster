resource "mongodbatlas_x509_authentication_database_user" "test" {
  project_id        = mongodbatlas_project.project.id
  customer_x509_cas = tls_self_signed_cert.cert.cert_pem
}


resource "tls_private_key" "ca_certificate" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "cert" {
  private_key_pem = tls_private_key.ca_certificate.private_key_pem

  subject {
    common_name  = "usxpress"
    organization = "US Xpress"
  }

  validity_period_hours = 10

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}
