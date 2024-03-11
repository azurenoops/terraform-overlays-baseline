# Module Testing

This document provides guidance on how to test an Azure NoOps overlay module.

## Testing

### Unit testing

Unit testing is the process of testing individual units or components of a module. It is a testing technique that is used to test the smallest part of a module. In the context of Terraform, this means testing the individual resources and modules that make up the module.

#### Terraform testing

Terraform has built-in support for unit testing through the use of the `terraform validate` command. This command checks the configuration files for syntax errors and other issues, and can be used to verify that the configuration is valid.

To run the `terraform validate` command, use the following command:

```bash
terraform validate
```

This command will check the configuration files in the current directory for syntax errors and other issues.

### Integration testing

Integration testing is the process of testing the integration of different components of a module. In the context of Terraform, this means testing the interaction between different resources and modules.

#### Terraform testing

Terraform has built-in support for integration testing through the use of the `terraform plan` and `terraform apply` commands. These commands can be used to create a plan for the changes that will be made to the infrastructure, and to apply those changes.

To run the `terraform plan` command, use the following command:

```bash
terraform plan
```

This command will create a plan for the changes that will be made to the infrastructure.

To apply the changes, use the following command:

```bash
terraform apply
```

This command will apply the changes to the infrastructure.

### End-to-end testing

End-to-end testing is the process of testing a complete module in a production-like environment. In the context of Terraform, this means testing the complete module in a real environment.

#### Terraform testing

Terraform has built-in support for end-to-end testing through the use of the `terraform apply` command. This command can be used to apply the complete module to a real environment.

To apply the complete module, use the following command:

```bash
terraform apply
```

This command will apply the complete module to a real environment.

## Automated tests

- Automated tests should be implemented for all variants of the relevant resource using [Terratest](https://terratest.gruntwork.io/). For example, in the `storage` module, automated tests should be implemented for standard GPv2 storage, premium GPv2 storage, standard blob storage, premium block blob storage and premium file storage.

## Best practices

When testing an Azure NoOps overlay module, consider the following best practices:

- Use the `terraform validate` command to check the configuration files for syntax errors and other issues.
- Use the `terraform plan` command to create a plan for the changes that will be made to the infrastructure.
- Use the `terraform apply` command to apply the changes to the infrastructure.
- Use the `terraform destroy` command to destroy the infrastructure after testing.
- Use the `terraform fmt` command to format the configuration files before testing.

## Next steps

For more information on testing Terraform modules, see the [Terraform documentation](https://www.terraform.io/docs/cli/commands/index.html).
[