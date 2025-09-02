# Inputs for terraform/platform/30-connectivity

resource_group_name = "rg-connectivity-dev"
location            = "southeastasia"

# Use hub VNet in dev. Set true to deploy vWAN instead.
deploy_vwan = false

hub_vnet = {
  name          = "vnet-hub-dev"
  address_space = ["10.100.0.0/16"]
  ddos_plan_id  = "" # set if using DDoS Network Protection

  subnets = [
    {
      name                                          = "AzureFirewallSubnet"
      address_prefixes                              = ["10.100.0.0/26"]
      private_endpoint_network_policies_enabled     = true
      private_link_service_network_policies_enabled = false
    },
    {
      name                                          = "AzureBastionSubnet"
      address_prefixes                              = ["10.100.0.64/27"]
    },
    {
      name                                          = "shared"
      address_prefixes                              = ["10.100.1.0/24"]
    },
    {
      name                                          = "snet-dns-inbound"
      address_prefixes                              = ["10.100.2.0/28"]
    },
    {
      name                                          = "snet-dns-outbound"
      address_prefixes                              = ["10.100.2.16/28"]
    }
  ]

  tags = {
    env = "dev"
  }
}

firewall = {
  enabled         = true
  name            = "afw-hub-dev"
  public_ip_name  = "pip-afw-hub-dev"
  firewall_policy_id = ""   # set if you manage AFW policy separately
  tier            = "Premium"
  tags = {
    env = "dev"
  }
}

bastion = {
  enabled        = true
  name           = "bas-hub-dev"
  public_ip_name = "pip-bas-hub-dev"
  sku            = "Standard"
  scale_units    = 2
  tags = {
    env = "dev"
  }
}

pdr = {
  enabled             = true
  name                = "pdr-hub-dev"
  inbound_subnet_name = "snet-dns-inbound"
  outbound_subnet_name= "snet-dns-outbound"
  tags = {
    env = "dev"
  }
}

# vWAN block example if you switch deploy_vwan = true
vwan = {
  name                 = "vwan-hub-dev"
  type                 = "Standard"
  allow_branch_to_branch= true
  office365_breakout   = "Optimize"
  disable_vpn_encryption = false
  tags = {
    env = "dev"
  }
}
