// Variables required for AVI connection.
variable "avi_controller" {
    type = string
    description = "AVI Host IP address"
    default = "10.5.99.170"
}

variable "avi_username" {
    type = string
    description = "AVI Username"
} 

variable "avi_password" {
    type = string
    description = "AVI Password"
} 

variable "avi_tenant" {
    type = string
    description = "AVI Tenant Name"
    default = "admin"
}

# GSLB Variables

variable "gslb_site_name" {
    type = string
    description = "GSLB Site"
    default = "GSLB-Main-Site"
}

variable "gslb_default_name" {
    type = string
    description = "GSLB Name"
    default = "Default"
}

variable "gslb_service_name" {
    type = string
    description = "GSLB Service Name"
    default = "GSLB-MultiCloud-Web"
}

variable "gslb_domain_name" {
    type = string
    description = "GSLB Domain Name"
    default = "multicloud.ovn.ca"
}