output "data" {
  description = "Virtual network data."
  value       = azurerm_virtual_network.this
  sensitive   = false
}
