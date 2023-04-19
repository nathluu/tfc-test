local {
    atlas-project-name      = ""
    cloud-provider-name     = "AZURE"
    atlas-legacy-backups    = false
    atlas-autoscaling-disk  = true
    cloud-backup            = true
    point-in-time-backups   = true
}

resource "random_id" "cluster-name-suffix" {
    byte_length = 4
}

resource "mongodbatlas_cluster" "cluster" {
  name                          = var.atlas-cluster-name
  project_id                    = var.atlas-project-id
  provider_instance_size_name   = var.atlas-cluster-tier
  provider_name                 = local.cloud-provider-name
  auto_scaling_disk_gb_enabled  = local.atlas-autoscaling-disk
  backup_enabled                = local.atlas-legacy-backups
  provider_backup_enabled       = local.cloud-backup
  cluster_type                  = var.atlas-geo-sharded-cluster == false? var.atlas-cluster-type : "GEOSHARDED"
  provider_disk_type_name       = var.atlas-azure-disk-type-name
  mongo_db_major_version        = var.mongo-db-version
  pit_enabled                   = local.point-in-time-backups

  bi_connector_config {
    enabled = var.enable-bi-connector
    read_preference = var.read-preference

  }
  
  advanced_configuration {
    minimum_enabled_tls_protocol = "TLS1_2"
  }

  dynamic "labels" {
    for_each = var.tags
    content {
        key = labels.key
        value = labels.value
    }
  }

  auto_scaling_compute_enabled                    = var.atlas-db-compute-auto-scaling-enabled
  auto_scaling_compute_scale_down_enabled         = var.atlas-db-compute-auto-scaling-enabled
  provider_auto_scaling_compute_min_instance_size = var.atlas-db-compute-auto-scaling-enabled? var.atlas-db-compute-auto-scaling-size-minimum : ""
  provider_auto_scaling_compute_max_instance_size = var.atlas-db-compute-auto-scaling-enabled? var.atlas-db-compute-auto-scaling-size-maximum : ""
  
  lifecycle {

  }

  replication_specs {
    num_shards = var.atlas-cluster-type == "REPLICASET"? 1 : var.atlas-shard-number
    dynamic "regions_config" {
        for_each = var.replication-specs
        content {
            region_name     = regions_cofig.value.region
            electable_nodes = regions_cofig.value.electable-nodes
            analytics_nodes = regions_cofig.value.analytics-nodes
            read_only_nodes = regions_cofig.value.read-only-nodes
            priority        = regions_cofig.value.priority
        }
    }
  }
}