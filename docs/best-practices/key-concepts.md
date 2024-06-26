# Azure NoOps Terraform Key concepts

The official Terraform documentation describes all aspects of [terraform configuration](https://www.terraform.io/docs/configuration/index.html) in details. Read it carefully to understand the rest of this section.

## Resource

A Resource is an instantiation of an Azure resource such as a azurerm_storage_account, azurerm_virtual_machine, etc. A resource belongs to a provider such as [AzureRM](https://registry.terraform.io/providers/hashicorp/azurerm/latest), accepts arguments, outputs attributes, and has a lifecycle. A resource can be created, retrieved, updated, and deleted.

## Resource module (aka Overlay Module)

A Resource Module which is commonly called an `Overlay` in the Azure NoOps ecosystem is a collection of connected resources which together perform a common action (For example, [Azure NoOps Storage Account Terraform Overlays Module](https://github.com/azurenoops/terraform-azurerm-overlays-storage-account) creates Storage Account, blobs, tables, etc). It depends on provider configuration, which can be defined in it, or in higher-level structures (e.g. in infrastructure module).

## Infrastructure module

An Infrastructure Module is a collection of resources and/or resource modules, which can be logically connected. It defines the configuration for providers, which is passed to the downstream resource modules and to resources. It is normally limited to work in one entity per logical separator (e.g., Azure Region, Key Vault).

Infrastructure module can include multiple Overlay Modules, provider resources, and data sources. While an "`Overlay`" is not necessarily an "Infrastructure module", an infrastructure module can include multiple Overlay Modules, which in turn can be called an `Overlay`. Basically anything that can be used to create a resource or a resource module can be included in an `Overlay`.

For example, [terraform-azurerm-overlays-management-hub](https://github.com/azurenoops/terraform-azurerm-overlays-management-hub) overlay module includes provider resources like [azurerm_virtual_network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network), [azurerm_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet), and includes resource modules(`Overlay` modules)[terraform-azurerm-overlays-storage-account](https://github.com/azurenoops/terraform-azurerm-overlays-storage-account),[terraform-azurerm-overlays-management-logging](https://github.com/azurenoops/terraform-azurerm-overlays-management-logging) to manage the infrastructure required for running [Landing Zone Management Hub](https://github.com/azurenoops/terraform-azurerm-overlays-management-hub) on Azure NoOps Mission Enclave.

## Composition

A Composition is a collection of infrastructure modules(`Overlays`), which can span across several logically separated areas (e.g. Azure Regions, several Azure accounts). A Composition is used to describe the complete infrastructure required for the whole organization or project.

A Composition consists of infrastructure modules, which consist of resources modules, which implement individual resources. For example, the [Mission Enclave Landing Zone Starter](https://github.com/azurenoops/ref-scca-enclave-landing-zone-starter) is a composition that consists of the [Landing Zone Management Hub](https://github.com/azurenoops/terraform-azurerm-overlays-management-hub) and [Landing Zone Management Spoke](https://github.com/azurenoops/terraform-azurerm-overlays-management-spoke) infrastructure modules.

## Data Source

A Data Source performs a read-only operation and is dependant on provider configuration. It is used in a Resource Module and an Infrastructure Module.

A Data Source terraform_remote_state acts as a glue for higher-level modules and compositions.

The [external data source](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) allows an external program to act as a data source, exposing arbitrary data for use elsewhere in the Terraform configuration. Here is an example from the [Azure NoOps Virtual Machine Overlay Module]() module where the virtual machine is built by calling an bash script.

The [http data source](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) makes an HTTP GET request to the given URL and exports information about the response which is often useful to get information from endpoints where a native Terraform provider does not exist.

## Remote State

Infrastructure Modules and Compositions should persist their [Terraform State](https://www.terraform.io/docs/language/state/index.html) in a remote location where it can be retrieved by others in a controllable way (e.g. specify ACL, versioning, logging).

## Provider, provisioner, etc

Providers, provisioners, and a few other terms are described very well in the official documentation. Azure NoOPs uses the [AzureRM](https://registry.terraform.io/providers/hashicorp/azurerm/latest).

## Putting it all together

Think of individual resources like atoms in the infrastructure, Resource Modules are molecules (consisting of atoms). A Module is the smallest versioned and shareable unit. It has an exact list of arguments, implements basic logic for such a unit to do the required function. e.g. terraform-azurerm-overlays-key-vault module creates azurerm_keyvault and azurerm_keyvault_access_policy resources based on input. This resource module by itself can be used together with other modules to create the infrastructure module.

Access to data across molecules (Resource Modules and Infrastructure Modules) is performed using the modules' outputs and data sources.

Access between compositions is often performed using remote state data sources. There are multiple ways to share data between configurations.

The following diagram shows how the different concepts are connected:

```bash
composition-1 (Mission Enclave Landing Zone Starter) {
  infrastructure-module-1 (Landing Zone Management Hub) {
    data-source-1 (Lookup for Resource Group) => d1

    resource-module-1 (terraform-azurerm-overlays-storage-account) (Storage Account, blobs, tables, etc) {
      data-source-2 => d2
      resource-1 (azurerm_storage_account, d2)
      resource-2 (azurerm_storage_container, d2)
    }

    resource-module-2 (terraform-azurerm-overlays-logging) (Log Analytics, Storage Account, etc) {
      data-source-3 => d3
      resource-3 (azurerm_log_analytics_workspace, d3)
      resource-module-4 (terraform-azurerm-overlays-storage-account)
    }

    resource-module-3 (terraform-azurerm-overlays-key-vault) (Key Vault, access policy, etc) {
      data-source-4 => d34
      resource-5 (azurerm_key_vault, d4)
      resource-6 (azurerm_key_vault_access_policy, d4)
    }
  }
}
```
