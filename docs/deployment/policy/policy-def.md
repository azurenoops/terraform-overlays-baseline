# Policy Defintions

This section provides a list of policy definitions included in the Mission Enclave Policy starter implementation.

## Intermedite Root Management Group

| **Policy Name** | **Description** | **Policy Type** | **Initiative** | **Parameter** |
| :--- | :---: | :---: | :---: | :---: |
| `Allowed locations` | This policy enables you to restrict the locations your organization can specify when deploying resources. Use to enforce your geo-compliance requirements. Excludes resource groups, Microsoft.AzureActiveDirectory/b2cDirectories, and resources that use the 'global' region. |  `Policy Definition`,**Built-in**  | General Goverance | {"listOfAllowedLocations":{"value":["eastus","eastus2","westus","westus2"]}} |
| `Audit lock on Networking Resource Types` | This policy audits if a resource lock 'CanNotDelete' or 'ReadOnly' has been applied to the specified Networking components. |  `Policy Definition`,**Built-in**  | General Goverance | {"resourceTypes": {"type": "Array", "metadata": {"description": "Azure netowrking resource types to audit for Locks","displayName": "resourceTypes"},"defaultValue": ["microsoft.network/expressroutecircuits", "microsoft.network/expressroutegateways", "microsoft.network/virtualnetworks", "microsoft.network/virtualnetworkgateways", "microsoft.network/vpngateways", "microsoft.network/p2svpngateways"]}} |
| `Allowed virtual machine size SKUs` | This policy enables you to specify a set of virtual machine size SKUs that your organization can deploy.|  `Policy Definition`,**Built-in** | General Goverance | {"listOfAllowedSKUs":{"value":["Standard_DS1_v2","Standard_DS2_v2","Standard_DS3_v2","Standard_DS4_v2","Standard_DS5_v2","Standard_DS11_v2","Standard_DS12_v2","Standard_DS13_v2","Standard_DS14_v2","Standard_DS15_v2"]}} |
| `Deploy Microsoft Defender for Cloud Security Contacts` | This policy deploys Microsoft Defender for Cloud Security Contacts. |  `Policy Definition`,**Custom** | Security Goverance | "emailSecurityContact": {"type": "string","metadata": {"description": "Provide email address for Azure Security Center contact details","displayName": "Security contacts email address"},"defaultValue": "anoa@contoso.com"}, |
| `Deploy export to Log Analytics workspace for Microsoft Defender for Cloud data` | Enable export to Log Analytics workspace of Microsoft Defender for Cloud data. This policy deploys an export to Log Analytics workspace configuration with your conditions and target workspace on the assigned scope. To deploy this policy on newly created subscriptions, open the Compliance tab, select the relevant non-compliant assignment and create a remediation task. |  `Policy Definition`,**Custom** | Security Governance | |
| `Audit Public Network Access` | This policy set audits Azure resources that allow access from the public internet. |`Policy Definition Set`, **Built-in**   | Audit Public Network Access | |
| `Configure Microsoft Defender for Cloud plans` | This policy set deploys Microsoft Defender for Cloud provides comprehensive, cloud-native protections from development to runtime in multi-cloud environments. Use the policy initiative to configure Defender for Cloud plans and extensions to be enabled on selected scope(s). | `Policy Definition Set`, **Built-in**   |  Configure Microsoft Defender for Cloud plans |  |
| `Deploy Diagnostic Settings for Subscriptions to a Log Analytics workspace` | Deploys the diagnostic settings for Subscriptions to stream to a Log Analytics workspace when any Subscription which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled. |  `Policy Definition`,**Custom** | Monitoring Goverance | |
| `Deploy Diagnostic Settings for Virtual Machines to Log Analytics workspace` | Deploys the diagnostic settings for Virtual Machines to stream to a Log Analytics workspace when any Virtual Machines which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled. |  `Policy Definition`,**Custom** | Monitoring Goverance | |
| `Deploy Diagnostic Settings for SQL Managed Instances to Log Analytics workspace` | Deploys the diagnostic settings for SQL Managed Instances to stream to a regional Log Analytics workspace when any Azure Storage which is missing this diagnostic settings is created or updated. |  `Policy Definition`,**Custom** | Monitoring Goverance | |
| `Deploy Diagnostic Settings for Public IPs to a Log Analytics workspace` | Deploys the diagnostic settings for Azure Public IPs to stream to a regional Log Analytics workspace when any Azure Public IPs which is missing this diagnostic settings is created or updated. |  `Policy Definition`,**Custom** | Monitoring Goverance | |
| `Deploy Diagnostic Settings for Network Interfaces to Log Analytics workspace` | Deploys the diagnostic settings for Azure Network Interfaces to stream to a regional Log Analytics workspace when any Azure Network Interfaces which is missing this diagnostic settings is created or updated. |  `Policy Definition`,**Custom** | Monitoring Goverance | |
| `Deploy Diagnostic Settings for Log Analytics to Log Analytics workspace` | Deploys the diagnostic settings for Log Analytics workspaces to stream to a Log Analytics workspace when any Log Analytics workspace which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled. |  `Policy Definition`,**Custom** | Monitoring Goverance | |
| `Deploy Diagnostic Settings for Firewall to Log Analytics workspace` | Deploys the diagnostic settings for Azure Firewall to stream to a regional Log Analytics workspace when any Azure Firewall which is missing this diagnostic settings is created or updated. |  `Policy Definition`,**Custom** | Monitoring Goverance | |
| `Deploy Diagnostic Settings for Azure Bastion to Log Analytics workspace` | Deploys the diagnostic settings for Azure Bastion to stream to a regional Log Analytics workspace when any Azure Bastion which is missing this diagnostic settings is created or updated. |  `Policy Definition`,**Custom** | Monitoring Goverance | |
| `Deploy Diagnostic Settings for Virtual Network to Log Analytics workspace` | Deploys the diagnostic settings for Azure Virtual Network to stream to a regional Log Analytics workspace when any Azure Virtual Network which is missing this diagnostic settings is created or updated. |  `Policy Definition`,**Custom** | Monitoring Goverance | |
| `Deploy Diagnostic Settings for App Service Plan to Log Analytics workspace` | Deploys the diagnostic settings for Azure App Service Plan to stream to a regional Log Analytics workspace when any Azure App Service Plan which is missing this diagnostic settings is created or updated. |  `Policy Definition`,**Custom** | Monitoring Goverance | |
| `Deploy Diagnostic Settings for App Service to Log Analytics workspace` | Deploys the diagnostic settings for Azure App Service to stream to a regional Log Analytics workspace when any Azure App Service which is missing this diagnostic settings is created or updated. |  `Policy Definition`,**Custom** | Monitoring Goverance | |
| `Deploy Activity Log Key Vault Delete Alert` | Policy to Deploy Activity Log Key Vault Delete Alert. |  `Policy Definition`,**Custom** | Monitoring Goverance | |
| `DenyAction implementation on Activity Logs` | This is a DenyAction implementation policy on Activity Logs.. |  `Policy Definition`,**Custom** | Monitoring Goverance | |
| `DenyAction implementation on Diagnostic Logs.` | DenyAction implementation on Diagnostic Logs. |  `Policy Definition`,**Custom** | Monitoring Goverance | |
| `Azure Active Directory should use private link to access Azure services` | Azure Private Link lets you connect your virtual networks to Azure services without a public IP address at the source or destination. The Private Link platform handles the connectivity between the consumer and services over the Azure backbone network. By mapping private endpoints to Azure AD, you can reduce data leakage risks. Learn more at: https://aka.ms/privateLinkforAzureADDocs. It should be only used from isolated VNETs to Azure services, with no access to the Internet or other services (M365).. |  `Policy Definition`,**Built-in** | Identity and Access Management Governance | |
| `A maximum of 3 owners should be designated for your subscription` | It is recommended to designate up to 3 subscription owners in order to reduce the potential for breach by a compromised owner.. |  `Policy Definition`,**Built-in** | Identity and Access Management Governance | |
| `Blocked accounts with owner permissions on Azure resources should be removed` | Deprecated accounts with owner permissions should be removed from your subscription.  Deprecated accounts are accounts that have been blocked from signing in.. |  `Policy Definition`,**Built-in** | Identity and Access Management Governance | |
| `Audit usage of custom RBAC roles` | Audit built-in roles such as 'Owner, Contributer, Reader' instead of custom RBAC roles, which are error prone. Using custom roles is treated as an exception and requires a rigorous review and threat modeling. |  `Policy Definition`,**Built-in** | Identity and Access Management Governance | |
| `Accounts with owner permissions on Azure resources should be MFA enabled` | Multi-Factor Authentication (MFA) should be enabled for all subscription accounts with owner permissions to prevent a breach of accounts or resources. |  `Policy Definition`,**Built-in** | Identity and Access Management Governance | |

## Platforms Management Group

| Policy Name | Description | Policy Type | Initiative | Parameter |
| :--- | :---: | :---: | :---: | :---: |

### Operations Management Group

| Policy Name | Description | Policy Type | Initiative | Parameter |
| :--- | :---: | :---: | :---: | :---: |

### Security Management Group

| Policy Name | Description | Policy Type | Initiative | Parameter |
| :--- | :---: | :---: | :---: | :---: |

### Identity Management Group

| Policy Name | Description | Policy Type | Initiative | Parameter |
| :--- | :---: | :---: | :---: | :---: |

### DevSecOps Management Group

| Policy Name | Description | Policy Type | Initiative | Parameter |
| :--- | :---: | :---: | :---: | :---: |

## Workloads Management Group

| Policy Name | Description | Policy Type | Initiative | Parameter |
| :--- | :---: | :---: | :---: | :---: |
