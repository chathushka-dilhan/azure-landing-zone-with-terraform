variable "subscription_id" {
  description = "Target subscription GUID for RBAC and diagnostics."
  type        = string
}

variable "resource_group_name" {
  description = "Baseline resource group name."
  type        = string
  default     = "rg-lz-online"
}

variable "location" {
  description = "Region for the baseline RG."
  type        = string
}

variable "workspace_id" {
  description = "Log Analytics workspace resource ID for diagnostics."
  type        = string
  default     = ""
}

variable "nsgs" {
  description = "Optional NSG definitions."
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
  description = "Default tags."
  type        = map(string)
  default     = {}
}
