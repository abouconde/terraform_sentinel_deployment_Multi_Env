
resource "azurerm_resource_group" "rg" {
  for_each = var.environments
  name     = "${var.prefix}-${each.key}-rg"
  location = each.value
}

resource "azurerm_log_analytics_workspace" "law" {
  for_each = var.environments
  name                = "${var.prefix}-${each.key}-law"
  location            = each.value
  resource_group_name = azurerm_resource_group.rg[each.key].name
  sku                 = "PerGB2018"
}

resource "azurerm_log_analytics_solution" "sentinel" {
  for_each = var.environments
  solution_name         = "SecurityInsights"
  location              = each.value
  resource_group_name   = azurerm_resource_group.rg[each.key].name
  workspace_resource_id = azurerm_log_analytics_workspace.law[each.key].id
  workspace_name        = azurerm_log_analytics_workspace.law[each.key].name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SecurityInsights"
  }
}

resource "azurerm_storage_account" "sa" {
  count = var.environment == "prod" ? 1 : 0
  # Shortened name with substr on both prefix and the hash. Ensured the name length is within the limit.
  # Using only 2 characters from the hash and a 3-character random suffix to prevent exceeding the length.
  name = lower("${substr(var.prefix, 0, 3)}${substr(var.environment, 0, 1)}${substr(md5(azurerm_resource_group.rg["prod"].name), 0, 2)}${random_string.sa_suffix.result}")
  resource_group_name      = azurerm_resource_group.rg["prod"].name
  location                 = var.environments["prod"]
  account_tier             = "Standard" 
  account_replication_type = "GRS"   
}

resource "random_string" "sa_suffix" {
  length  = 3
  special = false
  upper   = false
  numeric = true
}
