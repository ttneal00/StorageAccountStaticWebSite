resource "azurerm_storage_account" "storage_account" {

  name                          = var.storage_account_name
  location                      = var.location
  tags                          = var.tags
  account_kind                  = var.account_kind
  public_network_access_enabled = var.public_network_access_enabled
  resource_group_name           = var.resource_group_name
  account_tier                  = var.account_tier
  account_replication_type      = var.account_replication_type
  access_tier                   = var.access_tier
  enable_https_traffic_only     = var.enable_https_traffic_only
  static_website {
    index_document = var.index_document
  }

}

output "storageAccountName" {
  value = azurerm_storage_account.storage_account.name
}

output "storageAccountid" {
  value = azurerm_storage_account.storage_account.id
}

