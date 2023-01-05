provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

locals {
  storageAccountName = module.randomString.hex
}

module "randomString" {
  source = "./modules/randomid"
}

output "hex" {
  value = module.randomString.hex
}