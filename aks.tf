# aks.tf
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  for_each              = azurerm_virtual_network.aks_vnet
  name                  = "${var.aks_cluster_name}-${each.key}"
  location              = each.key
  resource_group_name   = each.value.resource_group_name
  dns_prefix            = "${var.aks_cluster_name}-${each.key}"
  
  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.node_size
    vnet_subnet_id = azurerm_subnet.aks_subnet[each.key].id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }
}
