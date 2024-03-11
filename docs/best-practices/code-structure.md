# Code Structure

Getting started with the structuring of Terraform configurations can be a bit daunting. This guide will help you understand the basic concepts and best practices for structuring your Terraform configurations used with Azure NoOps.

## Terraform configurations

In Azure NoOps overlay modules, the Terraform configurations are structured in the following way:

resources.`azure_resource`.tf - contains the resources that are created in the module and the configuration of those resources. Example: resources.key.vault.tf

modules.`azure_resource`.tf - contains the NoOps modules that are used in the module. Example: modules.key.vault.tf which is the [Key Vault module](https://github.com/azurenoops/terraform-azurerm-overlays-key-vault).

variables.`azure_resource`.tf - contains declarations of variables used in resources.tf

outputs.tf - contains outputs from the resources created in resources.tf

versions.tf - contains version requirements for Terraform and providers

parameters.tfvars should not be used anywhere except composition.

## Common recommendations for structuring code

The following are some common recommendations for structuring your Terraform configurations:

- Use a consistent directory structure

- Use a consistent naming convention

- Use a consistent file naming convention

- Use a consistent code style

- Use a consistent way of defining variables, outputs, and locals

- Use a consistent way of defining resources

- Use a consistent way of defining data sources

## Code examples of directory structure

## Directory structure

The directory structure of a Terraform configuration should be consistent across all configurations. This makes it easier to understand and navigate the configuration.

```bash
.
├── modules.storage.account.tf
├── outputs.tf
├── versions.tf
├── parameters.tfvars
├── resources.key.vault.tf
├── variables.key.vault.tf
```
