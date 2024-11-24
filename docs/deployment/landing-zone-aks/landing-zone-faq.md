# FAQs

## How long does landing zone take to deploy?

Deployment time depends on the options you select in your configuration. It varies from around five minutes to 40 minutes, depending on the configuration selected.

## Why does the Mission Enclave Landing Zone Starter with Azure Kubernetes Service implementation require permission at tenant root '/' scope?

Management group creation, subscription creation, and placing subscriptions into management groups are APIs that operate at the tenant root "`/`" scope.

To establish the management group hierarchy and create subscriptions and place them into the defined management groups, the initial deployment must be invoked at the tenant root "`/`" scope. Once you deploy enterprise-scale architecture, you can remove the owner permission from the tenant root "`/`" scope. The user deploying the enterprise-scale reference implementation is made an owner at the intermediate root management group (for example "Contoso").

For more information about tenant-level deployments in Azure, see [Deploy resources to tenant](https://learn.microsoft.com/azure/azure-resource-manager/templates/deploy-to-tenant).

## How much does a typical deployment cost?

The Mission Enclave Landing Zone Starter with Azure Kubernetes Service Terraform module covers many different deployment scenarios, so costs can vary dramatically depending on what options are configured.

Some of these costs can come from resources deployed directly by the module.
Other costs may be incurred when Azure Policy performs remediation of non-compliant resources within scope of the deployment.

If you are looking to reduce costs as part of evaluating the module, we recommend assessing whether your evaluation needs to implement the following common resources which can incur the highest costs include:

- Microsoft Defender for Cloud
- Azure DDoS Network Protection
- Azure Firewall

Although our starters try to minimize the use of these resources and to use lower cost SKUs where applicable, please take care to ensure you understand which resources are being deployed and the associated costs these will incur.

In large environments, costs can also increase when large volumes of data are being stored in the Log Analytics workspace.

