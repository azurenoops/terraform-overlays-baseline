# Deploy a Mission Enclave Landing Zone

This document provides guidance on how to deploy a [Mission Enclave Landing Zone starter](https://github.com/azurenoops/ref-scca-enclave-landing-zone-starter).

## Prerequisites

- Current version of the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- The version of the [Terraform CLI](https://www.terraform.io/downloads.html) described in the [.devcontainer Dockerfile](https://github.com/AzureNoOps/ref-scca-enclave-landing-zone-starter/devcontainer/Dockerfile)
- An Azure Subscription(s) where you or an identity you manage has `Owner` [RBAC permissions](https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#owner)

<!-- markdownlint-disable MD013 -->
> NOTE: Azure Cloud Shell is often our preferred place to deploy from because the AZ CLI and Terraform are already installed. However, sometimes Cloud Shell has different versions of the dependencies from what we have tested and verified, and sometimes there have been bugs in the Terraform Azure RM provider or the AZ CLI that only appear in Cloud Shell. If you are deploying from Azure Cloud Shell and see something unexpected, try the [development container](../.devcontainer) or deploy from your machine using locally installed AZ CLI and Terraform. We welcome all feedback and [contributions](../CONTRIBUTING.md), so if you see something that doesn't make sense, please [create an issue](https://github.com/AzureNoOps/ref-scca-enclave-landing-zone-starter/issues/new/choose) or open a [discussion thread](https://github.com/AzureNoOps/ref-scca-enclave-landing-zone-starter/discussions).
<!-- markdownlint-enable MD013 -->

## Quickstart

Below is an example of a Terraform deployment that uses all the defaults in the [TFVARS folder](https://github.com/azurenoops/ref-scca-enclave-landing-zone-starter/infrastructure/terraform/tfvars/parameters.tfvars) to deploy the landing zone to one subscription.

>NOTE: Since this reference implementation is designed to use remote state, you will need to comment out the [`backend "local" {}` block in the versions.tf](https://github.com/AzureNoOps/ref-scca-enclave-landing-zone-starter/infrastructure/terraform/versions.tf) file. This will allow you to deploy the landing zone without having to deploy the remote state storage account first.

```bash
cd infrastructure/terraform
terraform init
terraform plan --out anoa.dev.plan --var-file tfvars/parameters.tfvars --var "subscription_id_hub=<<subscription_id>>" --var "vm_admin_password=<<vm password>>" # supply some parameters, approve, copy the output values
terraform apply anoa.dev.plan
```

## Planning

If you want to change the default values, you can do so by editing the [parameters.tfvars](https://github.com/AzureNoOps/ref-scca-enclave-landing-zone-starter/infrastructure/terraform/tfvars/parameters.tfvars) file. The following sections describe the parameters that can be changed.

### One Subscription or Multiple

Mission Enclave Landing Zone starter can deploy to a single subscription or multiple subscriptions. A test and evaluation deployment may deploy everything to a single subscription, and a production deployment may place each tier into its own subscription.

The optional parameters related to subscriptions are below. At least one subscription is required.

Parameter name | Default Value | Description
-------------- | ------------- | -----------
`subscription_id_hub` | '' | Subscription ID for the Hub deployment
`subscription_id_identity` | value of hub_subid | Subscription ID for identity tier
`subscription_id_operations` | value of hub_subid | Subscription ID for operations tier
`subscription_id_devsecops` | value of hub_subid | Subscription ID for devsecops tier

### Mission Enclave Landing Zone Remote State Storage Account

The remote state storage account is used to store the Terraform state files. The state files contain the current state of the infrastructure that has been deployed. The state files are used by Terraform to determine what changes need to be made to the infrastructure when a deployment is run.

To find out more about remote state, see the [Remote State documentation](./Remote-State-Storage.md).

### Mission Enclave Landing Zone Global Configuration

The following parameters affect the "01 Global Configuration". To override the defaults edit the variables file at [parameters.tfvars](https://github.com/AzureNoOps/ref-scca-enclave-landing-zone-starter/infrastructure/terraform/tfvars/parameters.tfvars).

Example Configuration:

Parameter name | Default Value | Description
-------------- | ------------- | -----------
`org_name`       | anoa          | This Prefix will be used on most deployed resources.  10 Characters max.
`deploy_environment` | dev | This Prefix will be used on most deployed resources.  10 Characters max.
`environment` | public | The environment to deploy to.
`default_location` | eastus | The default region to deploy to.
`enable_resource_locks` | false | Enable locks on resources.  true | false
`enable_traffic_analytics` | true | Enable NSG Flow Logs.  true | false

### Mission Enclave Management Groups

The following parameters affect the "02 Management Groups Configuration" To override the defaults edit the variables file at [parameters.tfvars](https://github.com/AzureNoOps/ref-scca-enclave-landing-zone-starter/infrastructure/terraform/tfvars/parameters.tfvars).

Example Configuration:

Parameter name | Default Value | Description
-------------- | ------------- | -----------
`enable_management_groups` | true | Enable management groups for this subscription
`root_management_group_id` | anoa | The root management group id for this subscription
`root_management_group_display_name` | anoa | The root management group display name for this subscription

To modify the management group structure, go to the [locals.tf](https://github.com/AzureNoOps/ref-scca-enclave-landing-zone-starter/infrastructure/terraform/locals.tf) file and modify the 'management_groups' section. The 'root_management_group_id' is used for the top level groups.

## Manual Deployment

Mission Enclave Landing Zone can be deployed with command-line tools provided with the Terraform CLI in PowerShell.

### Command Line Deployment Using the Terraform CLI in PowerShell

Use the Terraform CLI command `terraform` to deploy Mission Enclave Landing Zone across one or many subscriptions. The following sections describe how to deploy Mission Enclave Landing Zone using the Terraform CLI in PowerShell.

### Single Subscription Deployment

To deploy Mission Enclave Landing Zone into a single subscription, you must first login to Azure.

### Login to Azure CLI

Log in using the Azure CLI.

```BASH
# AZ CLI
az cloud set -n AzureCloud
az login
```

### Set the Environment

```BASH
# AZ CLI
$env:ARM_ENVIRONMENT = "public"
```

>NOTE: If you are deploying to Azure US Government, set the environment to `usgovernment`.

### Terraform init

Before provisioning any Azure resources with Terraform you must [initialize a working directory](https://www.terraform.io/docs/cli/commands/init.html/).

1. Navigate to the directory in the repository that contains the Mission Enclave Landing Zone Starter Terraform modules and configuration files:

    ```bash
    cd infrastructure/terraform
    ```

>NOTE: Since this reference implementation is designed to use remote state, you will need to comment out the `backend "local" {}` block in the [versions.tf](./../infrastructure/terraform/versions.tf) file. This will allow you to deploy the landing zone without having to deploy the remote state storage account first. For more information on remote state, see the [Remote State documentation](./docs/remote-state-storage.md).

1. Execute `terraform init`

    ```bash
    terraform init
    ```

### Terraform Plan

After initializing the directory, use [`terraform plan`](https://www.terraform.io/docs/cli/commands/plan.html) to provision the resources plan described in `infrastructure/terraform`.

1. From the directory in which you executed `terraform init` execute `terraform plan` with the `--var-file` parameter to specify the path to the `parameters.tfvars` file:

    ```bash
    terraform apply --var-file tfvars/parameters.tfvars --out "anoa.dev.plan"
    ```

1. You'll be prompted for a Hub subscription ID and VM Password.

    Supply the subscription ID you want to use for the Hub network:

    ```plaintext
    > terraform plan
    var.subscription_id_hub
    If specified, identifies the Platform subscription for "Hub" for resource deployment and correct placement in the Management Group hierarchy.

    Enter a value:

    Supply the VM Admin Password you want to use for the Bastion VM:

    ```plaintext
    var.vm_admin_password
    The password for the administrator account for the Bastion VM.

    Enter a value:
    ```

 >*NOTE:* If you want to skip the prompts, you can supply the values on the command line using the `--var` parameter. For more information, see the [Terraform CLI documentation](https://www.terraform.io/docs/cli/commands/plan.html#var).

### Terraform Apply

Now run `terraform apply`, by default, Terraform will inspect the state of your environment to determine what resource creation, modification, or deletion needs to occur from the [`terraform plan`](https://www.terraform.io/docs/cli/commands/plan.html) using the output plan and then prompt you for your approval before taking action.

1. From the directory in which you executed `terraform init` execute `terraform apply` with the `anoa.de.plan` parameter:

    ```bash
    terraform apply "anoa.dev.plan"
    ```

>NOTE: Since you are using a output plan file, you will not be prompted for approval to deploy.

1. The deployment will begin. These commands will deploy all of the resources that make up Mission Enclave LZ. Deployment could take up to 45 minutes.

### Apply Complete

When it's complete, you'll see some output values that will be necessary if you want to stand up new workload spoke, or add-on:

```plaintext
Apply complete! Resources: 166 added, 0 changed, 0 destroyed.

Example Outputs:

hub_virtual_network_id = /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/anoa-hub-networking-rg/providers/Microsoft.Network/virtualNetworks/anoa-hub-vnet
hub_virtual_network_name = "anoa-hub-core-dev-vnet"
firewall_private_ip = "0.0.0.0"
log_analytics_workspace_id = /subscriptions/00000000-0000-0000-0000-000000000000/resourcegroups/anoa-hub-networking-rg/providers/microsoft.operationalinsights/workspaces/anoa-hub-logs-dev-law
...
```

### Deploying to Other Clouds

When deploying to another cloud, like Azure US Government, first set the cloud and log in.

Logging into `AzureUSGovernment`:

```BASH
# AZ CLI
az cloud set -n AzureUsGovernment
az login
```

### Deploying to Multiple Subscriptions

To deploy Mission Enclave Landing Zone into multiple subscriptions, follow the same steps as deploying to Single Subscription. The only difference is that you will need to add the subscription ID for each subscription you are deploying to on the [`terraform plan`](https://www.terraform.io/docs/cli/commands/plan.html).

Example:

```plaintext
> terraform plan --var-file tfvars/parameters.tfvars --out "anoa.dev.plan" -var "subscription_id_hub=00000000-0000-0000-0000-000000000000" -var "subscription_id_identity=00000000-0000-0000-0000-000000000000" -var "subscription_id_operations="\00000000-0000-0000-0000-000000000000" -var "subscription_id_devsecops=00000000-0000-0000-0000-000000000000" -var "vm_admin_password=Password1234!"
```

## Cleanup

If you want to delete an Mission Enclave Landing Zone deployment you can use [`terraform destroy`](https://www.terraform.io/docs/cli/commands/destroy.html). If you have deployed more than one Terraform template, e.g., if you have deployed `Landing Zone` and then `Add-on`, run the `terraform destroy` commands in the reverse order that you applied them. For example:

```bash
# Deploy core MLZ resources
cd infrastructure/terraform
terraform apply

# Destroy core MLZ resources
cd infrastructure/terraform
terraform destroy
```

Running `terraform destroy` for `infrastructure/terraform` looks like this:

1. From the directory in which you executed `terraform init` and `terraform apply` execute `terraform destroy`:

    ```bash
    terraform destroy
    ```

1. You'll be prompted for a subscription ID. Supply the subscription ID you want to used previously:

    ```plaintext
    > terraform destroy
    var.hub_subid
    Subscription ID for the deployment

    Enter a value: 
    ```

1. Terraform will then inspect the state of your Azure environment and compare it with what is described in Terraform state. Eventually, you'll be prompted for your approval to destroy resources. Supply `yes`:

    ```plaintext
    Do you want to perform these actions?
      Terraform will perform the actions described above.
      Only 'yes' will be accepted to approve.

    Enter a value: yes
    ```

This command will attempt to remove all the resources that were created by `terraform apply` and could take up to 45 minutes.

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

Run the following action [deploy_dependencies.yml](.github/workflows/deploy_dependencies.yml) to create the storage account and container.

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
      | `AZURE_SUBSCRIPTION_ID` | GUID value for the Subscription ID to deploy resources to | `00000000-0000-0000-0000-000000000000` |
      | `AZURE_AD_TENANT_ID` | GUID value for the Tenant ID of the service principal to authenticate with | `00000000-0000-0000-0000-000000000000` |
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