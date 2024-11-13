# network_security.tf

# Define the Network Security Group for AKS
resource "azurerm_network_security_group" "aks_nsg" {
  for_each            = azurerm_resource_group.aks_rg
  name                = "${var.aks_cluster_name}-${each.key}-nsg"
  location            = each.key
  resource_group_name = each.value.name
}

# Define a rule within the Network Security Group to allow traffic between clusters
resource "azurerm_network_security_rule" "allow_aks_intercluster" {
  for_each                  = azurerm_network_security_group.aks_nsg
  name                      = "Allow-AKS-Intercluster"
  priority                  = 100
  direction                 = "Inbound"
  access                    = "Allow"
  protocol                  = "Tcp"
  source_address_prefix     = "*"
  destination_address_prefix = "*"
  source_port_range         = "*"
  destination_port_range    = "*"
  network_security_group_name = each.value.id  # Correct reference
  resource_group_name = "${var.aks_cluster_name}-${each.key}-rg"
}
