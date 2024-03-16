# Deploying the Mission Enclave Policy starter using manual deployment

This guide describes how to deploy Mission Enclave Policy starter using the [Terraform](https://www.terraform.io/) modules at [policy/terraform/](../policy/terraform/).

To get started with Terraform on Azure check out their [tutorial](https://learn.hashicorp.com/collections/terraform/azure-get-started/).

## Prerequisites

Before you begin, ensure you have met the following requirements:

- **Azure Subscription**: You need an Azure subscription to create resources in Azure. If you don't have one, you can create a [free account](https://azure.microsoft.com/free/).

- **Azure CLI or Azure PowerShell**: You need either Azure CLI or Azure PowerShell installed and configured to interact with your Azure account. You can download them from [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) and [here](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps) respectively.

- **Terraform**: You will need Terraform installed to deploy the infrastructure. You can download Terraform from [here](https://www.terraform.io/downloads.html).

- **Knowledge of Azure Landing Zones**: This project involves deploying and managing Azure Landing Zones resources. Familiarity with Azure Landing Zones and its concepts is recommended.

- **Knowledge of Azure Policy**: This project involves deploying and managing Azure Policy resources. Familiarity with Azure Policy and its concepts is recommended.

## Quickstart

Below is an example of a Terraform deployment that uses all the defaults in the [TFVARS folder](./../policy/terraform/tfvars/parameters.tfvars) to deploy the Policy to one subscription.

>NOTE: Since this reference implementation is designed to use remote state, you will need to comment out the `backend "local" {}` block in the [versions.tf](./../policy/terraform/versions.tf) file. This will allow you to deploy the Policy without having to deploy the remote state storage account first.

```bash
cd infrastructure/policy
terraform init
terraform plan --out anoa.policy.dev.plan --var-file tfvars/parameters.tfvars --var "subscription_id_hub=<<subscription_id>>" --var "environment=usegovernment" # supply some parameters, approve, copy the output values
terraform apply anoa.policy.dev.plan
```

## Manual Deployment

Mission Enclave Policy can be deployed with command-line tools provided with the Terraform CLI in PowerShell.

### Command Line Deployment Using the Terraform CLI in PowerShell

Use the Terraform CLI command `terraform` to deploy Mission Enclave Policy across one or many subscriptions. The following sections describe how to deploy Mission Enclave Policy using the Terraform CLI in PowerShell.

### Single Subscription Deployment

To deploy Mission Enclave Policy into a single subscription, you must first login to Azure.

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

1. Navigate to the directory in the repository that contains the Mission Enclave Policy Starter Terraform modules and configuration files:

    ```bash
    cd infrastructure/policy
    ```

>NOTE: Since this reference implementation is designed to use remote state, you will need to comment out the `backend "local" {}` block in the [versions.tf](./../policy/terraform/versions.tf) file. This will allow you to deploy the Policy without having to deploy the remote state storage account first. For more information on remote state, see the [Remote State documentation](../docs/07-Remote-State-Storage.md).

1. Execute `terraform init`

    ```bash
    terraform init
    ```

### Terraform Plan

After initializing the directory, use [`terraform plan`](https://www.terraform.io/docs/cli/commands/plan.html) to provision the resources plan described in `infrastructure/policy`.

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

To deploy Mission Enclave Policy into multiple subscriptions, follow the same steps as deploying to Single Subscription. The only difference is that you will need to add the subscription ID for each subscription you are deploying to on the [`terraform plan`](https://www.terraform.io/docs/cli/commands/plan.html).

Example:

```plaintext
> terraform plan --var-file tfvars/parameters.tfvars --out "anoa.dev.plan" -var "subscription_id_hub=00000000-0000-0000-0000-000000000000" -var "subscription_id_identity=00000000-0000-0000-0000-000000000000" -var "subscription_id_operations="\00000000-0000-0000-0000-000000000000" -var "subscription_id_devsecops=00000000-0000-0000-0000-000000000000" -var "vm_admin_password=Password1234!"
```

## Development Setup

For development of the Mission Policy Starter Terraform templates we recommend using the development container because it has the necessary dependencies already installed. To get started follow the [guidance for using the development container](../.devcontainer/README.md).