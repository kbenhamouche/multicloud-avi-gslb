
data "avi_healthmonitor" "default_gslb_health_monitor" {
   name = "System-GSLB-HTTP"
}

// Define the GSLB service
resource "avi_gslbservice" "gslb_service_web" {
    depends_on = [local.aws-ext-ip, local.azure-ext-ip, local.gcp-ext-ip]
    name = var.gslb_service_name
    domain_names = [var.gslb_domain_name]
    wildcard_match = false
    health_monitor_refs = [data.avi_healthmonitor.default_gslb_health_monitor.id]
    controller_health_status_enabled = true
    site_persistence_enabled = false
    is_federated = false
    use_edns_client_subnet = false
    enabled = true
    ttl = 1
    groups { 
        name = "${var.gslb_service_name}-pool"
        priority = 10
        algorithm = "GSLB_ALGORITHM_ROUND_ROBIN"
        consistent_hash_mask=31
        consistent_hash_mask6=31
        // AWS
        members {
            ip {
                type = "V4"
                addr = local.aws-ext-ip
            }
            ratio = 1    
            enabled = true
        }
        // Azure
        members {
            ip {
                type = "V4"
                addr = local.azure-ext-ip
            }
            ratio = 1    
        enabled = true
        }
        // GCP
        members {
            ip {
                type = "V4"
                addr = local.gcp-ext-ip
            }
            ratio = 1    
            enabled = true
        }
    }
}