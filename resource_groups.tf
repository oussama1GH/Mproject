# resource_groups.tf
resource "azurerm_resource_group" "aks_rg" {
  for_each = toset(var.regions)
  name     = "${var.aks_cluster_name}-${each.key}-rg"
  location = each.key
}
