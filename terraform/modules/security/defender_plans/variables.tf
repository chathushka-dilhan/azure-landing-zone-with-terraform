variable "auto_provisioning_on" {
  description = "Enable auto provisioning in Defender for Cloud."
  type        = bool
  default     = true
}

variable "contact_name" {
  description = "Security contact name for Defender notifications. Optional."
  type        = string
  default     = ""
}

variable "contact_email" {
  description = "Security contact email for Defender notifications. Leave empty to skip."
  type        = string
  default     = ""
}

variable "contact_phone" {
  description = "Security contact phone. Optional."
  type        = string
  default     = ""
}

variable "alert_notifications" {
  description = "Send notification emails to the security contact."
  type        = bool
  default     = true
}

variable "alerts_to_subscription_owners" {
  description = "Send email notifications to subscription owners."
  type        = bool
  default     = false
}

variable "plans" {
  description = <<EOT
Defender plans by resource type. Keys must match Azure resource types, values are Free or Standard.
Example:
{
  VirtualMachines                 = "Standard"
  AppServices                     = "Standard"
  SqlServers                      = "Standard"
  SqlServerVirtualMachines        = "Standard"
  StorageAccounts                 = "Standard"
  KubernetesService               = "Standard"
  ContainerRegistry               = "Standard"
  KeyVaults                       = "Standard"
  Dns                             = "Standard"
  Arm                             = "Standard"
  OpenSourceRelationalDatabases   = "Standard"
}
EOT
  type    = map(string)
  default = {}
}
