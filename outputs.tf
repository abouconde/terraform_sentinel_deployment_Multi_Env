
output "resource_group_names" {
  value = { for env, rg in azurerm_resource_group.rg : env => rg.name }
}

output "log_analytics_workspace_ids" {
  value = { for env, law in azurerm_log_analytics_workspace.law : env => law.id }
}

output "storage_account_name" {
  value = var.environment == "prod" ? azurerm_storage_account.sa[0].name : ""
}
