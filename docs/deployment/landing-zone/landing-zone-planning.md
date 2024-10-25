# Planning

## Initial considerations

The Mission Enclave Landing Zone Starter Terraform module is designed to be used as a starting point for deploying a landing zone. It is not intended to be used as a complete solution, but rather as a starting point that can be customized to meet specific requirements.

Before getting started with this module, please take note of the following considerations:

1. This module requires a minimum `azurerm` provider version of `> 3.36.0`.

1. This module requires a minimum Terraform version `1.3.1`.

    > **NOTE:** New releases of the module may contain features which require the minimum supported versions to be increased, but changes will be clearly documented in the release notes, user guide, and readme.

## Mission Enclave Landing Zone Remote State Storage Account

The remote state storage account is used to store the Terraform state files. The state files contain the current state of the infrastructure that has been deployed. The state files are used by Terraform to determine what changes need to be made to the infrastructure when a deployment is run.

To find out more about remote state, see the [Remote State documentation](./remote-state-storage.md).

## Deployment Planning

If you want to change the default values, you can do so by editing the [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-landing-zone-starter/tree/main/infrastructure/terraformtfvars/parameters.tfvars) file. The following sections describe the parameters that can be changed.

### One Subscription or Multiple

Mission Enclave Landing Zone starter can deploy to a single subscription or multiple subscriptions. A test and evaluation deployment may deploy everything to a single subscription, and a production deployment may place each tier into its own subscription.

The optional parameters related to subscriptions are below. At least one subscription is required.

Parameter name | Default Value | Description
-------------- | ------------- | -----------
`subscription_id_hub` | '' | Subscription ID for the Hub deployment
`subscription_id_identity` | value of hub_subid | Subscription ID for identity tier
`subscription_id_operations` | value of hub_subid | Subscription ID for operations tier
`subscription_id_devsecops` | value of hub_subid | Subscription ID for devsecops tier

### Mission Enclave Landing Zone Global Configuration

The following parameters affect the "01 Global Configuration". To override the defaults edit the variables file at [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-landing-zone-starter/tree/main/infrastructure/terraform/tfvars/parameters.tfvars).

Example Configuration:

Parameter name | Default Value | Description | Possible Values
-------------- | ------------- | ----------- | ---------------
`org_name`       | anoa          | This Prefix will be used on most deployed resources.  10 Characters max.
`deploy_environment` | dev | This Prefix will be used on most deployed resources.  10 Characters max.
`environment` | public | The environment to deploy to.
`default_location` | eastus | The default region to deploy to.
`enable_resource_locks` | false | Enable locks on resources. |  true , false
`enable_traffic_analytics` | true | Enable NSG Flow Logs. |  true , false

### Mission Enclave Management Groups

The following parameters affect the "02 Management Groups Configuration" To override the defaults edit the variables file at [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-landing-zone-starter/tree/main/infrastructure/terraform/tfvars/parameters.tfvars).

Example Configuration:

Parameter name | Default Value | Description
-------------- | ------------- | -----------
`enable_management_groups` | true | Enable management groups for this subscription
`root_management_group_id` | anoa | The root management group id for this subscription
`root_management_group_display_name` | anoa | The root management group display name for this subscription

