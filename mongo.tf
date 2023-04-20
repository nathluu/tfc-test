# resource "random_id" "cluster-name-suffix" {
#     byte_length = 4
# }

resource "mongodbatlas_cluster" "cluster" {
  name                          = local.atlas.atlas-cluster-name
  project_id                    = local.atlas.atlas-project-id
  provider_instance_size_name   = local.atlas.atlas-cluster-tier
  provider_name                 = local.atlas.cloud-provider-name
  auto_scaling_disk_gb_enabled  = local.atlas.atlas-autoscaling-disk
#   backup_enabled                = local.atlas.atlas-legacy-backups
  cloud_backup                  = local.atlas.cloud-backup
  cluster_type                  = local.atlas.atlas-geo-sharded-cluster == false ? local.atlas.atlas-cluster-type : "GEOSHARDED"
  provider_disk_type_name       = local.atlas.atlas-azure-disk-type-name
  mongo_db_major_version        = local.atlas.mongo-db-version
  pit_enabled                   = local.atlas.point-in-time-backups

#   bi_connector_config {
#     enabled         = var.enable-bi-connector
#     read_preference = var.read-preference
#   }
  
  advanced_configuration {
    minimum_enabled_tls_protocol = "TLS1_2"
  }

#   dynamic "labels" {
#     for_each = local.atlas.tags
#     content {
#         key   = labels.key
#         value = labels.value
#     }
#   }

  auto_scaling_compute_enabled                    = local.atlas.atlas-db-compute-auto-scaling-enabled
  auto_scaling_compute_scale_down_enabled         = local.atlas.atlas-db-compute-auto-scaling-enabled
  provider_auto_scaling_compute_min_instance_size = local.atlas.atlas-db-compute-auto-scaling-enabled ? local.atlas.atlas-db-compute-auto-scaling-size-minimum : ""
  provider_auto_scaling_compute_max_instance_size = local.atlas.atlas-db-compute-auto-scaling-enabled ? local.atlas.atlas-db-compute-auto-scaling-size-maximum : ""
  
  lifecycle {}

#   replication_specs {
#     num_shards = local.atlas.atlas-cluster-type == "REPLICASET"? 1 : local.atlas.atlas-shard-number
#     dynamic "regions_config" {
#         for_each = var.replication-specs
#         content {
#             region_name     = regions_cofig.value.region
#             electable_nodes = regions_cofig.value.electable-nodes
#             analytics_nodes = regions_cofig.value.analytics-nodes
#             read_only_nodes = regions_cofig.value.read-only-nodes
#             priority        = regions_cofig.value.priority
#         }
#     }
#   }
}