variable "name" {
  description = "Private DNS Resolver name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name."
  type        = string
}

variable "location" {
  description = "Region."
  type        = string
}

variable "vnet_id" {
  description = "VNet resource ID to attach the resolver."
  type        = string
}

variable "inbound_subnet_name" {
  description = "Inbound endpoint subnet name. Used when inbound_subnet_id is not provided."
  type        = string
  default     = "snet-dns-inbound"
}

variable "inbound_subnet_id" {
  description = "Inbound endpoint subnet ID. Overrides inbound_subnet_name if set."
  type        = string
  default     = ""
}

variable "outbound_subnet_name" {
  description = "Outbound endpoint subnet name. Used when outbound_subnet_id is not provided."
  type        = string
  default     = "snet-dns-outbound"
}

variable "outbound_subnet_id" {
  description = "Outbound endpoint subnet ID. Overrides outbound_subnet_name if set."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
