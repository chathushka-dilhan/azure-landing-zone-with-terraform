/**
 * Root: 30-connectivity
 * Purpose: Deploy either Virtual WAN or Hub VNet, plus Firewall, Bastion, and PDR.
 */

terraform {
  required_version = ">= 1.5.0"
}

locals {
  hub_vnet_enabled = var.deploy_vwan == false
}

# vWAN (optional)
module "vwan" {
  count               = var.deploy_vwan ? 1 : 0
  source              = "../../modules/network/vwan"
  name                = var.vwan.name
  resource_group_name = var.resource_group_name
  location            = var.location
  vwan_type           = try(var.vwan.type, "Standard")
  allow_branch_to_branch = try(var.vwan.allow_branch_to_branch, true)
  office365_breakout_category = try(var.vwan.office365_breakout, "Optimize")
  disable_vpn_encryption      = try(var.vwan.disable_vpn_encryption, false)
  tags                 = try(var.vwan.tags, {})
}

# Hub VNet (default)
module "hub_vnet" {
  count               = local.hub_vnet_enabled ? 1 : 0
  source              = "../../modules/network/hub_vnet"
  name                = var.hub_vnet.name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.hub_vnet.address_space
  ddos_plan_id        = try(var.hub_vnet.ddos_plan_id, "")
  subnets             = try(var.hub_vnet.subnets, [])
  tags                = try(var.hub_vnet.tags, {})
}

# Firewall
module "firewall" {
  count               = var.firewall.enabled && local.hub_vnet_enabled ? 1 : 0
  source              = "../../modules/network/firewall"
  name                = var.firewall.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tier                = try(var.firewall.tier, "Premium")
  vnet_id             = module.hub_vnet[0].vnet_id
  public_ip_name      = var.firewall.public_ip_name
  firewall_policy_id  = try(var.firewall.firewall_policy_id, "")
  tags                = try(var.firewall.tags, {})
}

# Bastion
module "bastion" {
  count               = var.bastion.enabled && local.hub_vnet_enabled ? 1 : 0
  source              = "../../modules/network/bastion"
  name                = var.bastion.name
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_id             = module.hub_vnet[0].vnet_id
  public_ip_name      = var.bastion.public_ip_name
  sku                 = try(var.bastion.sku, "Standard")
  scale_units         = try(var.bastion.scale_units, 2)
  tags                = try(var.bastion.tags, {})
}

# Private DNS Resolver
module "pdr" {
  count               = var.pdr.enabled && local.hub_vnet_enabled ? 1 : 0
  source              = "../../modules/network/private_dns_resolver"
  name                = var.pdr.name
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_id             = module.hub_vnet[0].vnet_id
  inbound_subnet_name = try(var.pdr.inbound_subnet_name, "snet-dns-inbound")
  outbound_subnet_name= try(var.pdr.outbound_subnet_name, "snet-dns-outbound")
  tags                = try(var.pdr.tags, {})
}
