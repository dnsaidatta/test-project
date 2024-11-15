resource "azurerm_public_ip" "app_gateway_public_ip" {
  name                = "${var.project_prefix}-app-gateway-ip"
  location            = var.region
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "app_gateway" {
  name                = "${var.project_prefix}-app-gateway"
  location            = var.region
  resource_group_name = var.resource_group_name
  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  frontend_ip_configuration {
    name                 = "FrontendIP"
    public_ip_address_id = azurerm_public_ip.app_gateway_public_ip.id
  }

  frontend_port {
    name = "FrontendPort"
    port = 80
  }

  http_listener {
    name                           = "Listener"
    frontend_ip_configuration_name = "FrontendIP"
    frontend_port_name             = "FrontendPort"
    protocol                       = "Http"
  }
}
