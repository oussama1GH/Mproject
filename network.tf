# network.tf
resource "azurerm_virtual_network" "aks_vnet" {
  for_each            = azurerm_resource_group.aks_rg
  name                = "${var.aks_cluster_name}-${each.key}-vnet"
  location            = each.key
  resource_group_name = each.value.name
  address_space       = ["10.${index(var.regions, each.key) + 1}.0.0/16"]
}

resource "azurerm_subnet" "aks_subnet" {
  for_each              = azurerm_virtual_network.aks_vnet
  name                  = "${var.aks_cluster_name}-${each.key}-subnet"
  resource_group_name   = each.value.resource_group_name
  virtual_network_name  = each.value.name
  address_prefixes      = ["10.${index(var.regions, each.key) + 1}.0.0/24"]
}
