resource "azurerm_virtual_network" "this" {
  name                = coalesce(var.name, local.name)
  resource_group_name = coalesce(var.resource_group_name, local.name)
  address_space       = var.address_space
  location            = var.location

  dns_servers             = var.dns_servers
  edge_zone               = var.edge_zone
  flow_timeout_in_minutes = var.flow_timeout_in_minutes

  dynamic "ddos_protection_plan" {
    for_each = length(var.ddos_protection_plan.id) > 0 ? toset([1]) : toset([])

    content {
      id     = var.ddos_protection_plan.id
      enable = var.ddos_protection_plan.enable
    }
  }

  tags = coalesce(var.tags, local.tags)
}
