output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "frontend_subnet_id" {
  description = "ID of the frontend subnet"
  value       = azurerm_subnet.frontend.id
}

output "internal_backend_subnet_id" {
  description = "ID of the internal backend subnet"
  value       = azurerm_subnet.internal_backend.id
}

output "public_backend_subnet_id" {
  description = "ID of the public backend subnet"
  value       = azurerm_subnet.public_backend.id
}
