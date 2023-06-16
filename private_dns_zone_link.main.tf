resource "azurerm_private_dns_zone_virtual_network_link" "many" {
  count = length(var.private_dns_zones)

  name                  = coalesce(var.private_dns_zones[count.index].name, var.name)
  private_dns_zone_name = var.private_dns_zones[count.index].private_dns_zone_name
  resource_group_name   = coalesce(var.private_dns_zones[count.index].resource_group_name, var.resource_group_name)
  virtual_network_id    = azurerm_virtual_network.this.id
  registration_enabled  = try(var.private_dns_zones[count.index].registration_enabled, null)
  tags = coalesce(
    var.private_dns_zones[count.index].tags,
    var.tags,
    local.tags
  )
  depends_on = [
    azurerm_virtual_network.this,
  ]
}
