terraform {
  required_version = ">= 1.1.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.99"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "random_integer" "ri" {
  min = 1000
  max = 9999
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.az_resource_name_prefix}-rg"
  location = var.location
}

locals {
  aks_subnet_name = "aks-subnet"
  random_int      = random_integer.ri.result
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  vnet_name           = "${var.az_resource_name_prefix}-vnet"
  address_space       = [var.vnet_cidr]
  subnets = [
    {
      name : local.aks_subnet_name
      address_prefixes : [var.aks_subnet_cidr]
    }
  ]
}

module container {
  source               = "./modules/container"
  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location

  aks_cluster_name     = "${var.az_resource_name_prefix}-aks"
  aks_version_prefix   = var.aks_version_prefix
  nodepool_nodes_count = var.nodepool_nodes_count
  nodepool_vm_size     = var.nodepool_vm_size
  nodepool_subnet_id   = module.network.subnet_ids[local.aks_subnet_name]
  aks_subnet_cidr      = var.aks_subnet_cidr
  aks_service_cidr     = var.aks_service_cidr
  dns_service_ip       = var.dns_service_ip
  docker_bridge_cidr   = var.docker_bridge_cidr

  acr_name             = join("", regexall("[0-9a-z]*", lower("${var.az_resource_name_prefix}-${local.random_int}-acr")))
  acr_sku              = var.acr_sku
}

module "storage" {
  source              = "./modules/storage"
  name                = join("", regexall("[0-9a-z]*", lower("${var.az_resource_name_prefix}-${local.random_int}-stg")))
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tier                = var.storage_account_tier
  replication_type    = var.storage_account_replication_type
}

module "messaging" {
  source              = "./modules/messaging"
  servicebus_ns_name  = "${var.az_resource_name_prefix}-${local.random_int}-sbn"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  servicebus_ns_sku   = var.servicebus_ns_sku
  queues              = [ "incoming" ]

  storage_account_id  = module.storage.storage_account_id
}

module "cosmos" {
  source                 = "./modules/cosmos"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  cosmosdb_account_name  = "${var.az_resource_name_prefix}-${local.random_int}-cosmos"
  cosmosdb_nosql_db_name = "mixed_reality"
}