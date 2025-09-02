variable "name" {
  description = "Action Group name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name."
  type        = string
}

variable "short_name" {
  description = "Short name used in notifications."
  type        = string
}

variable "email_receivers" {
  description = "Email receivers list."
  type = list(object({
    name                    = string
    email_address           = string
    use_common_alert_schema = optional(bool, true)
  }))
  default = []
}

variable "webhook_receivers" {
  description = "Webhook receivers list."
  type = list(object({
    name                    = string
    service_uri             = string
    use_common_alert_schema = optional(bool, true)
  }))
  default = []
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
