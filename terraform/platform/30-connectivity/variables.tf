variable "resource_group_name" {
  description = "Connectivity RG."
  type        = string
}

variable "location" {
  description = "Region for hub resources."
  type        = string
}

variable "deploy_vwan" {
  description = "If true, deploy Virtual WAN. If false, classic hub VNet."
  type        = bool
  default     = false
}

variable "vwan" {
  description = "vWAN settings."
  type = object({
    name                 = string
    type                 = optional(string, "Standard")
    allow_branch_to_branch= optional(bool, true)
    office365_breakout   = optional(string, "Optimize")
    disable_vpn_encryption = optional(bool, false)
    tags                 = optional(map(string), {})
  })
  default = {
    name = "vwan-hub"
  }
}

variable "hub_vnet" {
  description = "Hub VNet settings."
  type = object({
    name         = string
    address_space= list(string)
    ddos_plan_id = optional(string, "")
    subnets      = optional(list(object({
      name        = string
      address_prefixes = list(string)
      private_endpoint_network_policies_enabled     = optional(bool, true)
      private_link_service_network_policies_enabled = optional(bool, true)
      service_endpoints = optional(list(string), [])
      delegations = optional(list(object({
        name    = string
        service = string
        actions = optional(list(string))
      })), [])
    })), [])
    tags         = optional(map(string), {})
  })
}

variable "firewall" {
  description = "Azure Firewall settings."
  type = object({
    enabled          = bool
    name             = string
    public_ip_name   = string
    firewall_policy_id = optional(string, "")
    tier             = optional(string, "Premium")
    tags             = optional(map(string), {})
  })
  default = {
    enabled        = true
    name           = "afw-hub"
    public_ip_name = "pip-afw-hub"
  }
}

variable "bastion" {
  description = "Bastion settings."
  type = object({
    enabled        = bool
    name           = string
    public_ip_name = string
    sku            = optional(string, "Standard")
    scale_units    = optional(number, 2)
    tags           = optional(map(string), {})
  })
  default = {
    enabled        = true
    name           = "bas-hub"
    public_ip_name = "pip-bas-hub"
  }
}

variable "pdr" {
  description = "Private DNS Resolver settings."
  type = object({
    enabled             = bool
    name                = string
    inbound_subnet_name = optional(string, "snet-dns-inbound")
    outbound_subnet_name= optional(string, "snet-dns-outbound")
    tags                = optional(map(string), {})
  })
  default = {
    enabled = false
    name    = "pdr-hub"
  }
}
