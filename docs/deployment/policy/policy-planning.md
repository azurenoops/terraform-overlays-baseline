# Planning the Landing Zone Policy

## Initial considerations

The Mission Enclave Policy Starter Terraform module is designed to be used as a starting point for deploying Azure Policy onto an Mission Enclave Landing Zone. It is not intended to be used as a complete solution, but rather as a starting point that can be customized to meet specific requirements.

Before getting started with this module, please take note of the following considerations:

1. This module requires a minimum `azurerm` provider version of `> 3.36.0`.

1. This module requires a minimum Terraform version `1.3.1`.

    > **NOTE:** New releases of the module may contain features which require the minimum supported versions to be increased, but changes will be clearly documented in the release notes, user guide, and readme.

## Mission Enclave Landing Zone Remote State Storage Account

The remote state storage account is used to store the Terraform state files. The state files contain the current state of the infrastructure that has been deployed. The state files are used by Terraform to determine what changes need to be made to the infrastructure when a deployment is run.

To find out more about remote state, see the [Remote State documentation](../remote-state-storage.md).

## Deployment Planning

If you want to change the default values, you can do so by editing the [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-policy-starter/tree/main/infrastructure/policy/tfvars/parameters.tfvars) file. The following sections describe the parameters that can be changed.

### Mission Enclave Policy Global Configuration

The following parameters affect the "Global Configuration". To override the defaults edit the variables file at [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-policy-starter/tree/main/infrastructure/policy/tfvars/parameters.tfvars).

Example Configuration:

Parameter name | Default Value | Description
-------------- | ------------- | -----------
`org_name`           | anoa          | This Prefix will be used on most deployed resources.  10 Characters max.
`environment`        | public | The environment to deploy to.
`deploy_environment` | dev,test,prod | The environment to deploy to.
`default_location`   | eastus | The default region to deploy to.

### Mission Enclave Policy Configuration

The following parameters affect the "Policy Configuration". To override the defaults edit the variables file at [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-policy-starter/tree/main/infrastructure/policy/tfvars/parameters.tfvars).

Example Configuration:

Parameter name | Default Value | Description
-------------- | ------------- | -----------
`skip_remediation`                              | false | set to true to skip remediation of existing resources
`skip_role_assignment`                          | false | set to true to skip role assignment
`re_evaluate_compliance`                        | false | set to true to re-evaluate compliance
`policy_non_compliance_message_enabled`         | true         | set to true to enable the policy non-compliance message
`policy_non_compliance_message_default_enabled` | true         | set to true to enable the policy non-compliance message by default
`policy_exemption_expires_on`                   | "2025-12-31" | The date the policy exemption expires

### Definition and Assignment Scopes

