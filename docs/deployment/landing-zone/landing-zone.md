# Mission Enclave Landing Zone Starter

The Mission Enclave Landing Zone Starter Composition Terraform module provides an opinionated approach for deploying and managing the core platform capabilities of Azure landing zones architecture using Terraform, with a focus on the central resource hierarchy.

## Architecture

![Architecture](../../img/normalized-architecture.png)

## Design areas

The Mission Enclave Landing Zone Starter Terraform module is designed to address the following areas:

[Resource organization](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org)

- Create the Management Group resource hierarchy
- Assign Subscriptions to Management Groups
- Budgets and Cost Management

[Identity and access management](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access)

- Create custom Role Assignments and Role Definitions

[Management](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/management)

- Create a central Log Analytics workspace and Automation Account
- Link Log Analytics workspace to the Automation Account
- Deploy recommended Log Analytics Solutions
- Azure Monitor Link Scopes

[Network topology and connectivity](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/networking)

- Create a centralized hub network
- Traditional Azure networking topology (hub and spoke)
- Secure network design that follow the principles of SCCA/Zero Trust Network
- Azure Firewall
- DDoS Network Protection
- Centrally managed DNS zones
