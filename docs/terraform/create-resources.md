# Create resources

Let's create an Azure Storage account using Terraform:

1. Open Visual Studio Code.

1. Create a file `versions.tf`.

1. Configure the Azure provider:

    ```terraform
    terraform {
      required_version = ">= 1.3"
      required_providers {
        azurerm = {
          source  = "hashicorp/azurerm"
          version = "~> 3.36"
        }
      }
    }

    provider "azurerm" {
      features {}
    }
    ```

<details><summary>Show `versions.tf` contents</summary>
    ```console
    terraform {
      required_version = ">= 1.3"
      required_providers {
        azurerm = {
          source  = "hashicorp/azurerm"
          version = "~> 3.36"
        }
      }
    }
    
    provider "azurerm" {
      features {}
    }
    ```
    </details>

1. Create a file `data.tf`.

1. Read the Azure resource group you created into Terraform by using a data source:

    ```terraform
    data "azurerm_resource_group" "example" {
      name = "example-rg"
    }
    ```

<details><summary>Show `data.tf` contents</summary>
    ```console
    data "azurerm_resource_group" "example" {
      name = "example-rg"
    }
    ```
    </details>

1. Create a file `variables.global.tf`.

1. Define the global variables:

    ```terraform
    variable "deploy_environment" {
      description = "The environment in which the resources will be created."
      default = "dev"
    }

    variable "org_name" {
      description = "The name of the organization."
      default = "anoa"
    }

    variable "environment" {
      description = "The environment in which the resources will be created."
      default = "public"
    }

    variable "workload_name" {
      description = "The name of the workload."
      default = "storage"
    }

    variable "location" {
      description = "The location/region where the resources will be created."
      default     = "northeurope"
    }
    ```

<details><summary>Show `variables.global.tf` contents</summary>
    ```console
    variable "deploy_environment" {
      description = "The environment in which the resources will be created."
      default = "dev"
    }

    variable "org_name" {
      description = "The name of the organization."
      default = "anoa"
    }

    variable "environment" {
      description = "The environment in which the resources will be created."
      default = "public"
    }

    variable "workload_name" {
      description = "The name of the workload."
      default = "storage"
    }

    variable "location" {
      description = "The location/region where the resources will be created."
      default     = "northeurope"
    }
    ```
    </details>

1. Create a file `variables.storage.account.tf`.

1. Define the variables for the storage account:

    ```terraform
    variable "storage_account_name" {
      description = "The name of the storage account."
      default     = "examplest"
    }

    variable "storage_account_tier" {
      description = "The storage account tier."
      default     = "Standard"
    }

    variable "storage_account_replication_type" {
      description = "The storage account replication type."
      default     = "LRS"
    }

    variable "storage_account_location" {
      description = "The location of the storage account."
      default     = "northeurope"
    }

    variable "storage_account_container_name" {
      description = "The name of the storage account container."
      default     = "example-container"
    }
    ```

<details><summary>Show `variables.storage.account.tf` contents</summary>
    ```console
    variable "storage_account_name" {
      description = "The name of the storage account."
      default     = "examplest"
    }

    variable "storage_account_tier" {
      description = "The storage account tier."
      default     = "Standard"
    }

    variable "storage_account_replication_type" {
      description = "The storage account replication type."
      default     = "LRS"
    }

    variable "storage_account_location" {
      description = "The location of the storage account."
      default     = "northeurope"
    }

    variable "storage_account_container_name" {
      description = "The name of the storage account container."
      default     = "example-container"
    }
    ```

    </details>

1. Create a file `variables.virtual.network.tf`.

1. Define the variables for the virtual network:

    ```terraform
    variable "vnet_name" {
      description = "The name of the virtual network."
      default     = "example-network"
    }

    variable "vnet_address_space" {
      description = "The address space of the virtual network."
      default     = ""
    }

    variable "subnet_name" {
      description = "The name of the subnet."
      default     = "internal"
    }

    variable "subnet_address_prefix" {
      description = "The address prefix of the subnet."
      default     = ""
    }
    ```

<details><summary>Show `variables.virtual.network.tf` contents</summary>
    ```console
    variable "vnet_name" {
      description = "The name of the virtual network."
      default     = "example-network"
    }

    variable "vnet_address_space" {
      description = "The address space of the virtual network."
      default     = ""
    }

    variable "subnet_name" {
      description = "The name of the subnet."
      default     = "internal"
    }

    variable "subnet_address_prefix" {
      description = "The address prefix of the subnet."
      default     = ""
    }
    ```

    </details>

