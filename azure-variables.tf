# Azure authentication variables 
variable "azure_subscription_id" {
  type = string
  description = "Azure Subscription ID"
}

variable "azure_client_id" {
  type = string
  description = "Azure Client ID"
}

variable "azure_client_secret" {
  type = string
  description = "Azure Client Secret"
}

variable "azure_tenant_id" {
  type = string
  description = "Azure Tenant ID"
}

#Location Resource Group
variable "azure-region" {
  type = string
  description = "Location of Resource Group"
  default = "canadacentral"
}

#VNET CIDR
variable "azure_vnet_cidr" {
  type = string
  description = "Vnet CIDR"
  default = "172.19.0.0/16"
}

#Subnet CIDR
variable "azure_subnet_cidr" {
  type = string
  description = "Subnet CIDR"
  default = "172.19.0.0/24"
}

#Linux VM Admin User
variable "linux_admin_user" {
  type = string
  description = "Admin User"
  default = "webadmin"
}

#Linux VM Admin Password
variable "linux_admin_password" {
  type = string
  description = "Admin Password"
  default = "M!53cr3tP@ssw0rd"
}

#Linux VM Hostname
variable "linux_vm_hostname" {
  type = string
  description = "VM Hostname"
  default = "web-vm"
}

#Ubuntu Linux Publisher used to build VMs
variable "ubuntu-linux-publisher" {
  type = string
  description = "Ubuntu Linux Publisher used to build VMs"
  default = "Canonical"
}

#Ubuntu Linux Offer used to build VMs
variable "ubuntu-linux-offer" {
  type = string
  description = "Ubuntu Linux Offer used to build VMs"
  default = "UbuntuServer"
}

#Ubuntu Linux 18.x SKU used to build VMs
variable "ubuntu-linux-18-sku" {
  type = string
  description = "Ubuntu Linux Server SKU used to build VMs"
  default = "18.04-LTS"
}