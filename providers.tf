# Initialize the AVI Provider
provider "avi" {
    avi_username   = var.avi_username
    avi_password   = var.avi_password
    avi_controller = var.avi_controller
    avi_tenant     = var.avi_tenant
    avi_version = "20.1.1"
}

# AWS Provider
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  assume_role {
    role_arn = var.aws_role_arn
  }
  region = var.aws_region
}

# Azure Provider
provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
  client_id = var.azure_client_id
  client_secret = var.azure_client_secret
  tenant_id = var.azure_tenant_id
}

# GCP Provider
provider "google" {
  project = var.gcp_project
  credentials = file(var.gcp_auth_file)
  region = var.gcp_region
  zone = var.gcp_zone
}