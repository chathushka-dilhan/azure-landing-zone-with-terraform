# Inputs for terraform/platform/00-tenant

tags = {
  env        = "dev"
  managedBy  = "terraform"
  costCenter = "0000"
}

management_groups = {
  platform = {
    id           = "katta-platform"
    display_name = "Platform"
    parent       = ""                     # empty = tenant root
    tags         = { pillar = "platform" }
  }
  security = {
    id           = "katta-security"
    display_name = "Security"
    parent       = "katta-platform"
    tags         = { pillar = "security" }
  }
  management = {
    id           = "katta-management"
    display_name = "Management"
    parent       = "katta-platform"
    tags         = { pillar = "management" }
  }
  connectivity = {
    id           = "katta-connectivity"
    display_name = "Connectivity"
    parent       = "katta-platform"
    tags         = { pillar = "connectivity" }
  }
  identity = {
    id           = "katta-identity"
    display_name = "Identity"
    parent       = "katta-platform"
    tags         = { pillar = "identity" }
  }
  landingzones = {
    id           = "katta-landingzones"
    display_name = "Landing Zones"
    parent       = "katta-platform"
    tags         = { pillar = "lz" }
  }
  corp = {
    id           = "katta-lz-corp"
    display_name = "Corp"
    parent       = "katta-landingzones"
    tags         = { lz = "corp" }
  }
  online = {
    id           = "katta-lz-online"
    display_name = "Online"
    parent       = "katta-landingzones"
    tags         = { lz = "online" }
  }
  sandbox = {
    id           = "katta-sandbox"
    display_name = "Sandbox"
    parent       = "katta-platform"
    tags         = { pillar = "sandbox" }
  }
  decom = {
    id           = "katta-decom"
    display_name = "Decommissioned"
    parent       = "katta-platform"
    tags         = { pillar = "decom" }
  }
}
