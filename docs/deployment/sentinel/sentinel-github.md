# Deploy a Mission Enclave Sentinel Starter using GitHub Actions

This document provides guidance on how to deploy a [Mission Enclave Sentinel starter](https://github.com/azurenoops/ref-scca-enclave-sentinel-starter) using GitHub Actions.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- **Azure Subscription**: You need an Azure subscription to create resources in Azure. If you don't have one, you can create a [free account](https://azure.microsoft.com/free/).

- **Azure CLI or Azure PowerShell**: You need either Azure CLI or Azure PowerShell installed and configured to interact with your Azure account. You can download them from [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) and [here](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps) respectively.

- **Terraform**: You will need Terraform installed to deploy the infrastructure. You can download Terraform from [here](https://www.terraform.io/downloads.html).

- **Knowledge of Azure Landing Zones**: This project involves deploying and managing Azure Landing Zones resources. Familiarity with Azure Landing Zones and its concepts is recommended.

- **Knowledge of Azure Sentinel**: This project involves deploying and managing Azure Sentinel resources. Familiarity with Azure Sentinel and its concepts is recommended.

- **GitHub Actions**: You need to have a GitHub account and a repository to deploy the Mission Enclave Landing Zone.

Please replace the links and the software versions with the ones that are relevant to your project.

## GitHub Deployment

To deploy the Mission Enclave Sentinel Starter, we'll setup a GitHub Actions CI/CD workflow that will build and deploy our application whenever we push new commits to the main branch of our repository.
