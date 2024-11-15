output "app_service_url" {
  description = "URL of the backend app service"
  value       = azurerm_app_service.app_service.default_site_hostname
}

output "database_endpoint" {
  description = "Endpoint for the backend service's database"
  value       = azurerm_cosmosdb_account.cosmos_db.endpoint
}