To modify the management group structure, go to the [locals.tf](https://github.com/azurenoops/ref-scca-enclave-landing-zone-starter/tree/main/infrastructure/terraform/locals.tf) file and modify the 'management_groups' section. The 'root_management_group_id' is used for the top level groups.

### Mission Enclave Management Budgets

The following parameter effects budgets. Do not modify if you plan to use the default values.

Example Configuration:

Parameter name | Default Value | Description
-------------- | ------------- | -----------
`enable_management_groups_budgets` | false | enable budgets for management groups
`budget_contact_emails` | ["anoa@contoso.com"] | email addresses to send alerts to for this subscription
`budget_amount` | 100 | budget amount
`budget_start_date`  | 2023-09-01T00:00:00Z | budget start date. format: YYYY-MM-DDTHH:MM:SSZ
`budget_end_date` | 2023-09-01T00:00:00Z | budget end date. format: YYYY-MM-DDTHH:MM:SSZ

### Mission Enclave Management Roles

The following parameter effects custom roles. Do not modify if you plan to use the default values.

Example Configuration:

Parameter name | Default Value | Description
-------------- | ------------- | -----------
`deploy_custom_roles` | true | deploy custom roles

To modify the roles structure, go to the [locals.tf](https://github.com/azurenoops/ref-scca-enclave-landing-zone-starter/tree/main/infrastructure/terraform/locals.tf) file and modify the 'custom_role_definitions' section.

### Mission Enclave - Management Hub Virtual Network

The following will be created:

- Resource Group for Management Hub Networking (main.tf)
- Management Hub Network (main.tf)
- Management Hub Subnets (main.tf)

Review and if needed, comment out and modify the variables within the "Landing Zone Configuration" section under "Management Hub Virtual Network" of the common variable definitions file [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-landing-zone-starter/tree/main/infrastructure/terraform/tfvars/parameters.tfvars). Do not modify if you plan to use the default values.

>NOTE: IP address ranges are in CIDR notation. For more information, see [Understanding IP Addressing](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-ip-addresses-overview-arm#understanding-ip-addressing-in-your-virtual-network).

Example Configuration:

Parameter name | Default Value | Description
-------------- | ------------- | -----------
`hub_vnet_address_space` | ["10.0.128.0/23"] | The CIDR Virtual Network Address Prefix for the Hub Virtual Network.
`fw_client_snet_address_prefixes` | ["10.0.128.0/26"] | The CIDR Subnet Address Prefix for the Azure Firewall Subnet. It must be in the Hub Virtual Network space. It must be /26.
`ampls_subnet_address_prefixes` | ["10.0.131.64/27"] |  The CIDR Subnet Address Prefix for the Azure Monitor Private Link Subnet. It must be in the Hub Virtual Network space. It must be /27.
`fw_management_snet_address_prefixes` | ["10.0.128.64/26"] |  The CIDR Subnet Address Prefix for the Azure Firewall Management Subnet. It must be in the Hub Virtual Network space. It must be /26.
`gateway_vnet_address_space` | ["10.0.128.0/27"] |  The CIDR Subnet Address Prefix for the Gateway Subnet. It must be in the Hub Virtual Network space. It must be /27. This is the subnet that will be used for the VPN Gateway. Optional, if you do not want to deploy a VPN Gateway, remove this subnet from the list.
`hub_subnets` | array | The subnets to create in the hub virtual network.

### Mission Enclave - Management Hub Operational Logging

The following will be created:

- Log Analytics (main.tf)
- Log Solutions (main.tf)

Review and if needed, comment out and modify the variables within the "Landing Zone Configuration" section under "Management Operational Logging" of the common variable definitions file [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-landing-zone-starter/tree/main/infrastructure/terraform/tfvars/parameters.tfvars). Do not modify if you plan to use the default values.

Example Configuration:

Parameter name | Default Value | Description | Possible Values
-------------- | ------------- | ----------- | ---------------
`log_analytics_workspace_sku` | "PerGB2018" | The SKU for the Log Analytics Workspace. | PerGB2018 , Standalone , PerNode , Free , CapacityReservation
`log_analytics_logs_retention_in_days` | 30 | The number of days to retain logs in the Log Analytics Workspace. | 30 , 60 , 90 , 120 , 150 , 180 , 365 , 730 , 1827 , 3653
`enable_azure_activity_log` | true | Enable Azure Activity Log.  |  true , false
`enable_vm_insights` | true | Enable Azure Monitor for VMs.  |  true , false
`enable_azure_security_center` | true | Enable Azure Security Center.  |  true , false
`enable_container_insights` | true | Enable Azure Monitor for Containers.  |  true , false
`enable_key_vault_analytics` | true | Enable Azure Monitor for Key Vault.  |  true , false
`enable_service_map` | true | Enable Azure Monitor for Service Map.  |  true , false

### Mission Enclave - Azure Firewall Resource

By default, Mission Enclave Landing Zone Starter deploys [Azure Firewall Premium](https://docs.microsoft.com/en-us/azure/firewall/premium-features). Not all regions support Azure Firewall Premium. Check here to see if the region you're deploying to [supports Azure Firewall Premium](https://docs.microsoft.com/en-us/azure/firewall/premium-features#supported-regions). If necessary you can set a different firewall SKU or location.

The following will be created:

- Azure Firewall (main.tf)
- Required Firewall rules (main.tf)

Review and if needed, comment out and modify the variables within the "Landing Zone Configuration" section under "Management Hub Firewall" of the common variable definitions file [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-landing-zone-starter/tree/main/infrastructure/terraform/tfvars/parameters.tfvars). Do not modify if you plan to use the default values.

Example Configuration:

Parameter name | Default Value | Description | Possible Values
-------------- | ------------- | ----------- | ---------------
`enable_firewall` | true | Enable Azure Firewall.  |  true , false
`enable_forced_tunneling` | true | Enable forced tunneling.  |  true , false
`firewall_zones` | array | The availability zones to deploy the firewall to. |  1 , 2 , 3
`firewall_network_rules` | array | The network rules to create in the firewall. | 
`firewall_application_rules` | array | The application rules to create in the firewall. | 
`firewall_nat_rules` | array | The NAT rules to create in the firewall. | 

### Mission Enclave - Bastion/Private DNS Zones

If you want to remotely access the network and the resources you've deployed, you can use Azure Bastion to remotely access virtual machines within the network without exposing them via Public IP Addresses.

Deploy a Linux or Windows virtual machine as jumpboxes into the network without a Public IP Address using Azure Bastion Host by providing values for these parameters below.

The following will be created:

- Azure Bastion (main.tf)
- Private DNS Zones (main.tf)

Review and if needed, comment out and modify the variables within the "Landing Zone Configuration" section under "Bastion/Private DNS Zones" of the common variable definitions file [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-landing-zone-starter/tree/main/infrastructure/terraform/tfvars/parameters.tfvars). Do not modify if you plan to use the default values.

Example Configuration:

Parameter name | Default Value | Description | Possible Values
-------------- | ------------- | ----------- | ---------------
`enable_bastion_host` | true | Enable Azure Bastion.  |  true , false
`azure_bastion_host_sku` | "Standard" | The SKU for the Azure Bastion Host. |  Standard , Premium
`azure_bastion_subnet_address_prefix` | ["10.0.128.192/26"] | The CIDR Subnet Address Prefix for the Azure Bastion Subnet. It must be in the Hub Virtual Network space. It must be /27. This is the subnet that will be used for the Azure Bastion Host. Optional, if you do not want to deploy Azure Bastion, remove this subnet from the list. |
`hub_private_dns_zones` | array | The private DNS zones to create in the hub virtual network. |

### Mission Enclave - Identity Management Spoke Virtual Network

The following will be created:

- Resource Groups for Identity Spoke Networking
- Spoke Networks (Identity)

Review and if needed, comment out and modify the variables within the "Landing Zone Configuration" section under "Identity Management Spoke Virtual Network" of the common variable definitions file [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-landing-zone-starter/tree/main/infrastructure/terraform/tfvars/parameters.tfvars). Do not modify if you plan to use the default values.

Example Configuration:

Parameter name | Default Value | Description | Possible Values
-------------- | ------------- | ----------- | ---------------
`id_vnet_address_space` | ["10.0.130.0/24"] | The CIDR Virtual Network Address Prefix for the Identity Virtual Network.|
`id_subnets` | array | The subnets to create in the identity virtual network.|
`id_private_dns_zones` | array | The private DNS zones to create in the identity virtual network.|
`enable_forced_tunneling_on_id_route_table` | true | Enable forced tunneling on the route table.  |  true , false

### Mission Enclave - Operations Management Spoke Virtual Network

The following will be created:

- Resource Groups for Operations Spoke Networking
- Spoke Networks (Operations)

Review and if needed, comment out and modify the variables within the "Landing Zone Configuration" section under "Operations Management Spoke Virtual Network" of the common variable definitions file [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-landing-zone-starter/tree/main/infrastructure/terraform/tfvars/parameters.tfvars). Do not modify if you plan to use the default values.

Example Configuration:

Parameter name | Default Value | Description | Possible Values
-------------- | ------------- | ----------- | ---------------
`ops_vnet_address_space` | ["10.0.131.0/24"] | The CIDR Virtual Network Address Prefix for the Operations Virtual Network.|
`ops_subnets` | array | The subnets to create in the operations virtual network.|
`ops_private_dns_zones` | array | The private DNS zones to create in the operations virtual network.|
`enable_forced_tunneling_on_ops_route_table` | true | Enable forced tunneling on the route table.  |  true , false

### Mission Enclave - Security Management Spoke Virtual Network

The following will be created:

- Resource Groups for Security Spoke Networking
- Spoke Networks (Security)

Review and if needed, comment out and modify the variables within the "Landing Zone Configuration" section under "Security Management Spoke Virtual Network" of the common variable definitions file [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-landing-zone-starter/tree/main/infrastructure/terraform/tfvars/parameters.tfvars). Do not modify if you plan to use the default values.

Example Configuration:

Parameter name | Default Value | Description | Possible Values
-------------- | ------------- | ----------- | ---------------
`sec_vnet_address_space` | ["10.0.133.0/24"] | The CIDR Virtual Network Address Prefix for the Operations Virtual Network.|
`sec_subnets` | array | The subnets to create in the operations virtual network.|
`sec_private_dns_zones` | array | The private DNS zones to create in the operations virtual network.|
`enable_forced_tunneling_on_sec_route_table` | true | Enable forced tunneling on the route table.  |  true , false

### Mission Enclave - DevSecOps Management Spoke Virtual Network

The following will be created:

- Resource Groups for DevSecOps Spoke Networking
- Spoke Networks (DevSecOps)

Review and if needed, comment out and modify the variables within the "Landing Zone Configuration" section under "DevSecOps Management Spoke Virtual Network" of the common variable definitions file [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-landing-zone-starter/tree/main/infrastructure/terraform/tfvars/parameters.tfvars). Do not modify if you plan to use the default values.

Example Configuration:

Parameter name | Default Value | Description | Possible Values
-------------- | ------------- | ----------- | ---------------
`devsecops_vnet_address_space` | ["10.0.132.0/24"] | The CIDR Virtual Network Address Prefix for the DevSecOps Virtual Network. |
`devsecops_subnets` | array | The subnets to create in the devsecops virtual network. |
`devsecops_private_dns_zones` | array | The private DNS zones to create in the devsecops virtual network. |
`enable_forced_tunneling_on_devsecops_route_table` | true | Enable forced tunneling on the route table.  |  true , false
`use_remote_spoke_gateway` | false | Use a remote spoke gateway.  |  true , false

### Mission Enclave - DevSecOps Management Spoke Components

The following will be created:

- Resource Groups for DevSecOps Spoke Components
- Spoke Components (DevSecOps)

Review and if needed, comment out and modify the variables within the "Landing Zone Configuration" section under "DevSecOps Management Spoke Components" of the common variable definitions file [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-landing-zone-starter/tree/main/infrastructure/terraform/tfvars/parameters.tfvars). Do not modify if you plan to use the default values.

>NOTE: Key Vault and Bastion Jumpbox are not deployed by default. To deploy them, set the `enable_devsecops_resources` variable to `true`.

Example Configuration:

Parameter name | Default Value | Description | Possible Values
-------------- | ------------- | ----------- | ---------------
`enable_devsecops_resources` | true | Enable DevSecOps resources.  |  true , false

Example Key Vault Configuration:

Parameter name | Default Value | Description | Possible Values
-------------- | ------------- | ----------- | ---------------
`enabled_for_deployment` | true | Enable DevSecOps resources for deployment. |  true , false
`enabled_for_disk_encryption` | true | Enable DevSecOps resources for disk encryption. |  true , false
`enabled_for_template_deployment` | true | Enable DevSecOps resources for template deployment. |  true , false
`rbac_authorization_enabled` | true | Enable RBAC authorization. |  true , false
`enable_key_vault_private_endpoint` | true | Enable Key Vault private endpoint. |  true , false
`admin_group_name` | "DevSecOps Admins" | The name of the DevSecOps Admins group for use with Key Vault.| 1-64 characters

Example Bastion JumpBox Configuration:

Parameter name | Default Value | Description | Possible Values
-------------- | ------------- | ----------- | ---------------
`windows_distribution_name` | "windows2019dc" | The Windows distribution name. View Reference: <https://docs.microsoft.com/en-us/azure/virtual-machines/windows/cli-ps-findimage> | "windows2019dc" , "windows2019datacenter"
`virtual_machine_size` | "Standard_D2s_v3" | The size of the virtual machine. View Reference: <https://docs.microsoft.com/en-us/azure/virtual-machines/sizes> | "Standard_D2s_v3" , "Standard_D4s_v3"
`vm_admin_username` | "anoaadmin" | The username for the administrator account for the Bastion VM. | 1-20 characters
`vm_admin_password` | "Password1234!" | The password for the administrator account for the Bastion VM. This is a secret and used with GitHub Actions. If used for testing, it should be changed after testing.| 12-123 characters
`nsg_inbound_rules` | array | The inbound rules to create in the NSG for the Bastion VM. | "3389" , "5986"
`data_disks` | array | The data disks to create for the Bastion VM. | "P30" , "P40" , "P50"
`deploy_log_analytics_agent` | true | Deploy the Log Analytics agent for the Bastion VM. | true , false

### Mission Enclave - AMPLS Configuration

The following will be created:

- Resource Groups for AMPLS Configuration
- AMPLS Configuration

Review and if needed, comment out and modify the variables within the "Landing Zone Configuration" section under "AMPLS Configuration" of the common variable definitions file [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-landing-zone-starter/tree/main/infrastructure/terraform/tfvars/parameters.tfvars). Do not modify if you plan to use the default values.

Example Configuration:

Parameter name | Default Value | Description | Possible Values
-------------- | ------------- | ----------- | ---------------
`enable_ampls` | true | Enable AMPLS Configuration. | true , false
`ampls_subnet_address_prefixes` | ["10.0.134.0/27"] | The CIDR Subnet Address Prefix for the Azure Monitor Private Link Subnet. It must be in the Operations Virtual Network space. It must be /27.

### Mission Enclave - Microsoft Defender for Cloud Configuration

By default [Microsoft Defender for Cloud](https://docs.microsoft.com/en-us/azure/defender-for-cloud/defender-for-cloud-introduction) offers a free set of monitoring capabilities that are enabled via an Azure policy when you first set up a subscription and view the Microsoft Defender for Cloud portal blade.

Microsoft Defender for Cloud offers a standard/defender sku which enables a greater depth of awareness including more recomendations and threat analytics. You can enable this higher depth level of security in Mission Enclave Landing Zone Starter by setting the parameter deployDefender during deployment. In addition you can include the security_center_contact_email parameter to set a contact email for alerts.

The following will be created:

- Microsoft Defender for Cloud Configuration

Review and if needed, comment out and modify the variables within the "Landing Zone Configuration" section under "Microsoft Defender for Cloud Configuration" of the common variable definitions file [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-landing-zone-starter/tree/main/infrastructure/terraform/tfvars/parameters.tfvars). Do not modify if you plan to use the default values.

Example Configuration:

Parameter name | Default Value | Description | Possible Values
-------------- | ------------- | ----------- | ---------------
`enable_defender_for_cloud` | true | Enable Microsoft Defender for Cloud Configuration. | true , false
`security_center_contact_email` | "" | The email address to send alerts to for this subscription. | 1-64 characters
`security_center_contact_phone` | "" | The phone number to send alerts to for this subscription. | 1-64 characters
`security_center_alert_notifications` | true | The alert notifications to send for this subscription. | true , false
`security_center_alerts_to_admins` | true | Send alerts to admins. | true , false
`security_center_pricing_tier` | "Standard" | The pricing tier for Microsoft Defender for Cloud. | Free , Standard
`security_center_pricing_resource_types` | ["KeyVaults", "StorageAccounts", "VirtualMachines"] | The resource types to monitor with Microsoft Defender for Cloud. | "VirtualMachines", "SQLServers", "KubernetesServices", "AppServices", "StorageAccounts", "KeyVaults", "CosmosDBs", "PostgreSQLServers", "MariaDBServers", "MySQLServers", "RedisCaches", "EventHubs", "ServiceBusNamespaces", "IoTHubs", "LogicApps", "APIManagementServices", "AppServiceEnvironments", "AzureFunctions", "ContainerRegistries", "ContainerInstances", "ContainerServices", "ContainerGroups"

The Defender plan for Microsoft Defender for Cloud is enabled by default in the following [Azure Environments](https://learn.microsoft.com/powershell/module/servicemanagement/azure.service/get-azureenvironment?view=azuresmps-4.0.0): AzureCloud. To enable this for other Azure Cloud environments, this will need to executed manually. Documentation on how to do this can be found [here](https://learn.microsoft.com/azure/defender-for-cloud/enable-enhanced-security).

Learn more about [Microsoft Defender for Cloud pricing](https://azure.microsoft.com/en-us/pricing/details/defender-for-cloud/).

### Mission Enclave - Azure Service Health Configuration

The following will be created:

- Resource Groups for Service Health Configuration
- Service Health Configuration

Review and if needed, comment out and modify the variables within the "Landing Zone Configuration" section under "Azure Service Health Configuration" of the common variable definitions file [parameters.tfvars](https://github.com/azurenoops/ref-scca-enclave-landing-zone-starter/tree/main/infrastructure/terraform/tfvars/parameters.tfvars). Do not modify if you plan to use the default values.

Example Configuration:

Parameter name | Default Value | Description | Possible Values
-------------- | ------------- | ----------- | ---------------
`enable_service_health_monitoring` | true | Enable Service Health Configuration. | true | false
`action_group_short_name` | "anoa" | The short name for the action group. | 1-12 characters
