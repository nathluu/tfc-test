# resource "azurerm_cosmosdb_postgresql_cluster" "cosmosdbpsql" {
#   name                            = local.cosmospsql.usr-name
#   resource_group_name             = local.cosmospsql.usr-resource-grp
#   location                        = local.cosmospsql.usr-location
#   administrator_login_password    = "H@Sh1CoR3!"
#   coordinator_storage_quota_in_mb = 131072
#   coordinator_vcore_count         = 2
#   node_count                      = 2
#   node_storage_quota_in_mb        = 131072
#   node_vcores                     = 2
# }

# resource "azurerm_cosmosdb_postgresql_node_configuration" "cosmosdbpsqlcfg" {
#   name       = "array_nulls"
#   cluster_id = azurerm_cosmosdb_postgresql_cluster.cosmosdbpsql.id
#   value      = "on"
# }