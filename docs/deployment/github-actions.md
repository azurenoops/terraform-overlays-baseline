# Azure NoOps GitHub Actions

## Overview

All the GitHub Actions for Azure NoOps are stored in the `.github/workflows` directory of the certain starters and add-on projects. These are the automated workflows we use for ensuring a quality working product. We use GitHub Actions to automate the process of building, testing, and deploying the infrastructure.

## Workflows

These are the automated workflows we use for ensuring a quality working product. All workflows are part of a suite of terraform related actions - find them at <https://github.com/azurenoops/terraform-github-actions>

For more on GitHub Actions: <https://docs.github.com/en/actions/>

For more on workflows: <https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions/>

## Contents

- create_plan.yml (`This actions generates a terraform plan. If the triggering event relates to a PR it will add a comment on the PR containing the generated plan.`)

    This workflow assumes some pre-requisites have been set-up. See: [Configuration Prerequisites](#configuration-prerequisites)

    1. Authenticates against a pre-configured storage account that contains
        - values for authenticating against a storage account
        - values for deploying terraform

- apply_plan.yml (`This action applies a terraform plan. The default behaviour is to apply the plan that has been added to a PR using the terraform-plan action.If the plan is not found or has changed, then the apply action will fail. This is to ensure that the action only applies changes that have been reviewed by a human.`)

    This workflow assumes some pre-requisites have been set-up. See: [Configuration Prerequisites](#configuration-prerequisites)

    1. Authenticates against a pre-configured storage account that contains
        - values for authenticating against a storage account
        - values for deploying terraform

    1. Pulls known good MELZ and Terraform configuration variables from that storage account

    1. Applies terraform anew from that configuration.

- check_for_drift.yml (`Check for drift in terraform managed resources. This action runs the terraform plan command, and fails the build if any changes are required. This is intended to run on a schedule to notify if manual changes to your infrastructure have been made.`)

    1. Checks for drift in the infrastructure/terraform directory

- destroy_plan.yml (`This action uses the terraform destroy command to immediately destroy all resources in a terraform workspace.`)

    1. Destroys the terraform configuration

- validate_plan.yml (`This action uses the terraform validate command to check that a terraform configuration is valid. This can be used to check that a configuration is valid before creating a plan.`)

    1. Recursively validates and lints all the terraform referenced at infrastructure/terraform

## Configuration Prerequisites

1. Configuration store

    When applying terraform locally or from this automation, an MELZ Configuration file (commonly melz.config) and Terraform-specific variables files (commonly *.tfvars) are required.

- deploy_dependencies.yml

    1. Builds and deploys the dependencies for the terraform configuration
