resource "azurerm_storage_account" "stg" {
  name                      = var.name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_tier              = var.tier
  account_replication_type  = var.replication_type
  allow_blob_public_access  = true
  enable_https_traffic_only = true
}

resource "azurerm_storage_container" "stg_original_container" {
  name                  = "original-files"
  storage_account_name  = azurerm_storage_account.stg.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "stg_converted_container" {
  name                  = "converted-files"
  storage_account_name  = azurerm_storage_account.stg.name
  container_access_type = "private"
}