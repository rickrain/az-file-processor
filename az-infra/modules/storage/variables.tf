variable "name" {
  description = "Storage account name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  description = "Location in which to deploy the storage account"
  type        = string
}

variable "tier" {
  description = "Storage account tier (Standard, Premium, ...)"
  type        = string
}

variable "replication_type" {
  description = "Storage account replication type (LRS, GRS, ...)"
  type        = string
}