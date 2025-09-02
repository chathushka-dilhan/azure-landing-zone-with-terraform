variable "name" {
  description = "Hub VNet name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name."
  type        = string
}

variable "location" {
  description = "Region for the VNet."
  type        = string
}

variable "address_space" {
  description = "Address space for the VNet."
  type        = list(string)
}

variable "ddos_plan_id" {
  description = "Optional DDOS Network Protection Plan resource ID."
  type        = string
  default     = ""
}

variable "subnets" {
  description = <<EOT
List of subnets to create. Example:
[
  {
    name                                          = "AzureFirewallSubnet"
    address_prefixes                              = ["10.0.0.0/26"]
    private_endpoint_network_policies_enabled     = true
    private_link_service_network_policies_enabled = false
    service_endpoints                             = ["Microsoft.Storage"]
    delegations = [
      { name = "d1", service = "Microsoft.Web/serverFarms" }
    ]
  }
]
EOT
  type = list(object({
    name                                          = string
    address_prefixes                              = list(string)
    private_link_service_network_policies_enabled = optional(bool, true)
    service_endpoints                             = optional(list(string), [])
    delegations                                   = optional(list(object({
      name    = string
      service = string
      actions = optional(list(string))
    })), [])
  }))
  default = [
    {
      name                                          = "AzureFirewallSubnet"
      address_prefixes                              = ["10.0.0.0/26"]
      private_link_service_network_policies_enabled = false
      service_endpoints                             = []
      delegations                                   = []
    },
    {
      name                                          = "AzureBastionSubnet"
      address_prefixes                              = ["10.0.0.64/27"]
      private_link_service_network_policies_enabled = true
      service_endpoints                             = []
      delegations                                   = []
    },
    {
      name                                          = "shared"
      address_prefixes                              = ["10.0.1.0/24"]
      private_link_service_network_policies_enabled = true
      service_endpoints                             = []
      delegations                                   = []
    }
  ]
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
