output "data" {
  description = "Virtual network data."
  value       = length(var.address_space) > 0 ? one(azurerm_virtual_network.this[*]) : one(data.azurerm_virtual_network.this[*])
  sensitive   = false
}
