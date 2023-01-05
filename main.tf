provider "azurerm" {
  features {}
}

module "randomString" {
  source = "./modules/randomid"
}

output "hex" {
  value = module.randomString.hex
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
  account_replication_type = "LRS"
  location                      = var.location
  public_network_access_enabled = true
  tags                          = local.tags
  storage_account_name          = local.storageAccountName
  resource_group_name           = module.storageAccountRG.resource_group_name

}

output "storageAccountName" {
  value = module.storageAccount.storageAccountName
}

output "storageAccountid" {
  value = module.storageAccount.storageAccountid
}