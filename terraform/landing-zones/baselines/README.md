# Workload Models

Author workload intent in YAML, then render to `*.auto.tfvars.json` for workload stacks or for parameterizing baselines.

## Example fields

- `name`, `tier` (corp or online), `env`, `location`
- `connectivity` (vnet, subnets), `security` (private endpoints, defender)
- `diagnostics` (workspace id, activity logs), `rbac` (owners, contributors)
- `workload` (compute type, sku, instances, identity)

Use the samples as a starting point. A simple script converts YAML to `tfvars.json`.
