// ****************************
// Common resource parameters
// ****************************

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  description = "Location in which to deploy the resources"
  type        = string
}

// ****************************
// AKS parameters
// ****************************

variable "aks_cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "aks_version_prefix" {
  description = "AKS Kubernetes version prefix"
  type        = string
}

variable "nodepool_nodes_count" {
  description = "Default nodepool nodes count"
  type        = number
}

variable "nodepool_vm_size" {
  description = "Default nodepool VM size"
  type        = string
}

variable "nodepool_subnet_id" {
  description = "Subnet ID for the default node pool"
  type        = string
}

variable "aks_subnet_cidr" {
  description = "Subnet cidr for kubernetes nodes and pods"
  type        = string
}

variable "aks_service_cidr" {
  description = "Cidr for kubernetes services "
  type        = string
}

variable "dns_service_ip" {
  description = "CNI DNS service IP"
  type        = string
}

variable "docker_bridge_cidr" {
  description = "CNI Docker bridge cidr"
  type        = string
}

// ****************************
// ACR parameters
// ****************************

variable "acr_name" {
  description = "Name of the container registry"
  type        = string
}

variable "acr_sku" {
  description = "Azure container registry sku (Standard, Premium, ...)"
  type        = string
}
