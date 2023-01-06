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

resource "null_resource" "fileUpload" {
  provisioner "local-exec" {
    command = <<Settings
    $resourceGroupName = "${module.storageAccountRG.resource_group_name}"
    $storageAccountName = "${module.storageAccount.storageAccountName}"
    $containerName = "${module.storageContainer.container_name}"
    $storageAccount = Get-AzStorageAccount -StorageAccountName $storageAccountName -ResourceGroupName $resourceGroupName
    $context = $storageAccount.context
    $Blob1HT = @{
    File             = 'C:\Users\tneal\OneDrive\Blog Posts\Well Architected Frameworks\azureStaticWebsite\index.html'
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
    module.storageContainer
  ]
}

output "storageAccountName" {
  value = module.storageAccount.storageAccountName
}

output "storageAccountid" {
  value = module.storageAccount.storageAccountid
}

output "containerName" {
  value = module.storageContainer.container_name
}

output "resourceGroupName" {
  value = module.storageAccountRG.resource_group_name
}