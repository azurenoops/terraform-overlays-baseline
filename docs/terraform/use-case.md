# Use Case

## Problem

In our project, we are using Terraform to provision and manage our infrastructure in Azure. As part of this process, we need a reliable and scalable storage solution to store the documents. We need a solution that can handle large amounts of data and provide high availability and redundancy. We also need a solution that is secure and durable, and can be easily integrated with our existing infrastructure in Azure. We need a solution that can be easily managed and maintained, and that can grow with our needs over time.

## Solution

To address this need, we have decided to use an Azure Storage Account. Azure Storage provides a secure and durable storage solution that can handle large amounts of data. With Azure Storage Account, we can store our documents in a highly available and redundant manner.

## Implementation

We will use the `azurerm_storage_account` module to create an Azure Storage Account. This module will allow us to define the configuration of the storage account, including the name, location, and redundancy options. We will also use the `azurerm_storage_container` module to create a storage container within the storage account. This module will allow us to define the configuration of the storage container, including the name and access control options. Since this is going to be put into a SCCA/Zero Trust environment, we will also use the `azurerm_storage_account_network_rules` module to define the network rules for the storage account. This module will allow us to define the configuration of the network rules, including the IP addresses and virtual network rules that are allowed to access the storage account. Since this will be in a GovCloud environment, we will also use the `azurerm_storage_account_customer_managed_key` module to define the customer managed key for the storage account. This module will allow us to define the configuration of the customer managed key, including the key vault and key name.

Lastly, we will add a private endpoint to the storage account to ensure that the storage account is only accessible from within the virtual network.
