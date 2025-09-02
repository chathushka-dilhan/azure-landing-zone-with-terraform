# Inputs for terraform/platform/50-security

resource_group_name = "rg-sec-dev"
location            = "southeastasia"

sentinel = {
  create_workspace  = true
  workspace_name    = "law-sec-dev"
  workspace_sku     = "PerGB2018"
  retention_in_days = 30
  daily_quota_gb    = 0
  tags = {
    env = "dev"
  }
  # If reusing an existing LAW, set create_workspace = false and workspace_id here.
  # workspace_id = "/subscriptions/<sub>/resourceGroups/rg-sec-dev/providers/Microsoft.OperationalInsights/workspaces/law-sec-dev"
}

defender = {
  auto_provisioning_on         = true
  contact_email                = "security@contoso.com"
  contact_phone                = ""
  alert_notifications          = true
  alerts_to_subscription_owners= false
  plans = {
    VirtualMachines               = "Standard"
    AppServices                   = "Standard"
    SqlServers                    = "Standard"
    SqlServerVirtualMachines      = "Standard"
    StorageAccounts               = "Standard"
    KubernetesService             = "Standard"
    ContainerRegistry             = "Standard"
    KeyVaults                     = "Standard"
    Dns                           = "Standard"
    Arm                           = "Standard"
    OpenSourceRelationalDatabases = "Standard"
  }
}

platform_key_vault = {
  name                          = "kv-platform-dev"
  tenant_id                     = "<your-tenant-guid>"
  public_network_access_enabled = true
  firewall_default_action       = "Allow"
  firewall_bypass               = "AzureServices"
  firewall_ip_rules             = []
  firewall_vnet_subnet_ids      = []
  soft_delete_retention_days    = 90
  tags = {
    env = "dev"
  }
}
