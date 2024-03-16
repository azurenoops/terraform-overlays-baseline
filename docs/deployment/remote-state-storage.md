# Setting up Terraform State Storage Account in Azure

This guide will walk you through the process of setting up a storage account in Azure to be used as a backend for Terraform state storage.

> **Note**: This guide assumes you have an Azure subscription and the Azure CLI installed.

> **Important**: While you can use this guide to set up a storage account for Terraform state storage, all Mission Enclave Starters have a dependency workflow that sets up the storage account for you. This guide is intended for those who want to set up the storage account manually or for those who want to understand the process.

## Prerequisites

- Azure subscription
- Azure CLI installed

## Steps

1. Login to Azure CLI by running the following command:
    ```
    az login
    ```

2. Create a resource group for the state storage account:
    ```
    az group create --name <resource-group-name> --location <location>
    ```

3. Create a storage account:
    ```
    az storage account create --name <storage-account-name> --resource-group <resource-group-name> --location <location> --sku Standard_LRS
    ```

4. Retrieve the storage account key:
    ```
    az storage account keys list --account-name <storage-account-name> --resource-group <resource-group-name> --query "[0].value" --output tsv
    ```

5. Create a container within the storage account:
    ```
    az storage container create --name <container-name> --account-name <storage-account-name> --account-key <storage-account-key>
    ```

6. Configure Terraform to use the Azure backend:
    ```hcl
    terraform {
      backend "azurerm" {
         storage_account_name = "<storage-account-name>"
         container_name       = "<container-name>"
         key                  = "terraform.tfstate"
         access_key           = "<storage-account-key>"
      }
    }
    ```

7. Initialize Terraform:
    ```
    terraform init
    ```

8. Run Terraform commands as usual:
    ```
    terraform plan
    terraform apply
    ```

