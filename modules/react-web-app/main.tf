resource "azurerm_storage_account" "static_site" {
  name                     = "${var.project_prefix}webapp"
  resource_group_name      = var.resource_group_name
  location                 = var.region
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }
}

resource "azurerm_storage_container" "web_app_files" {
  name                  = "$web"
  storage_account_name  = azurerm_storage_account.static_site.name
  container_access_type = "blob"
}

output "web_app_url" {
  description = "URL of the React web app"
  value       = azurerm_storage_account.static_site.primary_web_endpoint
}
