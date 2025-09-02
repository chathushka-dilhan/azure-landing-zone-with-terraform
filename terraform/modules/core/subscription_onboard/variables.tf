variable "subscription_id" {
  description = "Subscription GUID to onboard. Example: 00000000-0000-0000-0000-000000000000"
  type        = string
}

variable "management_group_id" {
  description = "Target Management Group ID. Example: contoso-landingzones"
  type        = string
}

variable "tags" {
  description = "Tags to set at subscription scope."
  type        = map(string)
  default     = {}
}
