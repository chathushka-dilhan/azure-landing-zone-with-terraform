variable "resource_group_name" {
  description = "Resource Group name."
  type        = string
}

variable "location" {
  description = "Region."
  type        = string
}

variable "plan_name" {
  description = "App Service Plan name."
  type        = string
}

variable "sku_name" {
  description = "SKU name. Example P1v3, P2v3, S1."
  type        = string
  default     = "P1v3"
}

variable "create_site" {
  description = "Set true to create a Web App."
  type        = bool
  default     = true
}

variable "site_name" {
  description = "Web App name when create_site is true."
  type        = string
  default     = ""
}

variable "site_managed_identity" {
  description = "Enable system-assigned identity on the Web App."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
