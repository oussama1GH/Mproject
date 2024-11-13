# variables.tf
variable "regions" {
  description = "List of Azure regions for multi-region AKS deployment"
  type        = list(string)
  default     = ["East US", "West Europe"]
}

variable "aks_cluster_name" {
  description = "Name for the AKS clusters"
  type        = string
  default     = "multi-region-aks"
}

variable "node_count" {
  description = "Number of nodes per cluster"
  type        = number
  default     = 2
}

variable "node_size" {
  description = "Size of each AKS node"
  type        = string
  default     = "Standard_DS2_v2"
}
