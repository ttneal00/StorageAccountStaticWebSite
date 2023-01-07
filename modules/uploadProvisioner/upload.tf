resource "null_resource" "fileUpload" {
  provisioner "local-exec" {
    command = <<Settings
    $resourceGroupName = "${var.resource_group_name}"
    $storageAccountName = "${var.storage_account_name}"
    $storageAccount = Get-AzStorageAccount -StorageAccountName $storageAccountName -ResourceGroupName $resourceGroupName
    $context = $storageAccount.context
    $HTMLUL = @{
    File             = 'index.html'
    Container        = '$web'
    Blob             = 'index.html'
    Context          = $context
    StandardBlobTier = 'Hot'
  }

  Set-AzStorageBlobContent @HTMLUL -Properties @{"ContentType" = "text/html"} -Verbose
    Settings

    interpreter = ["PowerShell", "-Command"]
  }
}