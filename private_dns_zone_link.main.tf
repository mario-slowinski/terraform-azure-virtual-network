resource "azurerm_private_dns_zone_virtual_network_link" "zone" {
  for_each = {
    for private_dns_zone in var.private_dns_zones :
    private_dns_zone.private_dns_zone_name => private_dns_zone
    if private_dns_zone.private_dns_zone_name != null
  }

  name                  = coalesce(each.value.name, var.name)
  private_dns_zone_name = each.value.private_dns_zone_name
  resource_group_name   = coalesce(each.value.resource_group_name, var.resource_group_name)
  virtual_network_id    = local.virtual_network.id
  registration_enabled  = each.value.registration_enabled
  tags                  = merge(local.tags, var.tags, each.value.tags)

  depends_on = [
    azurerm_virtual_network.this,
  ]
}
