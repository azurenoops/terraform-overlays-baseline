# Terraform Key concepts

The official Terraform documentation describes all aspects of [terraform configuration](https://www.terraform.io/docs/configuration/index.html) in details. Read it carefully to understand the rest of this section.

## Resource

Resource is azurerm_storage, azurerm_virtual_machine, etc. A resource belongs to a provider, accepts arguments, outputs attributes, and has a lifecycle. A resource can be created, retrieved, updated, and deleted.

## Resource module

Resource module is a collection of connected resources which together perform the common action (for e.g., [Azure NoOps Storage Account Terraform overlays module](https://github.com/azurenoops/terraform-azurerm-overlays-storage-account) creates Storage Account, blobs, tables, etc). It depends on provider configuration, which can be defined in it, or in higher-level structures (e.g., in infrastructure module).

## Infrastructure module

An infrastructure module is a collection of resource modules, which can be logically not connected, but in the current situation/project/setup serves the same purpose. It defines the configuration for providers, which is passed to the downstream resource modules and to resources. It is normally limited to work in one entity per logical separator (e.g., Azrue Region, Key Vault).

For example, terraform-azurerm-overlays-management-hub module uses resource modules like terraform-azurerm-overlays-storage-account and terraform-azurerm-overlays-dns to manage the infrastructure required for running Managment Hub on Azure NoOps Mission Enclave.

