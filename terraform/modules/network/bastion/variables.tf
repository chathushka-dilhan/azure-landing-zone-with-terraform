variable "name" {
  description = "Bastion name."
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
  description = "VNet resource ID that contains AzureBastionSubnet."
  type        = string
}

variable "public_ip_name" {
  description = "Public IP name for Bastion."
  type        = string
}

variable "sku" {
  description = "Bastion SKU. Basic or Standard."
  type        = string
  default     = "Standard"
  validation {
    condition     = contains(["Basic", "Standard"], var.sku)
    error_message = "sku must be Basic or Standard."
  }
}

variable "scale_units" {
  description = "Number of Bastion scale units. Valid for Standard SKU."
  type        = number
  default     = 2
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
