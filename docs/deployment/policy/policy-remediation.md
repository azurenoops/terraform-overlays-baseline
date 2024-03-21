# Policy Remediation

Policy remediation is the process of correcting non-compliant resources to bring them into compliance with the defined policies. Remediation can be performed manually or automatically, depending on the nature and severity of the non-compliance. Azure NoOps provides guidance on best practices for policy remediation to help organizations ensure that their resources remain secure and compliant.

## Manual Remediation

Manual remediation involves identifying non-compliant resources and taking the necessary actions to correct them. This may involve modifying the resource configuration, deleting the resource, or taking other corrective measures. Manual remediation is often used for non-critical or one-off issues that do not require immediate attention.

## Automatic Remediation

Automatic remediation involves using automation tools to identify and correct non-compliant resources automatically. This can be achieved using policy as code (PaC) and infrastructure as code (IaC) tools, such as Terraform, to define the desired state of the resources and automatically apply the necessary changes to bring them into compliance.

Automatic remediation is often used for critical or recurring issues that require immediate attention. It can help ensure that non-compliant resources are corrected quickly and consistently, reducing the risk of security breaches and compliance violations.

[Azure NoOps Policy Module](https://github.com/azurenoops/terraform-azurerm-overlays-policy) provides a set of policy definitions, initatives and remediation tasks that can be used to automatically remediate non-compliant resources in Azure. These policy definitions and remediation tasks are designed to help organizations enforce security and compliance standards across their Azure environment.

## Best Practices for Policy Remediation

When implementing policy remediation, consider the following best practices:

- **Define clear remediation actions**: Clearly define the actions that need to be taken to bring non-compliant resources into compliance. This may include modifying resource configurations, deleting resources, or taking other corrective measures.

- **Automate where possible**: Whenever possible, use automation tools to automatically identify and correct non-compliant resources. This can help ensure that remediation is performed consistently and quickly, reducing the risk of security breaches and compliance violations.

- **Monitor and audit remediation**: Regularly monitor and audit the remediation process to ensure that non-compliant resources are being corrected effectively. This can help identify any issues or gaps in the remediation process and ensure that resources remain in compliance.

- **Document remediation procedures**: Document the procedures for identifying and correcting non-compliant resources, including the steps to be taken and the tools to be used. This can help ensure that remediation is performed consistently and effectively, even in the absence of the original remediation team.