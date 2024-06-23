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

output "local_network_gateways" {
  description = "Local Network Gateways id."
  value = {
    for name, local_network_gateway in azurerm_local_network_gateway.name :
    name => local_network_gateway.id
  }
  sensitive = false
}
