# FAQs

## How much does a typical deployment cost?

The Mission Enclave Landing Zone starter Terraform module covers many different deployment scenarios, so costs can vary dramatically depending on what options are configured.

Some of these costs can come from resources deployed directly by the module.
Other costs may be incurred when Azure Policy performs remediation of non-compliant resources within scope of the deployment.

If you are looking to reduce costs as part of evaluating the module, we recommend assessing whether your evaluation needs to implement the following common resources which can incur the highest costs include:

- Microsoft Defender for Cloud
- Azure DDoS Network Protection
- Azure Firewall

Although our starters try to minimize the use of these resources and to use lower cost SKUs where applicable, please take care to ensure you understand which resources are being deployed and the associated costs these will incur.

In large environments, costs can also increase when large volumes of data are being stored in the Log Analytics workspace.