1. Create a file `resources.virtual.network.tf`.

1. Create a vnet and subnet in the resource group:

    ```terraform
    resource "azurerm_virtual_network" "example" {
      name                = "example-network"
      location            = data.azurerm_resource_group.example.location
      resource_group_name = data.azurerm_resource_group.example.name
      address_space       = ["10.0.0.1/16"] # Replace with your address space
    }

    resource "azurerm_subnet" "example" {
      name                 = "internal"
      resource_group_name  = data.azurerm_resource_group.example.name
      virtual_network_name = azurerm_virtual_network.example.name
      address_prefixes     = ["10.0.1.1/26"] # Replace with your address prefix
    }
    ```

<details><summary>Show `resources.virtual.network.tf` contents</summary>
    ```console
    resource "azurerm_virtual_network" "example" {
      name                = "example-network"
      location            = data.azurerm_resource_group.example.location
      resource_group_name = data.azurerm_resource_group.example.name
      address_space       = ["10.0.0.1/16"] # Replace with your address space
    }

    resource "azurerm_subnet" "example" {
      name                 = "internal"
      resource_group_name  = data.azurerm_resource_group.example.name
      virtual_network_name = azurerm_virtual_network.example.name
      address_prefixes     = ["10.0.1.1/26"] # Replace with your address prefix
    }
    ```
    </details>

1. Create a file `resources.storage.account.tf`.

1. Create a random suffix for resource names using the built-in random provider, and an Azure Storage account in the resource group:

    ```terraform
    resource "random_id" "suffix" {
      byte_length = 4
    }

    resource "azurerm_storage_account" "example" {
      name                     = "examplest${random_id.suffix.hex}"
      resource_group_name      = data.azurerm_resource_group.example.name
      location                 = data.azurerm_resource_group.example.location
      account_tier             = "Standard"
      account_replication_type = "LRS"
    }
    ```

1. Create a storage container in the storage account:

    ```terraform
    resource "azurerm_storage_container" "example" {
      name                  = "example-container"
      storage_account_name  = azurerm_storage_account.example.name
      container_access_type = "private"
    }
    ```

1. Create network rules for the storage account:

    ```terraform
    resource "azurerm_storage_account_network_rules" "example" {
      resource_group_name  = data.azurerm_resource_group.example.name
      storage_account_name = azurerm_storage_account.example.name

      default_action             = "Deny"
      bypass                     = ["AzureServices"]
      virtual_network_subnet_ids = [azurerm_subnet.example.id]
    }
    ```

<details><summary>Show `resources.storage.account.tf` contents</summary>
    ```console
    resource "random_id" "suffix" {
      byte_length = 4
    }

    resource "azurerm_storage_account" "example" {
      name                     = "examplest${random_id.suffix.hex}"
      resource_group_name      = data.azurerm_resource_group.example.name
      location                 = data.azurerm_resource_group.example.location
      account_tier             = "Standard"
      account_replication_type = "LRS"
    }

    resource "azurerm_storage_container" "example" {
      name                  = "example-container"
      storage_account_name  = azurerm_storage_account.example.name
      container_access_type = "private"
    }

    resource "azurerm_storage_account_network_rules" "example" {
      resource_group_name  = data.azurerm_resource_group.example.name
      storage_account_name = azurerm_storage_account.example.name

      default_action             = "Deny"
      bypass                     = ["AzureServices"]
      virtual_network_subnet_ids = [azurerm_subnet.example.id]
    }
    ```
    </details>

1. Create a file `resources.storage.account.pe.tf`.

1. Create a private endpoint for the storage account:

    ```terraform
    resource "azurerm_private_endpoint" "example" {
      name                = "example-endpoint"
      location            = data.azurerm_resource_group.example.location
      resource_group_name = data.azurerm_resource_group.example.name

      subnet_id = azurerm_subnet.example.id

      private_service_connection {
        name                           = "example-connection"
        private_connection_resource_id = azurerm_storage_account.example.id
        is_manual_connection           = false
      }
    }

    resource "azurerm_private_dns_zone" "example" {
      name                = "privatelink.blob.core.windows.net"
      resource_group_name = data.azurerm_resource_group.example.name
    }

    resource "azurerm_private_dns_a_record" "example" {
      name                = "example-a-record"
      zone_name           = azurerm_private_dns_zone.example.name
      resource_group_name = data.azurerm_resource_group.example.name
      ttl                 = 300
      records             = [azurerm_private_endpoint.example.private_ip_address]
    }
    ```

