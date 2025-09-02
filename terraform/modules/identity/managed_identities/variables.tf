variable "resource_group_name" {
  description = "Resource Group for the identities."
  type        = string
}

variable "location" {
  description = "Region for the identities."
  type        = string
}

variable "identities" {
  description = <<EOT
List of identities to create.
Example:
[
  { name = "alz-platform-deployer", tags = { managedBy = "iac" } },
  { name = "alz-policy-runner" }
]
EOT
  type = list(object({
    name = string
    tags = optional(map(string))
  }))
}

variable "tags" {
  description = "Default tags applied when per-identity tags are not provided."
  type        = map(string)
  default     = {}
}
