// Simple Terratest to init and plan one root stack with backend disabled.
// Run with: go test ./tests/terratest -v
// Prereqs: Go 1.20+, Terratest module, Azure auth in environment, or use -backend=false.

package terratest

import (
	"path/filepath"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestTenantStackPlan(t *testing.T) {
	t.Parallel()

	rootRel := filepath.FromSlash("../../terraform/platform/00-tenant")

	tfOptions := &terraform.Options{
		TerraformDir: rootRel,
		NoColor:      true,
		VarFiles:     []string{"../../../environments/dev/platform.tfvars"},
		BackendConfig: map[string]interface{}{},
		Reconfigure:    true,
	}

	// Disable remote backend for CI dry runs
	terraform.InitE(t, tfOptions, terraform.WithBackendConfig("backend", "local"))
	// Use validate to catch basic issues without contacting Azure
	terraform.RunTerraformCommand(t, tfOptions, terraform.FormatArgs(tfOptions, "validate")...)

	// Plan with -input=false -lock=false -refresh=false for speed
	planOut := terraform.InitAndPlanAndShowWithStructNoLogTempPlanFile(t, tfOptions)
	if planOut.RawPlan == nil {
		t.Fatalf("Plan output was nil")
	}
}
