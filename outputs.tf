output "id" {
  description = "The virtual NetworkConfiguration ID."
  value       = local.virtual_network.id
  sensitive   = false
}

output "data" {
  description = "Virtual network data."
  value       = local.virtual_network
  sensitive   = false
}

output "subnets" {
  description = "Virtual network subnets."
  value       = azurerm_subnet.name
  sensitive   = false
}
