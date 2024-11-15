output "web_app_url" {
  description = "URL of the React web app"
  value       = azurerm_storage_account.static_site.primary_web_endpoint
}
