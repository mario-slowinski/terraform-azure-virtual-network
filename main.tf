data "azurerm_virtual_network" "this" {
  count = length(var.address_space) > 0 ? 0 : 1

  name                = length(var.name) > 0 ? var.name : replace(join(var.separator, local.names), " ", var.space)
  resource_group_name = length(var.resource_group_name) > 0 ? var.resource_group_name : replace(join(var.separator, local.names), " ", var.space)
}

resource "azurerm_virtual_network" "this" {
  count = length(var.address_space) > 0 ? 1 : 0

  name                = length(var.name) > 0 ? var.name : replace(join(var.separator, local.names), " ", var.space)
  resource_group_name = length(var.resource_group_name) > 0 ? var.resource_group_name : replace(join(var.separator, local.names), " ", var.space)
  location            = var.location
  address_space       = var.address_space

  tags = length(var.tags) > 0 ? (
    var.tags
    ) : (
    { for tag in local.tags : tag.key => tag.value }
  )
}
