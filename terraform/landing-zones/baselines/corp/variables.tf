variable "subscription_id" {
  description = "Target subscription GUID for RBAC and diagnostics."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the baseline resource group to create in the subscription."
  type        = string
  default     = "rg-lz-corp"
}

variable "location" {
  description = "Azure region for the baseline RG."
  type        = string
}

variable "workspace_id" {
  description = "Log Analytics workspace resource ID for diagnostics."
  type        = string
  default     = ""
}

variable "route_tables" {
  description = "Optional route table definitions for the landing zone."
  type        = list(object({
    name                          = string
    disable_bgp_route_propagation = optional(bool, false)
    routes = optional(list(object({
      name                = string
      address_prefix      = string
      next_hop_type       = string
      next_hop_ip_address = optional(string)
    })), [])
  }))
  default = []
}

variable "nsgs" {
  description = "Optional NSG definitions for the landing zone."
  type        = list(object({
    name  = string
    rules = optional(list(object({
      name              = string
      priority          = number
      direction         = string
      access            = string
      protocol          = string
      source            = string
      destination       = string
      source_ports      = string
      destination_ports = string
    })), [])
  }))
  default = []
}

variable "rbac_owners" {
  description = "Owner principal IDs for subscription RBAC."
  type        = list(string)
  default     = []
}

variable "rbac_contributors" {
  description = "Contributor principal IDs for subscription RBAC."
  type        = list(string)
  default     = []
}

variable "diagnostic_targets" {
  description = "List of resource IDs to attach diagnostic settings to."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Default tags applied to created resources."
  type        = map(string)
  default     = {}
}