<details><summary>Show `resources.storage.account.pe.tf` contents</summary>
    ```console
    resource "azurerm_private_endpoint" "example" {
      name                = "example-endpoint"
      location            = data.azurerm_resource_group.example.location
      resource_group_name = data.azurerm_resource_group.example.name

      subnet_id = azurerm_subnet.example.id

      private_service_connection {
        name                           = "example-connection"
        private_connection_resource_id = azurerm_storage_account.example.id
        is_manual_connection           = false
      }
    }

    resource "azurerm_private_dns_zone" "example" {
      name                = "privatelink.blob.core.windows.net"
      resource_group_name = data.azurerm_resource_group.example.name
    }

    resource "azurerm_private_dns_a_record" "example" {
      name                = "example-a-record"
      zone_name           = azurerm_private_dns_zone.example.name
      resource_group_name = data.azurerm_resource_group.example.name
      ttl                 = 300
      records             = [azurerm_private_endpoint.example.private_ip_address]
    }
    ```
    </details>

1. Create a file `resources.storage.account.cmk.tf`.

1. Create a customer managed key for the storage account:

    ```terraform
    resource "azurerm_storage_account_customer_managed_key" "example" {
      storage_account_id = azurerm_storage_account.example.id
      key_vault_key_id   = azurerm_key_vault_key.example.id
    }

    resource "azurerm_key_vault" "example" {
      name                = "example-kv"
      resource_group_name = data.azurerm_resource_group.example.name
      location            = data.azurerm_resource_group.example.location
      sku_name            = "standard"
      tenant_id           = data.azurerm_client_config.current.tenant_id
    }

    resource "azurerm_key_vault_key" "example" {
      name         = "example-key"
      key_vault_id = azurerm_key_vault.example.id
      key_type     = "RSA"
      key_size     = 2048
    }

    resource "azurerm_key_vault_access_policy" "example" {
      key_vault_id = azurerm_key_vault.example.id
      tenant_id    = data.azurerm_client_config.current.tenant_id

      certificate_permissions = ["get", "list"]
      key_permissions         = ["get", "list"]
      secret_permissions      = ["get", "list"]
      storage_permissions     = ["get", "list"]
    }
    ```

    <details><summary>Show `resources.storage.account.cmk.tf` contents</summary>

    ```console
    resource "azurerm_storage_account_customer_managed_key" "example" {
      storage_account_id = azurerm_storage_account.example.id
      key_vault_key_id   = azurerm_key_vault_key.example.id
    }

    resource "azurerm_key_vault" "example" {
      name                = "example-kv"
      resource_group_name = data.azurerm_resource_group.example.name
      location            = data.azurerm_resource_group.example.location
      sku_name            = "standard"
      tenant_id           = data.azurerm_client_config.current.tenant_id
    }

    resource "azurerm_key_vault_key" "example" {
      name         = "example-key"
      key_vault_id = azurerm_key_vault.example.id
      key_type     = "RSA"
      key_size     = 2048
    }

    resource "azurerm_key_vault_access_policy" "example" {
      key_vault_id = azurerm_key_vault.example.id
      tenant_id    = data.azurerm_client_config.current.tenant_id

      certificate_permissions = ["get", "list"]
      key_permissions         = ["get", "list"]
      secret_permissions      = ["get", "list"]
      storage_permissions     = ["get", "list"]
    }
    ```

    </details>

1. Initialize your Terraform configuration to install all required provider plugins:

    ```console
    terraform init
    ```

    Two files will be automatically created:

    | Name | Description |
    | --- | --- |
    | `.terraform` | A directory containing installed provider plugins |
    | `.terraform.lock.hcl` | A file containing a record of installed provider plugins |

1. Validate your Terraform configuration to check for errors such as non-existent references:

    ```console
    terraform validate
    ```

