variable "project_prefix" {
  description = "Prefix for resource naming"
  type        = string
}

variable "region" {
  description = "Azure region for resources"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "nsg_id" {
  description = "Network Security Group ID for subnet"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for backend service deployment"
  type        = string
}

variable "database_private" {
  description = "If true, the database will be private with no public access"
  type        = bool
  default     = false
}

variable "rate_limit" {
  description = "Rate limit for the API (only applies to public backend service)"
  type        = number
  default     = 0
}

variable "allowed_ips" {
  description = "Allowed IPs for outbound connection, required for Backend Service #1"
  type        = list(string)
  default     = []
}

variable "public_access" {
  description = "If true, the backend service will be publicly accessible"
  type        = bool
  default     = false
}
