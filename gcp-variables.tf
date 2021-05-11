# GCP authentication variables
variable "gcp_auth_file" {
  type = string
  description = "GCP authentication file"
}

variable "gcp_project" {
  type = string
  description = "GCP project name"
}

# Define GCP region
variable "gcp_region" {
  type = string
  description = "GCP region"
  default = "northamerica-northeast1"
}

# Define GCP zone
variable "gcp_zone" {
  type = string
  description = "GCP zone"
  default = "northamerica-northeast1-a"
}

# Define subnet CIDR
variable "gcp_subnet_cidr" {
  type = string
  description = "Subnet CIDR"
  default = "172.18.0.0/24"
}