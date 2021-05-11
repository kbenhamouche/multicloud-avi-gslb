# GCP outputs

locals {
  gcp-ext-ip = google_compute_address.gcp-web-ip.address 
}
output "gcp-web-server-external-ip" {
  description = "Public IP of VM running on GCP"
  value = local.gcp-ext-ip
}

