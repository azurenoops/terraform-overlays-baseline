# Planning the Sentinel Deployment

## Initial considerations

The Mission Enclave Sentinel Starter Terraform module is designed to be used as a starting point for deploying Azure Sentinel onto an Mission Enclave Landing Zone. It is not intended to be used as a complete solution, but rather as a starting point that can be customized to meet specific requirements.

Before getting started with this module, please take note of the following considerations:

1. This module requires a minimum `azurerm` provider version of `> 3.36.0`.

1. This module requires a minimum Terraform version `1.3.1`.

    > **NOTE:** New releases of the module may contain features which require the minimum supported versions to be increased, but changes will be clearly documented in the release notes, user guide, and readme.

Before any deployment, you should have a clear understanding of Azure Sentinel and how it works. You should also have a clear understanding of the Azure Sentinel pricing model and how it will affect your organization.

Please review the [Azure Sentinel pricing](https://azure.microsoft.com/pricing/details/azure-sentinel/) page for more information.

## Mission Enclave Landing Zone Remote State Storage Account

The remote state storage account is used to store the Terraform state files. The state files contain the current state of the infrastructure that has been deployed. The state files are used by Terraform to determine what changes need to be made to the infrastructure when a deployment is run.

To find out more about remote state, see the [Remote State documentation](../remote-state-storage.md).

## Deployment Planning

If you want to change the default values, you can do so by editing the [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-sentinel-starter/tree/main/infrastructure/policy/tfvars/parameters.tfvars) file. The following sections describe the parameters that can be changed.

### Mission Enclave Sentinel Global Configuration

The following parameters affect the "Global Configuration". To override the defaults edit the variables file at [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-sentinel-starter/tree/main/infrastructure/policy/tfvars/parameters.tfvars).

Example Configuration:

Parameter name | Default Value | Description
-------------- | ------------- | -----------
`org_name`           | anoa          | This Prefix will be used on most deployed resources.  10 Characters max.
`environment`        | public        | The environment to deploy to.
`deploy_environment` | dev,test,prod | The environment to deploy to.
`default_location`   | eastus        | The default region to deploy to.
