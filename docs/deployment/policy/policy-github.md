# Deploy a Mission Enclave Policy using GitHub Actions

This document provides guidance on how to deploy a [Mission Enclave Policy starter](https://github.com/azurenoops/ref-scca-enclave-policy-starter) using GitHub Actions.

Learn more about Azure NoOps GitHub Actions [here](../github-actions.md).

## GitHub Deployment

To deploy the Mission Enclave Policy, we'll setup a GitHub Actions CI/CD workflow that will build and deploy our application whenever we push new commits to the main branch of our repository.

## Configure remote state storage account

Before you use Azure Storage as a backend for the state file, you must create a storage account.

Reference the [Remote State Storage](./remote-state-storage.md) directory for the Terraform configuration to create the storage account and container.

### Using GitHub Dependencies Action

Run the following action [deploy_dependencies.yml](https://github.com/azurenoops/ref-scca-enclave-policy-starter/tree/main/.github/workflows/deploy_dependencies.yml) to create the storage account and container.

## Setting Up GitHub Actions for deployment

To set up GitHub Actions for deployment, we'll need to use the new workflow file in our repository.
This file will contain the instructions for our CI/CD pipeline.

## Creating an Azure Service Principal

In order to deploy our Mission Enclave Policy, we'll need to create an Azure Service Principal. 
This is an identity that can be used to authenticate to Azure, and that can be granted access to specific resources.

> NOTE: If you already have a Service Principal that you want to use, you can skip this step.

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
  The GitHub Actions pipelines are currently configured to deploy the Terraform `Mission Enclave Policy` deployments located in the [infrastructure/policy](https://github.com/azurenoops/ref-scca-enclave-policy-starter/infrastructure/policy/).

GitHub Actions pipelines are located in the [`.github/workflows`](https://github.com/azurenoops/ref-scca-enclave-policy-starter/.github/workflows/) directory of the repository.

1. Configure your GitHub Actions Secrets
    - In your forked repository, navigate to `Settings > Secrets and variables > Actions`.
    - Create the following secrets:

      | Secret Name | Description | Example Value |
      |-------------|-------------|---------------|
      | `AZURE_AD_CLIENT_ID` | GUID value for the Client ID of the service principal to authenticate with | `00000000-0000-0000-0000-000000000000` |
      | `subscription_id_hub` | [**Required**] GUID value for the Hub Subscription ID to deploy resources to | `00000000-0000-0000-0000-000000000000` |      
      | `AZURE_AD_TENANT_ID` | [**Optional**] GUID value for the Tenant ID of the service principal to authenticate with | `00000000-0000-0000-0000-000000000000` |
      | `AZURE_AD_CLIENT_SECRET` | Secret value for the Service Principal to authenticate with | `asdf1234567` |
      | `AZURE_TF_STATE_RESOURCE_GROUP_NAME` | [**Optional**] For Terraform only: override value to configure the remote state resource group name | `rg-terraform-state` |
      | `AZURE_TF_STATE_STORAGE_ACCOUNT_NAME` | [**Optional**] For Terraform only: override value to configure the remote state storage account name | `tfstate` |
      | `AZURE_TF_STATE_STORAGE_CONTAINER_NAME` | [**Optional**] For Terraform only: override value to configure the remote state storage container name | `tfstate` |
      | `ARM_ENVIRONMENT` | The Azure environment to deploy to | `public` or `usgovernment` |

---

> **Note:** You can also use the [https://cli.github.com/GitHub](https://cli.github.com/GitHub) CLI to define your secrets, using the command `gh secret set <MY_SECRET> -b"<SECRET_VALUE>" -R <repository_url>`

## Running the workflow

Once you have set up your secrets and modified the workflow files, you can now push your changes to the main branch of your repository. This will trigger the workflow and start the deployment process.
