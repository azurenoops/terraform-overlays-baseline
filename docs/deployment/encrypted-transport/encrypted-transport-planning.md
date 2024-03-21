# Planning

## Initial considerations

The Encrypted Transport for SCCA-Compliant Enclave Reference Add-on Starter Terraform module is designed to be used as a starting point for deploying VPN services to an existing SCCA-compliant enclave. This starter is not intended to be used as a standalone VPN solution as it requires an SCCA-compliant Hub (VNet, Firewall, & Log Analytics Workspace) to be deployed first so that it can peer to the Hub virtual network and push logs to the Log Analytics Workspace.

Before getting started with this module, please take note of the following considerations:

1. This module requires a minimum `azurerm` provider version of `> 3.36.0`.

1. This module requires a minimum Terraform version `1.3.1`.

    > **NOTE:** New releases of the module may contain features which require the minimum supported versions to be increased, but changes will be clearly documented in the release notes, user guide, and readme.

## Mission Enclave Landing Zone Remote State Storage Account

The remote state storage account is used to store the Terraform state files. The state files contain the current state of the infrastructure that has been deployed. The state files are used by Terraform to determine what changes need to be made to the infrastructure when a deployment is run.

To find out more about remote state, see the [Remote State documentation](./remote-state-storage.md).

## Deployment Planning