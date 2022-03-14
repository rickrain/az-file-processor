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
// ServiceBus parameters
// ****************************

variable "servicebus_ns_name" {
  description = "ServiceBus namespace name"
  type        = string
}

variable "servicebus_ns_sku" {
  description = "ServiceBus SKU (Basic, Standard, ...)"
  type        = string
}

variable "queues" {
  description = "ServiceBus queues"
  type        = list(string)
}

variable "storage_account_id" {
  description = "Storage account ID for event grid topic"
  type        = string
}
