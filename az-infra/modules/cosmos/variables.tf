// ****************************
// Common resource parameters
// ****************************

variable resource_group_name {
  description = "Resource Group name"
  type        = string
}

variable location {
  description = "Location in which to deploy the resources"
  type        = string
}

// ****************************
// CosmosDB parameters
// ****************************

variable cosmosdb_account_name {
  description = "CosmosDB account name"
  type        = string
}

variable cosmosdb_nosql_db_name {
  description = "CosmosDB - NoSQL DB name"
  type        = string
}


