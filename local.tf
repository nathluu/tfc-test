locals {
    atlas = {
        atlas-project-id                            = "6440a1bca25f4142836bb575"
        cloud-provider-name                         = "AZURE"
        # atlas-legacy-backups                        = false
        atlas-autoscaling-disk                      = true
        cloud-backup                                = true
        point-in-time-backups                       = true
        atlas-cluster-tier                          = "M10"
        atlas-cluster-name                          = "lhtantest01"
        atlas-geo-sharded-cluster                   = false
        atlas-cluster-type                          = "REPLICASET"
        atlas-azure-disk-type-name                  = "P4"
        atlas-shard-number                          = 1
        mongo-db-version                            = "4.4"
        atlas-db-compute-auto-scaling-enabled       = true
        atlas-db-compute-auto-scaling-size-minimum  = "M10"
        atlas-db-compute-auto-scaling-size-maximum  = "M50"
        # tags                                        = {
        #     "database-owner" = "lhtan"
        # }
    }
}