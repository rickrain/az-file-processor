// ****************************
// Common resource parameters
// ****************************

variable "az_resource_name_prefix" {
  description = "Prefix to use when naming azure resources"
  default     = "az-file-proc" // Example, resource group name would be az-file-proc-rg,
}

variable "location" {
  description = "The resource group location"
  default     = "East US"
}

// ****************************
// AKS parameters
// ****************************

variable "aks_version_prefix" {
  description = "AKS Kubernetes version prefix"
  default     = "1.22"
}

variable "nodepool_nodes_count" {
  description = "Default nodepool nodes count"
  default     = 2
}

variable "nodepool_vm_size" {
  description = "Default nodepool VM size"
  default     = "Standard_D2_v2"
}

variable "vnet_cidr" {
  description = "Virtual network cidr"
  default     = "10.0.0.0/8"
}

variable "aks_subnet_cidr" {
  description = "Subnet cidr for kubernetes nodes and pods"
  default     = "10.240.0.0/16"
}

variable "aks_service_cidr" {
  description = "Cidr for kubernetes services "
  default     = "10.2.0.0/24"
}

variable "dns_service_ip" {
  description = "CNI DNS service IP"
  default     = "10.2.0.10"
}

variable "docker_bridge_cidr" {
  description = "CNI Docker bridge cidr"
  default     = "172.17.0.1/16"
}

// ****************************
// Container Registry parameters
// ****************************

variable "acr_sku" {
  description = "Azure container registry sku (Standard, Premium, ...)"
  default     = "Standard"
}

// ****************************
// Storage account parameters
// ****************************

variable "storage_account_tier" {
  description = "Storage account tier (Standard, Premium, ...)"
  default     = "Premium"
}

variable "storage_account_replication_type" {
  description = "Storage account replication type (LRS, GRS, ...)"
  default     = "LRS"
}

// ****************************
// ServiceBus parameters
// ****************************

variable "servicebus_ns_sku" {
  description = "ServiceBus SKU (Basic, Standard, ...)"
  default     = "Standard"
}