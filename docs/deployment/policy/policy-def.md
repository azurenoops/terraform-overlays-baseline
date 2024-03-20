# Policy Defintions

This section provides a list of policy definitions included in the Mission Enclave Policy starter implementation.

## Intermedite Root Management Group

| Policy Name | Description | Policy Type | Initiative | Parameter |
| :--- | :---: | :---: | :---: | :---: |
| `[Preview]: Allowed Azure Regions` | Allowed locations for Resources |  Built-in | General Goverance | {"listOfAllowedLocations":{"value":["northeurope","westeurope","northcentralus","global"]}} |
| `[Preview]: Allowed virtual machine sizes` | Allowed virtual machine sizes |  Built-in | General Goverance | {"listOfAllowedLocations":{"value":["northeurope","westeurope","northcentralus"]}} |
| `[Preview]: Not Allowed resource types` | Not Allowed Resources |  Built-in | General Goverance |
| `audit_locks_on_networking` | This policy audits if a resource lock 'CanNotDelete' or 'ReadOnly' has been applied to the specified Networking components. |  Custom | General Goverance |
| `deploy_asc_security_contacts` | Deploy Microsoft Defender for Cloud Security Contacts |  Custom | Security Governance |
| Deny-Subnet-Without-Nsg | Allowed locations for Resources |  Custom | General Goverance |
| Deploy-Diag-ActivityLog | Allowed locations for Resources |  Custom | General Goverance |
| Deny-PublicEndpoint-Storage | This policy restrict creation of storage accounts with IP Firewall exposed to all public endpoints |  Custom | General Goverance |
| Deny-PublicIP | Allowed locations for Resources |  Custom | General Goverance |
| Deny-Subnet-Without-Nsg | Allowed locations for Resources |  Custom | General Goverance |
| Deploy-ASC-Security-Contacts | Allowed locations for Resources |  Custom | General Goverance |
| Deploy-DDoSProtection | This policy deploys an Azure DDoS Protection Standard plan |  Custom | General Goverance |
| Deploy-Diagnostics-ActivityLog | Ensures that Activity Log Diagnostics settings are set to push logs into Log Analytics |  Custom | General Goverance |
| Deploy-Diagnostics-DLAnalytics | Apply diagnostic settings for Data Lake Analytics - Log Analytics |  Custom | General Goverance |
| Deploy-Diagnostics-Firewall | Allowed locations for Resources |  Custom | General Goverance |
| Deploy-Diagnostics-KeyVault | Allowed locations for Resources |  Custom | General Goverance |
| Deploy-Diagnostics-NetworkSecurityGroups | Allowed locations for Resources |  Custom | General Goverance |
| Deploy-Diagnostics-NIC | Allowed locations for Resources |  Custom | General Goverance |
| Deploy-Diagnostics-PublicIP | Allowed locations for Resources |  Custom | General Goverance |
| Deploy-Diagnostics-SQLDBs | Allowed locations for Resources |  Custom | General Goverance |
| Deploy-Diagnostics-SQLElasticPools | Allowed locations for Resources |  Custom | General Goverance |
| Deploy-Diagnostics-SQLMI | Allowed locations for Resources |  Custom | General Goverance |
| Deploy-Diagnostics-VirtualNetwork | Allowed locations for Resources |  Custom | General Goverance |
| Deploy-Diagnostics-VM | Allowed locations for Resources |  Custom | General Goverance |
| Deploy-Diagnostics-VMSS | Allowed locations for Resources |  Custom | General Goverance |
| Deploy-Diagnostics-WebServerFarm | Allowed locations for Resources |  Custom | General Goverance |
| Deploy-Diagnostics-Website | Allowed locations for Resources |  Custom | General Goverance |
| Deploy-LA-Config | Allowed locations for Resources |  Custom | General Goverance |
| Deploy-Log-Analytics | Allowed locations for Resources |  Custom | General Goverance |
| Deploy-Nsg-FlowLogs | Allowed locations for Resources |  Custom | General Goverance |
| Deploy-Sql-AuditingSettings | Allowed locations for Resources |  Custom | General Goverance |
| Deploy-Sql-SecurityAlertPolicies | Allowed locations for Resources |  Custom | General Goverance |
| Deploy-Sql-Tde | Allowed locations for Resources |  Custom | General Goverance |
| Deploy-Sql-vulnerabilityAssessments | Allowed locations for Resources |  Custom | General Goverance |

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