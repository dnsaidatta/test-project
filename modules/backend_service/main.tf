# App Service Plan for scaling the backend services
resource "azurerm_app_service_plan" "service_plan" {
  name                = "${var.project_prefix}-appserviceplan"
  location            = var.region
  resource_group_name = var.resource_group_name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

# App Service (Web App)
resource "azurerm_app_service" "app_service" {
  name                = "${var.project_prefix}-appservice"
  location            = var.region
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.service_plan.id

  app_settings = {
    "WEBSITE_RATE_LIMIT" = var.rate_limit != 0 ? var.rate_limit : ""
  }

  # Conditional public or private access
  https_only = var.public_access
}

# Database (Cosmos DB)
resource "azurerm_cosmosdb_account" "cosmos_db" {
  name                = "${var.project_prefix}-cosmosdb"
  location            = var.region
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  consistency_policy {
    consistency_level = "Session"
  }

  # Private or public access based on input
  public_network_access_enabled = var.database_private ? false : true
}
