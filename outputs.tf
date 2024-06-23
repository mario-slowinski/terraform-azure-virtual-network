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

output "gateway_connections" {
  description = "Virtual Network Gateway Connections id."
  value = {
    for name, gateway_connection in azurerm_virtual_network_gateway_connection.name :
    name => gateway_connection.id
  }
  sensitive = false
}
