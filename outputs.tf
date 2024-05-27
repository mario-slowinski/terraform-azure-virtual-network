output "id" {
  description = "The virtual NetworkConfiguration ID."
  value       = azurerm_virtual_network.this.id
  sensitive   = false
}

output "data" {
  description = "Virtual network data."
  value       = azurerm_virtual_network.this
  sensitive   = false
}

output "subnets" {
  description = "Virtual network subnets."
  value       = azurerm_subnet.name
  sensitive   = false
}
