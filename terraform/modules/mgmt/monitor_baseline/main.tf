/**
 * Module: mgmt/monitor_baseline
 * Purpose: Data Collection Rule that forwards performance counters and syslog to Log Analytics.
 * Scope: Resource Group
 * Association to targets should be handled by Azure Policy at scale.
 */

terraform {
  required_version = ">= 1.5.0"
}

resource "azurerm_monitor_data_collection_rule" "dcr" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  description         = var.description
  tags                = var.tags

  destinations {
    log_analytics {
      name                  = "law"
      workspace_resource_id = var.workspace_id
    }
  }

  data_flow {
    streams      = ["Microsoft-Perf", "Microsoft-Syslog"]
    destinations = ["law"]
  }

  data_sources {
    performance_counter {
      name                          = "windows-perf"
      streams                       = ["Microsoft-Perf"]
      sampling_frequency_in_seconds = 60
      counter_specifiers = [
        "\\Processor(_Total)\\% Processor Time",
        "\\LogicalDisk(_Total)\\% Free Space"
      ]
    }

    syslog {
      name           = "linux-syslog"
      streams        = ["Microsoft-Syslog"]
      facility_names = ["auth", "authpriv", "daemon", "kern", "syslog"]
      log_levels     = ["Error", "Critical", "Alert", "Emergency"]
    }
  }
}
