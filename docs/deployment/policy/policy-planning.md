# Planning the Landing Zone Policy

## Initial considerations

The Mission Enclave Policy Starter Terraform module is designed to be used as a starting point for deploying Azure Policy onto an Mission Enclave Landing Zone. It is not intended to be used as a complete solution, but rather as a starting point that can be customized to meet specific requirements.

Before getting started with this module, please take note of the following considerations:

1. This module requires a minimum `azurerm` provider version of `> 3.36.0`.

1. This module requires a minimum Terraform version `1.3.1`.

    > **NOTE:** New releases of the module may contain features which require the minimum supported versions to be increased, but changes will be clearly documented in the release notes, user guide, and readme.

## Mission Enclave Landing Zone Remote State Storage Account

The remote state storage account is used to store the Terraform state files. The state files contain the current state of the infrastructure that has been deployed. The state files are used by Terraform to determine what changes need to be made to the infrastructure when a deployment is run.

To find out more about remote state, see the [Remote State documentation](./remote-state-storage.md).

## Deployment Planning

If you want to change the default values, you can do so by editing the [parameters.tfvars](https://github.com/AzureNoOps/ref-scca-enclave-landing-zone-starter/infrastructure/terraform/tfvars/parameters.tfvars) file. The following sections describe the parameters that can be changed.

### Mission Enclave Policy Global Configuration

The following parameters affect the "01 Global Configuration". To override the defaults edit the variables file at [parameters.tfvars](../policy/terraform/tfvars/parameters.tfvars).

Example Configuration:

Parameter name | Default Value | Description
-------------- | ------------- | -----------
`org_name`       | anoa          | This Prefix will be used on most deployed resources.  10 Characters max.
`environment` | public | The environment to deploy to.
`default_location` | eastus | The default region to deploy to.

### Mission Enclave Policy Configuration

The following parameters affect the "02 Policy Configuration". To override the defaults edit the variables file at [parameters.tfvars](../policy/terraform/tfvars/parameters.tfvars).

Example Configuration:

Parameter name | Default Value | Description
-------------- | ------------- | -----------