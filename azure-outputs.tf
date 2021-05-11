# Azure output

locals {
  azure-ext-ip = azurerm_public_ip.azure-web-ip.ip_address 
}

output "azure-web-server-external-ip" {
  description = "Public IP of VM running on Azure"
  value = local.azure-ext-ip
}