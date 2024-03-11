# Deploy a Mission Enclave Landing Zone using GitHub Actions

This document provides guidance on how to deploy a [Mission Enclave Landing Zone starter](https://github.com/azurenoops/ref-scca-enclave-landing-zone-starter).

## Prerequisites

Before you begin, ensure you have met the following requirements:

- **Azure Subscription**: You need an Azure subscription to create resources in Azure. If you don't have one, you can create a [free account](https://azure.microsoft.com/free/).

- **Azure CLI or Azure PowerShell**: You need either Azure CLI or Azure PowerShell installed and configured to interact with your Azure account. You can download them from [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) and [here](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps) respectively.

- **Terraform**: You will need Terraform installed to deploy the infrastructure. You can download Terraform from [here](https://www.terraform.io/downloads.html).

- **Knowledge of Azure Landing Zones**: This project involves deploying and managing Azure Landing Zones resources. Familiarity with Azure Landing Zones and its concepts is recommended.

- **GitHub Actions**: You need to have a GitHub account and a repository to deploy the Mission Enclave Landing Zone.

Please replace the links and the software versions with the ones that are relevant to your project.

## GitHub Deployment

To deploy the Mission Enclave Landing Zone, we'll setup a GitHub Actions CI/CD workflow that will build and deploy our application whenever we push new commits to the main branch of our repository.

## What's CI/CD?

CI/CD stands for _Continuous Integration_ and _Continuous Delivery_.

Continuous Integration is a software development practice that requires developers to integrate code into a shared repository several times a day.
Each integration can then be verified by an automated build and automated tests.
By doing so, you can detect errors quickly, and locate them more easily.

Continuous Delivery pushes this practice further, by preparing for a release to production after each successful build.
By doing so, you can get working software into the hands of users faster.

## What's GitHub Actions?

[GitHub Actions](https://github.com/features/actions) is a service that lets you automate your software development workflows.
It allows you to run workflows that can be triggered by any event on the GitHub platform, such as opening a pull request or pushing a commit to a repository.

It's a great way to automate your CI/CD pipelines, and it's free for public repositories.

## Configure remote state storage account

Before you use Azure Storage as a backend for the state file, you must create a storage account.

Reference the [Remote State Storage](./remote-state-storage.md) directory for the Terraform configuration to create the storage account and container.

### Using GitHub Dependencies Action

Run the following action [deploy_dependencies.yml](https://github.com/azurenoops/ref-scca-enclave-landing-zone-starter/.github/workflows/deploy_dependencies.yml) to create the storage account and container.

## Setting Up GitHub Actions for deployment

To set up GitHub Actions for deployment, we'll need to use the new workflow file in our repository.
This file will contain the instructions for our CI/CD pipeline.

## Creating an Azure Service Principal

In order to deploy our Mission Enclave Landing Zone, we'll need to create an Azure Service Principal.
This is an identity that can be used to authenticate to Azure, and that can be granted access to specific resources.

To create a new Service Principal, run the following commands:

```bash
    SUBSCRIPTION_ID=$(
      az account show \
        --query id \
        --output tsv \
        --only-show-errors
    )

    AZURE_CREDENTIALS=$(
      MSYS_NO_PATHCONV=1 az ad sp create-for-rbac \
        --name="sp-${PROJECT}-${UNIQUE_IDENTIFIER}" \
        --role="owner" \
        --scopes="/subscriptions/$SUBSCRIPTION_ID" \
        --sdk-auth \
        --only-show-errors
    )

    echo $AZURE_CREDENTIALS
    echo $SUBSCRIPTION_ID     
```

Use this service principal to set up the following secrets in your GitHub repository:

- `AZURE_CREDENTIALS`: The JSON output of the `az ad sp create-for-rbac` command.
- `AZURE_SUBSCRIPTION_ID`: The subscription ID of your Azure subscription.

## Setup secrets

We are using different secrets in our workflow: Secrets in GitHub are encrypted and allow you to store sensitive information such as passwords or API keys, and use them in your workflows using the ${{ secrets.MY_SECRET }} syntax.

In GitHub, secrets can be defined at three different levels:

- Repository level: secrets defined at the repository level are available in all workflows of the repository.

- Organization level: secrets defined at the organization level are available in all workflows of the GitHub organization.

- Environment level: secrets defined at the environment level are available only in workflows referencing the specified environment.

For this refernence implementation, we’ll define our secrets at the repository level. To do so, go to the Settings tab of your repository, and select Secrets then Actions under it, in the left menu.

> **Note**  
  The GitHub Actions pipelines are currently configured to deploy the Terraform `Mission Enclave Landing Zone` deployments located in the [infrastructure/terraform](../infrastructure/terraform/).

GitHub Actions pipelines are located in the [`.github/workflows`](.github/workflows/) directory of the repository.

1. Configure your GitHub Actions Secrets
    - In your forked repository, navigate to `Settings > Secrets and variables > Actions`.
    - Create the following secrets:

      | Secret Name | Description | Example Value |
      |-------------|-------------|---------------|
      | `AZURE_AD_CLIENT_ID` | GUID value for the Client ID of the service principal to authenticate with | `00000000-0000-0000-0000-000000000000` |
      | `subscription_id_hub` | [**Required**] GUID value for the Hub Subscription ID to deploy resources to | `00000000-0000-0000-0000-000000000000` |
      | `subscription_id_identity` | [**Optional**] GUID value for the Identity Subscription ID to deploy resources to. This is used in Multi-Subscription deployment | `00000000-0000-0000-0000-000000000000` |
      | `subscription_id_operations` | [**Optional**] GUID value for the Operations Subscription ID to deploy resources to. This is used in Multi-Subscription deployment  | `00000000-0000-0000-0000-000000000000` |
      | `subscription_id_devsecops` | [**Optional**] GUID value for the DevSecOps Subscription ID to deploy resources to. This is used in Multi-Subscription deployment  | `00000000-0000-0000-0000-000000000000` |
      | `AZURE_AD_TENANT_ID` | [**Optional**] GUID value for the Tenant ID of the service principal to authenticate with | `00000000-0000-0000-0000-000000000000` |
      | `AZURE_AD_CLIENT_SECRET` | Secret value for the Service Principal to authenticate with | `asdf1234567` |
      | `AZURE_TF_STATE_RESOURCE_GROUP_NAME` | [**Optional**] For Terraform only: override value to configure the remote state resource group name | `rg-terraform-state` |
      | `AZURE_TF_STATE_STORAGE_ACCOUNT_NAME` | [**Optional**] For Terraform only: override value to configure the remote state storage account name | `tfstate` |
      | `AZURE_TF_STATE_STORAGE_CONTAINER_NAME` | [**Optional**] For Terraform only: override value to configure the remote state storage container name | `tfstate` |
      | `VM_PASSWORD` | Password for the VM | `P@ssw0rd!` |
      | `ARM_ENVIRONMENT` | The Azure environment to deploy to | `public` or `usgovernment` |

---

> **Note:** You can also use the [https://cli.github.com/GitHub](https://cli.github.com/GitHub) CLI to define your secrets, using the command `gh secret set <MY_SECRET> -b"<SECRET_VALUE>" -R <repository_url>`

## Running the workflow

Once you have set up your secrets and modified the workflow files, you can now push your changes to the main branch of your repository. This will trigger the workflow and start the deployment process.
