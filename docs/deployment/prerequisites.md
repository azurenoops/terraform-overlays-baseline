# Prerequisites

Mission Enclave Starters can bootstrap an entire Azure tenant without any infrastructure dependencies, and the user must first have Owner permission on the tenant *root* before deploying.

*Note: Once you have completed the deployment, you can remove the Owner permission from the tenant root, as it will no longer be needed for any subsequent operations.*

Before you begin, ensure you have met the following requirements:

- **Azure Subscription**: You need an Azure subscription to create resources in Azure. If you don't have one, you can create a [free account](https://azure.microsoft.com/free/).

- **Azure CLI or Azure PowerShell**: You need either Azure CLI or Azure PowerShell installed and configured to interact with your Azure account. You can download them from [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) and [here](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps) respectively.

- **Terraform**: You will need Terraform installed to deploy the infrastructure. You can download Terraform from [here](https://www.terraform.io/downloads.html).

- **Knowledge of Azure Landing Zones**: This project involves deploying and managing Azure Landing Zones resources. Familiarity with Azure Landing Zones and its concepts is recommended.

- **Knowledge of Azure Policy**: This project involves deploying and managing Azure Policy resources. Familiarity with Azure Policy and its concepts is recommended.

- **Knowledge of Azure Sentinel**: This project involves deploying and managing Azure Sentinel resources. Familiarity with Azure Sentinel and its concepts is recommended.

- **GitHub Actions**: You need to have a GitHub account and a repository to deploy the Mission Enclave Landing Zone.

This requires the following:

- A user that is Global Admin in the Microsoft Entra ID

- Elevation of privileges of this user which grants him/her the “User Access Administrator” permission at the tenant root scope

- An explicit roleAssignment (RBAC) made at the tenant root scope via CLI or PowerShell (Note: There’s no portal UX to make this roleAssignment)

## Elevate Access to manage Azure resources in the directory

1.1  Sign into the Azure portal as a user being Global Administrator

1.2  Open Microsoft Entra ID

1.3  Under *Manage*, select *Properties

![Graphical user interface, text, application, Teams  Description automatically generated](../../img/clip_image006.jpg)

1.4  Under *Access management for Azure resources,* set the toggle to *Yes

![Graphical user interface, text, application, email  Description automatically generated](../../img/clip_image008.jpg)

### Grant Access to the User at *tenant root scope “/”* to deploy Mission Enclave Landing Zone Starter

You can use either Bash (CLI) or PowerShell to create the roleAssignment for the current user – or a dedicated user – that will do the deployment.

Bash:

```bash
#sign  into AZ CLI, this will redirect you to a web browser for authentication, if required
az login

#assign Owner role to Tenant root scope  ("/") as a Owner (gets object Id of the current user (az login))
az role assignment create --scope '/'  --role 'Owner' --assignee-object-id $(az ad signed-in-user show --query id --output tsv)
```

Powershell:

```powershell
#sign in to Azure  from Powershell, this will redirect you to a web browser for authentication, if required
Connect-AzAccount

#get object Id of  the current user (that is used above)
$user = Get-AzAduser -SignedIn

#assign Owner  role to Tenant root scope ("/") as a User Access Administrator
New-AzRoleAssignment -Scope '/' -RoleDefinitionName 'Owner' -ObjectId $user.Id
```

> Please note: sometimes it can take up to 15 minutes for permission to propagate at tenant root scope. It is highly recommended that you log out and log back in to refresh the token before you proceed with the deployment.*

### Azure Monitor Baseline Alerts prerequisites

The Azure Monitor Baseline Alerts are deployed as part of the Mission Enclave Landing Zone Starter deployment, and they require the following:

1. For the policies to work, the following Azure resource providers, normally registered by default, must be registered on all subscriptions in scope:
  - Microsoft.AlertsManagement
  - Microsoft.Insights
Please see [here](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-providers-and-types#register-resource-provider) for details on how to register a resource provider should you need to do so.