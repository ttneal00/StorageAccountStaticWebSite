provider "azurerm" {
  features {}
}

module "randomId" {
  source = "./modules/randomId"
}

module "currentInfo" {
  source = "./modules/currentInfo"

}

module "storageAccountRG" {
  source              = "./modules/resourceGroup"
  resource_group_name = "${var.env}-storage-RG"
  location            = var.location
  tags                = local.tags
}

module "storageAccount" {
  source                        = "./modules/storageAccount"
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  location                      = var.location
  public_network_access_enabled = true
  tags                          = local.tags
  storage_account_name          = local.storageAccountName
  resource_group_name           = module.storageAccountRG.resource_group_name

}

module "storageNetworkrules" {
  source = "./modules/storageAccountNetworkRules"
  ip_rules = module.currentInfo.MyextIP
  default_action = "Deny"
  storage_account_id = module.storageAccount.storageAccountid
}

module "uploadfile" {
  source = "./modules/uploadProvisioner"
  resource_group_name = module.storageAccountRG.resource_group_name
  storage_account_name = module.storageAccount.storageAccountName
}
output "storageAccountName" {
  value = module.storageAccount.storageAccountName
}

output "storageAccountid" {
  value = module.storageAccount.storageAccountid
}

output "resourceGroupName" {
  value = module.storageAccountRG.resource_group_name
}

output "URL" {
  value = module.storageAccount.URL
}