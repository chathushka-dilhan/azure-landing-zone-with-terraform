variable "management_groups" {
  description = <<EOT
Map of management groups to create. Key = mg short name, Value = object with id, display_name, parent, tags.
Example:
{
  platform     = { id = "katta-platform",     display_name = "Platform",     parent = "",                      tags = { pillar = "platform" } }
  security     = { id = "katta-security",     display_name = "Security",     parent = "katta-platform",      tags = { pillar = "security" } }
  management   = { id = "katta-management",   display_name = "Management",   parent = "katta-platform",      tags = { pillar = "management" } }
  connectivity = { id = "katta-connectivity", display_name = "Connectivity", parent = "katta-platform",      tags = { pillar = "connectivity" } }
  identity     = { id = "katta-identity",     display_name = "Identity",     parent = "katta-platform",      tags = { pillar = "identity" } }
  landingzones = { id = "katta-landingzones", display_name = "Landing Zones",parent = "katta-platform",      tags = { pillar = "lz" } }
  corp         = { id = "katta-lz-corp",      display_name = "Corp",         parent = "katta-landingzones",  tags = { lz = "corp" } }
  online       = { id = "katta-lz-online",    display_name = "Online",       parent = "katta-landingzones",  tags = { lz = "online" } }
  sandbox      = { id = "katta-sandbox",      display_name = "Sandbox",      parent = "katta-platform",      tags = { pillar = "sandbox" } }
  decom        = { id = "katta-decom",        display_name = "Decommissioned", parent = "katta-platform",    tags = { pillar = "decom" } }
}
EOT
  type = map(object({
    id           = string
    display_name = string
    parent       = string   # empty places under tenant root
    tags         = map(string)
  }))
}

variable "tags" {
  description = "Default tags applied where relevant."
  type        = map(string)
  default     = {}
}
