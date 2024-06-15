resource "azurerm_virtual_network" "name" {
  for_each = length(var.address_space) > 0 ? toset([var.name]) : toset([])

  name                    = var.name
  resource_group_name     = var.resource_group_name
  address_space           = var.address_space
  location                = var.location
  dns_servers             = var.dns_servers
  edge_zone               = var.edge_zone
  flow_timeout_in_minutes = var.flow_timeout_in_minutes

  dynamic "ddos_protection_plan" {
    for_each = var.ddos_protection_plan.id != null ? toset([var.ddos_protection_plan]) : toset([])

    content {
      id     = ddos_protection_plan.value.id
      enable = ddos_protection_plan.value.enable
    }
  }

  tags = merge(local.tags, var.tags)
}
