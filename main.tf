locals {
  cluster_type = "REPLICASET"
  cidr_block = concat(
    [data.aws_vpc.vpc.cidr_block],
    var.ip_access_list
  )
}

resource "mongodbatlas_project" "project" {
  name   = var.project
  org_id = var.org_id
}

resource "mongodbatlas_advanced_cluster" "cluster" {
  project_id             = mongodbatlas_project.project.id
  name                   = var.name
  cluster_type           = local.cluster_type
  pit_enabled            = var.enable_backup ? var.pit_enabled : false
  version_release_system = var.version_release_system
  mongo_db_major_version = var.version_release_system == "LTS" ? var.mongo_db_major_version : null

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
      region_name   = replace(upper(var.region), "-", "_")
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
    for_each = var.tags

    content {
      key   = tags.key
      value = tags.value
    }
  }

  backup_enabled = var.enable_backup
  depends_on     = [mongodbatlas_project.project]
}
