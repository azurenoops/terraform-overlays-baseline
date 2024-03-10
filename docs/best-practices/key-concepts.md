# Azure NoOps Terraform Key concepts

The official Terraform documentation describes all aspects of [terraform configuration](https://www.terraform.io/docs/configuration/index.html) in details. Read it carefully to understand the rest of this section.

## Resource

Resource is azurerm_storage, azurerm_virtual_machine, etc. A resource belongs to a provider, accepts arguments, outputs attributes, and has a lifecycle. A resource can be created, retrieved, updated, and deleted.

## Resource module

Resource module is a collection of connected resources which together perform the common action (for e.g., [Azure NoOps Storage Account Terraform overlays module](https://github.com/azurenoops/terraform-azurerm-overlays-storage-account) creates Storage Account, blobs, tables, etc). It depends on provider configuration, which can be defined in it, or in higher-level structures (e.g., in infrastructure module).

## Infrastructure module

An infrastructure module is a collection of resource modules, which can be logically not connected, but in the current situation/project/setup serves the same purpose. It defines the configuration for providers, which is passed to the downstream resource modules and to resources. It is normally limited to work in one entity per logical separator (e.g., Azrue Region, Key Vault).

For example, terraform-azurerm-overlays-management-hub module uses resource modules like terraform-azurerm-overlays-storage-account and terraform-azurerm-overlays-dns to manage the infrastructure required for running Managment Hub on Azure NoOps Mission Enclave.

## Composition

Composition is a collection of infrastructure modules, which can span across several logically separated areas (e.g.., Azure Regions, several Azure accounts). Composition is used to describe the complete infrastructure required for the whole organization or project.

A composition consists of infrastructure modules, which consist of resources modules, which implement individual resources.

## Data source

Data source performs a read-only operation and is dependant on provider configuration, it is used in a resource module and an infrastructure module.

Data source terraform_remote_state acts as a glue for higher-level modules and compositions.

The [external data source](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) allows an external program to act as a data source, exposing arbitrary data for use elsewhere in the Terraform configuration. Here is an example from the [Azure NoOps Virtual Machine overlay module]() module where the virtual machine is built by calling an bash script.

The [http data source](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) makes an HTTP GET request to the given URL and exports information about the response which is often useful to get information from endpoints where a native Terraform provider does not exist.

## Remote state

Infrastructure modules and compositions should persist their [Terraform state](https://www.terraform.io/docs/language/state/index.html) in a remote location where it can be retrieved by others in a controllable way (e.g., specify ACL, versioning, logging).

## Provider, provisioner, etc

Providers, provisioners, and a few other terms are described very well in the official documentation and there is no point to repeat it here.

## Putting it all together

Think of individual resources are like atoms in the infrastructure, resource modules are molecules (consisting of atoms). A module is the smallest versioned and shareable unit. It has an exact list of arguments, implement basic logic for such a unit to do the required function. e.g., terraform-azurerm-overlays-key-vault module creates azurerm_keyvault and azurerm_keyvault_access_policy resources based on input. This resource module by itself can be used together with other modules to create the infrastructure module.

Access to data across molecules (resource modules and infrastructure modules) is performed using the modules' outputs and data sources.

Access between compositions is often performed using remote state data sources. There are multiple ways to share data between configurations.

The following diagram shows how the different concepts are connected:

```bash
composition-1 (Mission Enclave Landing Zone Starter) {
  infrastructure-module-1 (Landing Zone Management Hub) {
    data-source-1 (Lookup for Resource Group) => d1

    resource-module-1 (terraform-azurerm-overlays-storage-account) (Storage Account, blobs, tables, etc) {
      data-source-2 => d2
      resource-1 (azurerm_storage_account, d2)
      resource-2 (d2)
    }

    resource-module-2 (terraform-azurerm-overlays-DNS) (DNS zone, records, etc) {
      data-source-3 => d3
      resource-3 (d2, d3)
      resource-4 (d3)
    }

    resource-module-3 (terraform-azurerm-overlays-key-vault) (Key Vault, access policy, etc) {
      data-source-4 => d34
      resource-5 (d3, d4)
      resource-6 (d4)
    }
  }
}
```