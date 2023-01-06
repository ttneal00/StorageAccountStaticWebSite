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

resource "null_resource" "fileUpload" {
  provisioner "local-exec" {
    command = <<Settings
    $resourceGroupName = "${module.storageAccountRG.resource_group_name}"
    $storageAccountName = "${module.storageAccount.storageAccountName}"
    $storageAccount = Get-AzStorageAccount -StorageAccountName $storageAccountName -ResourceGroupName $resourceGroupName
    $context = $storageAccount.context
    $Blob1HT = @{
    File             = 'index.html'
    Container        = '$web'
    Blob             = 'index.html'
    Context          = $context
    StandardBlobTier = 'Hot'
  }

  Set-AzStorageBlobContent @Blob1HT -Properties @{"ContentType" = "text/html"} -Verbose
    Settings

    interpreter = ["PowerShell", "-Command"]
  }

  depends_on = [
    module.storageAccount
  ]
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