# Mission Enclave Policy Starter

The Mission Enclave Policy Starter Terraform module provides an opinionated approach for deploying and managing the core platform capabilities of Azure Policy using Terraform, with a focus on the central resource hierarchy:

## Architecture

![Architecture](../img/normalized-architecture.png)

## Design areas

The Mission Enclave Policy Starter Terraform module is designed to address the following areas:

[Resource organization](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org)

- Create custom Policy Assignments, Policy Definitions and Policy Set Definitions (Initiatives)

[Identity and access management](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access)

- Secure the identity subscription using Azure Policy
