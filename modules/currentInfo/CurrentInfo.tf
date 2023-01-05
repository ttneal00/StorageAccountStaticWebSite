data "http" "ip" {
  url = "http://ipv4.icanhazip.com"
}

data "azurerm_client_config" "current" {}

output "MyextIP" {
  value = chomp(data.http.ip.response_body)
}

output "myextIPCIDR" {
  value = "${chomp(data.http.ip.response_body)}/32"
}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "subscription_id" {
  value = data.azurerm_client_config.current.subscription_id
}

output "object_id" {
  value = data.azurerm_client_config.current.object_id
}

output "client_id" {
  value = data.azurerm_client_config.current.client_id
}


