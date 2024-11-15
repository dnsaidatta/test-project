# outputs.tf

output "app_gateway_ip" {
  description = "Public IP of the Application Gateway"
  value       = module.app_gateway.public_ip
}

output "react_web_app_url" {
  description = "URL of the React Web App"
  value       = module.react_web_app.web_app_url
}

output "backend_service_1_url" {
  description = "Internal URL for Backend Service #1 (Bank Integration)"
  value       = module.backend_service_1.app_service_url
}

output "backend_service_2_url" {
  description = "Public URL for Backend Service #2 (External API)"
  value       = module.backend_service_2.app_service_url
}
