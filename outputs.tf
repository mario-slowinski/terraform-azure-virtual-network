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
