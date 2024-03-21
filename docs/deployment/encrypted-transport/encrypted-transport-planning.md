# Planning

## Initial considerations

The Mission Enclave Landing Zone Starter Terraform module is designed to be used as a starting point for deploying a landing zone. It is not intended to be used as a complete solution, but rather as a starting point that can be customized to meet specific requirements.

Before getting started with this module, please take note of the following considerations:

1. This module requires a minimum `azurerm` provider version of `> 3.36.0`.

1. This module requires a minimum Terraform version `1.3.1`.

    > **NOTE:** New releases of the module may contain features which require the minimum supported versions to be increased, but changes will be clearly documented in the release notes, user guide, and readme.

## Mission Enclave Landing Zone Remote State Storage Account

The remote state storage account is used to store the Terraform state files. The state files contain the current state of the infrastructure that has been deployed. The state files are used by Terraform to determine what changes need to be made to the infrastructure when a deployment is run.

To find out more about remote state, see the [Remote State documentation](./remote-state-storage.md).

## Deployment Planning