
data "mongodbatlas_project" "existing_project" {
  name = var.project
}

locals {
  tags = {
    "octopus-environment"   = var.octopus_tags["environment"]
    "octopus-project"       = var.octopus_tags["project"]
    "octopus-project_group" = var.octopus_tags["project_group"]
    "octopus-space"         = var.octopus_tags["space"]
    Name                    = "${var.name}"
  }
  cluster_type = "REPLICASET"
}

resource "mongodbatlas_advanced_cluster" "cluster" {
  project_id             = data.mongodbatlas_project.existing_project.id
  name                   = var.name
  cluster_type           = local.cluster_type
  pit_enabled            = var.enable_backup ? var.pit_enabled : false
  mongo_db_major_version = var.mongo_db_major_version

  advanced_configuration {
    minimum_enabled_tls_protocol       = "TLS1_2"
    transaction_lifetime_limit_seconds = 60
  }

  replication_specs {
    num_shards = var.num_shards

    region_configs {
      electable_specs {
        instance_size = var.instance_size.min
        node_count    = var.node_count
      }

      provider_name = var.provider_name
      region_name   = var.region
      priority      = 7

      auto_scaling {
        disk_gb_enabled            = var.disk_gb_enabled
        compute_enabled            = var.compute_enabled
        compute_scale_down_enabled = var.compute_scale_down_enabled
        compute_max_instance_size  = var.instance_size.max
        compute_min_instance_size  = var.instance_size.min
      }

      backing_provider_name = var.provider_name
      dynamic "read_only_specs" {
        for_each = var.read_only_nodes > 0 ? [1] : []
        content {
          node_count    = var.read_only_nodes
          instance_size = "M10"
        }
      }
    }
  }

  dynamic "tags" {
    for_each = local.tags

    content {
      key   = tags.key
      value = tags.value
    }
  }

  backup_enabled = var.enable_backup
}
