resource "azurerm_storage_account" "storage_account" {

  name                          = local.storage_account_name
  location                      = var.location
  tags                          = var.tags
  account_kind                  = var.account_kind
  public_network_access_enabled = var.public_network_access_enabled

}