1. Generate an execution plan and store it in a file `tfplan`:

    ```console
    terraform plan -out=tfplan
    ```

    A single file will be automatically created:

    | Name | Description |
    | --- | --- |
    | `tfplan` | A file containing the generated execution plan |

    <details><summary>Show execution plan</summary>

    ```console
    $ terraform show tfplan

    Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
      + create

    Terraform will perform the following actions:

      # azurerm_storage_account.example will be created
      + resource "azurerm_storage_account" "example" {
          + access_tier                       = (known after apply)
          + account_kind                      = "StorageV2"
          + account_replication_type          = "LRS"
          + account_tier                      = "Standard"
          + allow_nested_items_to_be_public   = true
          + cross_tenant_replication_enabled  = true
          + default_to_oauth_authentication   = false
          + enable_https_traffic_only         = true
          + id                                = (known after apply)
          + infrastructure_encryption_enabled = false
          + is_hns_enabled                    = false
          + large_file_share_enabled          = (known after apply)
          + location                          = "northeurope"
          + min_tls_version                   = "TLS1_2"
          + name                              = (known after apply)
          + nfsv3_enabled                     = false
          + primary_access_key                = (sensitive value)
          + primary_blob_connection_string    = (sensitive value)
          + primary_blob_endpoint             = (known after apply)
          + primary_blob_host                 = (known after apply)
          + primary_connection_string         = (sensitive value)
          + primary_dfs_endpoint              = (known after apply)
          + primary_dfs_host                  = (known after apply)
          + primary_file_endpoint             = (known after apply)
          + primary_file_host                 = (known after apply)
          + primary_location                  = (known after apply)
          + primary_queue_endpoint            = (known after apply)
          + primary_queue_host                = (known after apply)
          + primary_table_endpoint            = (known after apply)
          + primary_table_host                = (known after apply)
          + primary_web_endpoint              = (known after apply)
          + primary_web_host                  = (known after apply)
          + public_network_access_enabled     = true
          + queue_encryption_key_type         = "Service"
          + resource_group_name               = "example-rg"
          + secondary_access_key              = (sensitive value)
          + secondary_blob_connection_string  = (sensitive value)
          + secondary_blob_endpoint           = (known after apply)
          + secondary_blob_host               = (known after apply)
          + secondary_connection_string       = (sensitive value)
          + secondary_dfs_endpoint            = (known after apply)
          + secondary_dfs_host                = (known after apply)
          + secondary_file_endpoint           = (known after apply)
          + secondary_file_host               = (known after apply)
          + secondary_location                = (known after apply)
          + secondary_queue_endpoint          = (known after apply)
          + secondary_queue_host              = (known after apply)
          + secondary_table_endpoint          = (known after apply)
          + secondary_table_host              = (known after apply)
          + secondary_web_endpoint            = (known after apply)
          + secondary_web_host                = (known after apply)
          + sftp_enabled                      = false
          + shared_access_key_enabled         = true
          + table_encryption_key_type         = "Service"
        }

      # random_id.suffix will be created
      + resource "random_id" "suffix" {
          + b64_std     = (known after apply)
          + b64_url     = (known after apply)
          + byte_length = 8
          + dec         = (known after apply)
          + hex         = (known after apply)
          + id          = (known after apply)
        }

    Plan: 2 to add, 0 to change, 0 to destroy.
    ```

    </details>

1. Run the execution plan:

    ```console
    terraform apply tfplan
    ```

    This will create the resources shown in the execution plan.

    A single file will be automatically created:

    | Name | Description |
    | --- | --- |
    | `terraform.tfstate` | A file containing the last known configuration (state) of your infrastructure |

    Feel free to have a quick look at the state file.
    Notice how the state file keeps track of the configuration of all read data sources and created resources.
    You must never modify the state file manually; all changes should go through Terraform.

1. Verify that the Storage account has been created in the resource group:

    ```console
    $ az resource list -g example-rg -o table
    Name               ResourceGroup    Location     Type                               Status
    -----------------  ---------------  -----------  ---------------------------------  --------
    examplestd64f295a  example-rg       northeurope  Microsoft.Storage/storageAccounts
    ```

    > It might take a few minutes before the Storage account appears in the output.

Congrats, you've created your first resource using Terraform!

As mentioned earlier, Terraform not only allows you to create new resources, but to effectively manage its entire lifecycle.

Next, we'll make an update to the Storage account configuration, before we tear it all down again!
