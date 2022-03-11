data "azurerm_kubernetes_service_versions" "current" {
  location       = var.location
  version_prefix = var.aks_version_prefix
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                    = var.aks_cluster_name
  location                = var.location
  kubernetes_version      = data.azurerm_kubernetes_service_versions.current.latest_version
  resource_group_name     = var.resource_group_name
  dns_prefix              = var.aks_cluster_name

  default_node_pool {
    name           = "default"
    node_count     = var.nodepool_nodes_count
    vm_size        = var.nodepool_vm_size
    vnet_subnet_id = var.nodepool_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    docker_bridge_cidr = var.docker_bridge_cidr
    dns_service_ip     = var.dns_service_ip
    network_plugin     = "azure"
    service_cidr       = var.aks_service_cidr
  }
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
}

resource "azurerm_role_assignment" "netcontributor" {
  role_definition_name = "Network Contributor"
  scope                = var.nodepool_subnet_id
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}

resource "azurerm_role_assignment" "acrpull" {
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}
