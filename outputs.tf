# outputs.tf
output "aks_cluster_kubeconfig" {
  value = {
    for key, cluster in azurerm_kubernetes_cluster.aks_cluster : key => cluster.kube_config[0].raw_config
  }
  sensitive = true
}

output "aks_cluster_names" {
  value = {
    for key, cluster in azurerm_kubernetes_cluster.aks_cluster : key => cluster.name
  }
}
