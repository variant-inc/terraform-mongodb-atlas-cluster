
########################################
### RANDOM PASSWORD FOR DATABASE USERS
######################### ##############
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%!+"
}

resource "mongodbatlas_database_user" "user" {
  username           = var.username
  password           = random_password.password.result
  project_id         = data.mongodbatlas_project.existing_project.id
  auth_database_name = "admin"
  roles {
    database_name = "admin"
    role_name     = "dbAdmin"
  }
}
