resource "azurerm_servicebus_namespace" "sb" {
  name                = var.servicebus_ns_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.servicebus_ns_sku
}

resource "azurerm_servicebus_queue" "queue" {
  for_each = toset(var.queues)

  name                = each.key
  namespace_id        = azurerm_servicebus_namespace.sb.id
  enable_partitioning = true
}

resource "azurerm_eventgrid_system_topic" "eventgrid_new_blob_topic" {
  name                   = "new-blob"
  resource_group_name    = var.resource_group_name
  location               = var.location
  source_arm_resource_id = var.storage_account_id
  topic_type             = "Microsoft.Storage.StorageAccounts"
}

resource "azurerm_eventgrid_system_topic_event_subscription" "eventgrid_new_blob_sub" {
  name                = "new-blob"
  system_topic        = azurerm_eventgrid_system_topic.eventgrid_new_blob_topic.name
  resource_group_name = var.resource_group_name

  included_event_types          = ["Microsoft.Storage.BlobCreated"]
  service_bus_queue_endpoint_id = azurerm_servicebus_queue.queue["incoming"].id
}