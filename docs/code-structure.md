# Code Structure

Getting started with the structuring of Terraform configurations can be a bit daunting. This guide will help you understand the basic concepts and best practices for structuring your Terraform configurations.

## Getting started with the structuring of Terraform configurations

Terraform configurations can be structured in many ways. The best way to structure your Terraform configurations depends on the size of your infrastructure, the number of environments you are managing, and the number of people who are working on the configurations.

The following are some of the best practices for structuring your Terraform configurations in Azure NoOps overlay modules:

Putting all code in main.tf is a good idea when you are getting started or writing an example code. In all other cases you will be better having several files split logically like this:

main.tf - call modules, locals, and data sources to create all resources

variables.tf - contains declarations of variables used in main.tf

outputs.tf - contains outputs from the resources created in main.tf

versions.tf - contains version requirements for Terraform and providers

terraform.tfvars should not be used anywhere except composition.