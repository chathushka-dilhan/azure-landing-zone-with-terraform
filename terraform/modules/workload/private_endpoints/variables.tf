variable "resource_group_name" {
  description = "Resource Group name."
  type        = string
}

variable "location" {
  description = "Region."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where Private Endpoints will be created."
  type        = string
}

variable "endpoints" {
  description = <<EOT
List of private endpoints.
Example:
[
  {
    name                = "pe-storage"
    target_resource_id  = "/subscriptions/.../resourceGroups/.../providers/Microsoft.Storage/storageAccounts/xxx"
    group_ids           = ["blob"]
    dns_zone_ids        = ["/subscriptions/.../resourceGroups/.../providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"]
    tags                = { workload = "web" }
  }
]
EOT
  type = list(object({
    name               = string
    target_resource_id = string
    group_ids          = list(string)
    dns_zone_ids       = optional(list(string), [])
    tags               = optional(map(string))
  }))
}

variable "tags" {
  description = "Default tags."
  type        = map(string)
  default     = {}
}
