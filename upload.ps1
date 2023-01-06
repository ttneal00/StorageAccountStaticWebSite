

param([String]$StorageAccountName, [String]$resourceGroup, [String]$containerName )

write-host $StorageAccountName
write-host $resourceGroup
Write-Host $containerName



$storageAccount = Get-AzStorageAccount -StorageAccountName $StorageAccountName -ResourceGroupName $resourceGroup
New-AzStorageAccount -ResourceGroupName $resourceGroup -SkuName Standard_LRS -Kind StorageV2 -AccessTier 'Hot' -Location eastus -Name 'ttn8675309'
$StorageAccount|export-csv 'C:\Users\tneal\OneDrive - Hitachi Solutions\Downloads.exporttest.csv'
<#
$context = $storageAccount.Context
$storageAccount.Context|Out-File 'C:\Users\tneal\OneDrive\Download\contexttst.txt'

$Blob1HT = @{
    File             = 'C:\Users\tneal\OneDrive\Pictures\DJI_0172.JPG'
    Container        = $containerName
    Blob             = "DJI_0172.JPG"
    Context          = $context
    StandardBlobTier = 'Hot'
  }

  Set-AzStorageBlobContent @Blob1HT -Verbose

  #>