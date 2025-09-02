variable "management_group_id" {
  description = "Management Group unique ID. Keep it URL friendly. Example: contoso-platform"
  type        = string
}

variable "display_name" {
  description = "Display name for the Management Group. Defaults to management_group_id."
  type        = string
  default     = ""
}

variable "parent_management_group_id" {
  description = "Parent Management Group ID. Leave empty to place under Tenant Root."
  type        = string
  default     = ""
}
