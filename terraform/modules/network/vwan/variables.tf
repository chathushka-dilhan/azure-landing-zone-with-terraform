variable "name" {
  description = "Virtual WAN name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name."
  type        = string
}

variable "location" {
  description = "Region for the Virtual WAN."
  type        = string
}

variable "vwan_type" {
  description = "Virtual WAN type. Standard or Basic."
  type        = string
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "Basic"], var.vwan_type)
    error_message = "vwan_type must be Standard or Basic."
  }
}

variable "allow_branch_to_branch" {
  description = "Enable branch to branch traffic."
  type        = bool
  default     = true
}

variable "office365_breakout_category" {
  description = "Office 365 local breakout category. Optimize, OptimizeAndAllow, or All."
  type        = string
  default     = "Optimize"
  validation {
    condition     = contains(["Optimize", "OptimizeAndAllow", "All"], var.office365_breakout_category)
    error_message = "office365_breakout_category must be Optimize, OptimizeAndAllow, or All."
  }
}

variable "disable_vpn_encryption" {
  description = "Disable site-to-site VPN encryption."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
