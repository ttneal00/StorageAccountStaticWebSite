resource "azurerm_storage_container" "container" {
  name                  = var.container_name
  storage_account_name  = var.storage_account_name
  container_access_type = var.container_access_type
}

output "container_name" {
  value = azurerm_storage_container.container.name
}

output "container_id" {
  value = azurerm_storage_container.container.id
}