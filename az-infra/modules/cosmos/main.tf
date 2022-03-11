resource "azurerm_cosmosdb_account" "account" {
  name                = var.cosmosdb_account_name
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
}

resource "azurerm_cosmosdb_sql_database" "db" {
  name                = var.cosmosdb_nosql_db_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.account.name
  throughput          = 400
}