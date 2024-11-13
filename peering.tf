# peering.tf
resource "azurerm_virtual_network_peering" "vnet_peering" {
  for_each = {
    for k, vnet1 in azurerm_virtual_network.aks_vnet :
    k => {
      vnet1  = vnet1
      peers = [for vnet2 in azurerm_virtual_network.aks_vnet : vnet2 if vnet1.id != vnet2.id]
    }
  }

  name                      = "${each.value.vnet1.name}-to-${each.value.peers[0].name}"
  resource_group_name       = each.value.vnet1.resource_group_name
  virtual_network_name      = each.value.vnet1.name
  remote_virtual_network_id = each.value.peers[0].id
  allow_forwarded_traffic   = true
  allow_virtual_network_access = true
  allow_gateway_transit     = false
}
