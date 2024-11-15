# main.tf

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "${var.project_prefix}-rg"
  location = var.region
}

# VNet and Subnets
module "vnet" {
  source              = "./modules/vnet"
  project_prefix      = var.project_prefix
  region              = var.region
  resource_group_name = azurerm_resource_group.main.name
}

# Network Security Groups
module "nsg" {
  source              = "./modules/nsg"
  project_prefix      = var.project_prefix
  region              = var.region
  resource_group_name = azurerm_resource_group.main.name
  allowed_ips         = var.allowed_ips
}

# Application Gateway with WAF
module "app_gateway" {
  source              = "./modules/app_gateway"
  project_prefix      = var.project_prefix
  region              = var.region
  resource_group_name = azurerm_resource_group.main.name
  vnet_id             = module.vnet.vnet_id
  subnet_id           = module.vnet.frontend_subnet_id
}

# React Web App (Static Site)
module "react_web_app" {
  source              = "./modules/react_web_app"
  project_prefix      = var.project_prefix
  region              = var.region
  resource_group_name = azurerm_resource_group.main.name
}

# Backend Service #1 (Internal API, Bank Integration)
module "backend_service_1" {
  source              = "./modules/backend_service"
  project_prefix      = "${var.project_prefix}-backend1"
  region              = var.region
  resource_group_name = azurerm_resource_group.main.name
  nsg_id              = module.nsg.internal_backend_nsg_id
  subnet_id           = module.vnet.internal_backend_subnet_id
  database_private    = true
  allowed_ips         = var.allowed_ips
  rate_limit          = 0  # No rate limit on internal API
  public_access       = false
}

# Backend Service #2 (Public API, consumed by the web app)
module "backend_service_2" {
  source              = "./modules/backend_service"
  project_prefix      = "${var.project_prefix}-backend2"
  region              = var.region
  resource_group_name = azurerm_resource_group.main.name
  nsg_id              = module.nsg.public_backend_nsg_id
  subnet_id           = module.vnet.public_backend_subnet_id
  database_private    = false
  allowed_ips         = []
  rate_limit          = var.rate_limit  # Rate limit of 10 requests per second
  public_access       = true
}
