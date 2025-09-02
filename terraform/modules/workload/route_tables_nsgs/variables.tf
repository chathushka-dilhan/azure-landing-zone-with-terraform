variable "resource_group_name" {
  description = "Resource Group name."
  type        = string
}

variable "location" {
  description = "Region."
  type        = string
}

variable "route_tables" {
  description = <<EOT
Route tables to create.
Example:
[
  {
    name = "rt-shared"
    bgp_route_propagation_enabled = false
    routes = [
      { name = "to-firewall", address_prefix = "0.0.0.0/0", next_hop_type = "VirtualAppliance", next_hop_ip_address = "10.0.0.4" }
    ]
  }
]
EOT
  type = list(object({
    name                           = string
    bgp_route_propagation_enabled  = optional(bool, false)
    routes = optional(list(object({
      name               = string
      address_prefix     = string
      next_hop_type      = string
      next_hop_ip_address = optional(string)
    })), [])
  }))
  default = []
}

variable "nsgs" {
  description = <<EOT
NSGs to create.
Example:
[
  {
    name  = "nsg-web"
    rules = [
      { name = "Allow-HTTP", priority = 100, direction = "Inbound", access = "Allow", protocol = "Tcp", source = "*", destination = "*", source_ports = "*", destination_ports = "80" }
    ]
  }
]
EOT
  type = list(object({
    name  = string
    rules = optional(list(object({
      name              = string
      priority          = number
      direction         = string   # Inbound or Outbound
      access            = string   # Allow or Deny
      protocol          = string   # Tcp, Udp, or *
      source            = string
      destination       = string
      source_ports      = string
      destination_ports = string
    })), [])
  }))
  default = []
}

variable "tags" {
  description = "Default tags."
  type        = map(string)
  default     = {}
}
