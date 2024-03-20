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