- Should be Defined as **high up** in the hierarchy as possible.
- Should be Assigned as **low down** in the hierarchy as possible.
- Multiple scopes can be exempt from policy inheritance by specifying `assignment_not_scopes` or using the [Azure NoOps Policy Exemption module](https://github.com/azurenoops/terraform-azurerm-overlays-policy/tree/main/modules/policyExemption).
- Policy **overrides RBAC** so even resource owners and contributors fall under compliance enforcements assigned at a higher scope (unless the policy is assigned at the ownership scope).

![Policy Definition and Assignment Scopes](img/scopes.png)

> **Requirement:** Ensure the deployment account has at least [Resource Policy Contributor](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#resource-policy-contributor) role at the `definition_scope` and `assignment_scope`. To successfully create Role-assignments (or group memberships) the same account may also require the [User Access Administrator](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#user-access-administrator) role at the `assignment_scope` or preferably the `definition_scope` to simplify workflows.

### Remediation Tasks and Role Assignments

Role assignments and remediation tasks will be automatically created if the Policy Definition contains a list of Role Definitions.

The remediation tasks will be created with the following naming convention: `remediate-<policy-definition-name>-<timestamp>`. The timestamp is used to ensure that a new remediation task is created on each `terraform apply`. Unless you specify `skip_remediation=true`, the `*_assignment` modules will automatically create [remediation tasks](https://learn.microsoft.com/en-us/azure/governance/policy/how-to/remediate-resources) for policies containing effects of `DeployIfNotExists` and `Modify`.

You can override these with explicit Role Assignments, or specify `skip_role_assignment=true` to omit creation, this is also skipped when using User Managed Identities. By default role assignment scopes will match the policy assignment but can be changed by setting role_assignment_scope.

### Assignment Effects

The `Append` effect is used to add a tag to a resource if it doesn't already have it. The `DeployIfNotExists` effect is used to deploy a resource if it doesn't already exist. The `Modify` effect is used to modify a resource if it doesn't match the policy. The `Audit` effect is used to audit a resource for compliance. The `Deny` effect is used to deny a resource from being created or modified.

> **Note:** If you're managing tags, it's recommended to use `Modify` instead of `Append` as Modify provides additional operation types and the ability to remediate existing resources. However, Append is recommended if you aren't able to create a managed identity or Modify doesn't yet support the alias for the resource property.
> [Microsoft Docs: Understand how effects work](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/effects)

### On-demand evaluation scan

To trigger an on-demand [compliance scan](https://learn.microsoft.com/en-us/azure/governance/policy/how-to/get-compliance-data) with terraform, set `re_evaluate_compliance = true` on `*_assignment` modules, defaults to `false (ExistingNonCompliant)`.

> **Note:** `ReEvaluateCompliance` only applies to remediation at Subscription scope and below and will take longer depending on the size of your environment.

### Mission Enclave General Policy Configuration

The following parameters affect the "General Policy Configuration". To override the defaults edit the variables file at [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-policy-starter/tree/main/infrastructure/policy/tfvars/parameters.tfvars).

Example Configuration:

Parameter name | Default Value | Description
-------------- | ------------- | -----------
`listOfAllowedLocations` | ["eastus", "eastus2", "westus2", "westus", ] | list of allowed locations for resources
`listOfAllowedSKUs` | [ "Standard_D1_v2", "Standard_D2_v2",  "Standard_D3_v2",  "Standard_D4_v2",  "Standard_D11_v2",  "Standard_D12_v2",  "Standard_D13_v2",  "Standard_D14_v2",  "Standard_DS1_v2",  "Standard_DS2_v2",  "Standard_DS3_v2",  "Standard_DS4_v2",  "Standard_DS5_v2",  "Standard_DS11_v2",  "Standard_DS12_v2",  "Standard_DS13_v2",  "Standard_DS14_v2",  "Standard_M8-2ms",  "Standard_M8-4ms",  "Standard_M8ms",  "Standard_M16-4ms",  "Standard_M16-8ms",  "Standard_M16ms",  "Standard_M32-8ms",  "Standard_M32-16ms",  "Standard_M32ls",  "Standard_M32ms",  "Standard_M32ts",  "Standard_M64-16ms",  "Standard_M64-32ms",  "Standard_M64ls",  "Standard_M64ms",  "Standard_M64s",  "Standard_M128-32ms",  "Standard_M128-64ms",  "Standard_M128ms",  "Standard_M128s",  "Standard_M64",  "Standard_M64m",  "Standard_M128",  "Standard_M128m",  "Standard_D1",  "Standard_D2",  "Standard_D3",  "Standard_D4",  "Standard_D11",  "Standard_D12",  "Standard_D13",  "Standard_D14",  "Standard_DS15_v2",  "Standard_NV6",  "Standard_NV12",  "Standard_NV24",  "Standard_F2s_v2",  "Standard_F4s_v2",  "Standard_F8s_v2",  "Standard_F16s_v2",  "Standard_F32s_v2",  "Standard_F64s_v2",  "Standard_F72s_v2", "Standard_NC6s_v3",  "Standard_NC12s_v3",  "Standard_NC24rs_v3",  "Standard_NC24s_v3",  "Standard_NC6",  "Standard_NC12",  "Standard_NC24", "Standard_NC24r",  "Standard_ND6s",  "Standard_ND12s",  "Standard_ND24rs",  "Standard_ND24s",  "Standard_NC6s_v2",  "Standard_NC12s_v2",  "Standard_NC24rs_v2", "Standard_NC24s_v2",  "Standard_ND40rs_v2",  "Standard_NV12s_v3",  "Standard_NV24s_v3",  "Standard_NV48s_v3"] | list of allowed SKUs for Virtual Machines

### Mission Enclave Logging Policy Configuration

The following parameters affect the "Logging Policy Configuration". To override the defaults edit the variables file at [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-policy-starter/tree/main/infrastructure/policy/tfvars/parameters.tfvars).

Example Configuration:

Parameter name | Default Value | Description
-------------- | ------------- | -----------
`workspaceRetentionDays` | 90 | The number of days to retain logs in the Log Analytics workspace.

### Mission Enclave Network Policy Configuration

The following parameters affect the "Network Policy Configuration". To override the defaults edit the variables file at [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-policy-starter/tree/main/infrastructure/policy/tfvars/parameters.tfvars).

Example Configuration:

Parameter name | Default Value | Description
-------------- | ------------- | -----------
`listofPortsToDeny` | ["22","3389"] | list of ports to deny in the Network Security Group
`listOfAllowedIPAddressesforNSGs` | [] | list of allowed IP addresses for Network Security Groups

### Mission Enclave Monitoring Policy Configuration

The following parameters affect the "Monitoring Policy Configuration". To override the defaults edit the variables file at [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-policy-starter/tree/main/infrastructure/policy/tfvars/parameters.tfvars).

Example Configuration:

Parameter name | Default Value | Description
-------------- | ------------- | -----------
`listOfResourceTypesToAuditDiagnosticSettings` | ["Microsoft.AnalysisServices/servers",  "Microsoft.ApiManagement/service",  "Microsoft.Network/applicationGateways",  "Microsoft.Automation/automationAccounts",  "Microsoft.ContainerRegistry/registries",  "Microsoft.ContainerService/managedClusters",  "Microsoft.Batch/batchAccounts",  "Microsoft.Cdn/profiles/endpoints",  "Microsoft.CognitiveServices/accounts",  "Microsoft.DocumentDB/databaseAccounts",  "Microsoft.DataFactory/factories",  "Microsoft.DataLakeAnalytics/accounts",  "Microsoft.DataLakeStore/accounts",  "Microsoft.EventGrid/topics",  "Microsoft.EventHub/namespaces",  "Microsoft.Network/expressRouteCircuits",  "Microsoft.Network/azureFirewalls",  "Microsoft.HDInsight/clusters",  "Microsoft.Devices/IotHubs",  "Microsoft.KeyVault/vaults",  "Microsoft.Network/loadBalancers",  "Microsoft.Logic/integrationAccounts",  "Microsoft.Logic/workflows",  "Microsoft.DBforMySQL/servers",  "Microsoft.Network/networkSecurityGroups",  "Microsoft.Network/bastionHosts",  "Microsoft.Kusto/clusters",  "Microsoft.DBForMariaDB/servers",  "Microsoft.DBforPostgreSQL/servers",  "Microsoft.PowerBIDedicated/capacities",  "Microsoft.Network/publicIPAddresses",  "Microsoft.RecoveryServices/vaults",  "Microsoft.Cache/redis",  "Microsoft.Relay/namespaces",  "Microsoft.Search/searchServices",  "Microsoft.ServiceBus/namespaces",  "Microsoft.SignalRService/SignalR",  "Microsoft.Sql/servers/databases",  "Microsoft.StreamAnalytics/streamingjobs",  "Microsoft.TimeSeriesInsights/environments",  "Microsoft.Network/trafficManagerProfiles",  //"Microsoft.Compute/virtualMachines", # Logs are collected through Microsoft Monitoring Agent  //"Microsoft.Compute/virtualMachineScaleSets", Removed since it is not supported,  "Microsoft.Network/virtualNetworks",  "Microsoft.Network/virtualNetworkGateways",  "Microsoft.Web/sites",  "Microsoft.Media/mediaservices",] | list of resource types to audit diagnostic settings
`securityContactsEmail` | `anoa_admins@contoso.us` | The email address to send security alerts to.

### Mission Enclave Key Vault Policy Configuration

The following parameters affect the "Key Vault Policy Configuration". To override the defaults edit the variables file at [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-policy-starter/tree/main/infrastructure/policy/tfvars/parameters.tfvars).

Example Configuration:

Parameter name | Default Value | Description
-------------- | ------------- | -----------
`listOfAllowedIPAddresses` | [] | list of allowed IP addresses for Key Vault

### Mission Enclave Cost Management Policy Configuration

The following parameters affect the "Cost Management Policy Configuration". To override the defaults edit the variables file at [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-policy-starter/tree/main/infrastructure/policy/tfvars/parameters.tfvars).

Example Configuration:

Parameter name | Default Value | Description
-------------- | ------------- | -----------
`budget_amount` | "10000" | The budget amount in USD
