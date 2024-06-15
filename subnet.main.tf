resource "azurerm_subnet" "name" {
  for_each = {
    for subnet in var.subnets :
    subnet.name => subnet
    if subnet.name != null
  }

  address_prefixes = each.value.address_prefixes

  dynamic "delegation" {
    for_each = {
      for delegation in coalesce(each.value.delegations, []) :
      delegation.name => delegation
      if delegation.name != null
    }
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }

  name                                          = coalesce(each.value.name, local.name)
  private_endpoint_network_policies_enabled     = each.value.private_endpoint_network_policies_enabled
  private_link_service_network_policies_enabled = each.value.private_link_service_network_policies_enabled
  resource_group_name                           = coalesce(each.value.resource_group_name, var.resource_group_name, local.name)
  service_endpoints                             = each.value.service_endpoints
  service_endpoint_policy_ids                   = each.value.service_endpoint_policy_ids
  virtual_network_name                          = local.virtual_network.name
}
