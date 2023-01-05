resource "azurerm_storage_account_network_rules" "saNetworkRules" {
  storage_account_id         = var.storage_account_id
  default_action             = var.default_action
  ip_rules                   = [var.ip_rules]
  virtual_network_subnet_ids = [var.subnetid]
}