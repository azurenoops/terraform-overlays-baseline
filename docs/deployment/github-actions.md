# Azure NoOps GitHub Actions

## Overview

This document provides guidance on how to use GitHub Actions to automate the deployment of Azure NoOps resources.

## What's CI/CD?

CI/CD stands for _Continuous Integration_ and _Continuous Delivery_.

Continuous Integration is a software development practice that requires developers to integrate code into a shared repository several times a day.
Each integration can then be verified by an automated build and automated tests.
By doing so, you can detect errors quickly, and locate them more easily.

Continuous Delivery pushes this practice further, by preparing for a release to production after each successful build.
By doing so, you can get working software into the hands of users faster.

## What's GitHub Actions?

[GitHub Actions](https://github.com/features/actions) is a service that lets you automate your software development workflows.
It allows you to run workflows that can be triggered by any event on the GitHub platform, such as opening a pull request or pushing a commit to a repository.

It's a great way to automate your CI/CD pipelines, and it's free for public repositories.

## Workflows

All the GitHub Actions for Azure NoOps are stored in the `.github/workflows` directory of the certain starters and add-on projects. These are the automated workflows we use for ensuring a quality working product. We use GitHub Actions to automate the process of building, testing, and deploying the infrastructure.

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
