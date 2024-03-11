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

## Code examples of resource

### Usage of for_each with map

```terraform
resource "azurerm_virtual_machine" "example" {
  for_each = var.create_vm ? {
    a = "a",
    b = "b",
    c = "c"
  } : {}
  name                  = "${var.create_vm ? "example" : "none"}-${each.key}"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  .
  .
  .
}
```

### Usage of for_each with list

```terraform
resource "azurerm_virtual_machine" "example" {
  for_each = var.create_vm ? ["a", "b", "c"] : []
  name                  = "${var.create_vm ? "example" : "none"}-${each.value}"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  .
  .
  .
}
```

### Usage of for_each with set

```terraform
resource "azurerm_virtual_machine" "example" {
  for_each = var.create_vm ? toset(["a", "b", "c"]) : toset([])
  name                  = "${var.create_vm ? "example" : "none"}-${each.value}"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  .
  .
  .
}
```

### Usage of for_each with a module

```terraform
module "example" {
  for_each = var.create_vm ? {
    a = "a",
    b = "b",
    c = "c"
  } : {}
  source = "./modules/vm"
  name                  = "${var.create_vm ? "example" : "none"}-${each.key}"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  .
  .
  .
}
```

### Usage of for_each with a module and count

```terraform
module "example" {
  count = var.create_vm ? 3 : 0
  for_each = var.create_vm ? {
    a = "a",
    b = "b",
    c = "c"
  } : {}
  source = "./modules/vm"
  name                  = "${var.create_vm ? "example" : "none"}-${each.key}"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  .
  .
  .
}
```

## Conditions in count

Count should be used to create multiple instances of the same resource. It should not be used to create different resources based on a condition. Use for_each for that. 

```terraform
resource "azurerm_virtual_machine" "example" {
  count = var.create_vm ? 1 : 0
  name                  = "${var.create_vm ? "example" : "none"}"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  .
  .
  .
}
```

## Placement of tags

Tags should be placed in the resource module, not in the infrastructure module. This is because tags are specific to the resource and not to the infrastructure. The infrastructure module should not have any tags.

### Code examples of tags

```terraform
resource "azurerm_virtual_machine" "example" {
  name                  = "example"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  .
  .
  .
  tags = {
    environment = "staging"
  }
}
```

## Usage of locals

Locals are used to define values that are used in multiple places in the configuration. They are used to avoid repeating the same value in multiple places. They are also used to define complex values that are used in multiple places in the configuration.

### Code examples of locals

```terraform
locals {
  vm_name = "example"
  vm_location = azurerm_resource_group.example.location
  vm_resource_group_name = azurerm_resource_group.example.name
}
```

## Variables

- Don't reinvent the wheel in resource modules: use name, description, and default value for variables as defined in the "Argument Reference" section for the resource you are working with.

- Support for validation in variables is rather limited (e.g. can't access other variables or do lookups). Plan accordingly because in many cases this feature is useless.

- Use the plural form in a variable name when type is list(...) or map(...).

- Order keys in a variable block like this: description , type, default, validation.

- Always include description on all variables even if you think it is obvious (you will need it in the future).

- Prefer using simple types (number, string, list(...), map(...), any) over specific type like object() unless you need to have strict constraints on each key.

- Use specific types like map(map(string)) if all elements of the map have the same type (e.g. string) or can be converted to it (e.g. number type can be converted to string).

- Use type any to disable type validation starting from a certain depth or when multiple types should be supported.

- Value {} is sometimes a map but sometimes an object. Use tomap(...) to make a map because there is no way to make an object.

### Code examples of variables

```terraform
variable "storage_account_name" {
  description = "The name of the Storage Account."
  type        = string
  default     = "example"
}
```

## Outputs

Make outputs consistent and understandable outside of its scope (when a user is using a module it should be obvious what type and attribute of the value it returns).

- The name of output should describe the property it contains and be less free-form than you would normally want.

- Good structure for the name of output looks like {name}_{type}_{attribute} , where:

  - {name} is the name of the resource or module
  - {type} is the type of the resource or module
  - {attribute} is the attribute of the resource or module

- Always include description on all outputs even if you think it is obvious (you will need it in the future).

- Order keys in an output block like this: description , value.

- Use the plural form in an output name when type is list(...) or map(...).

- Use specific types like map(map(string)) if all elements of the map have the same type (e.g. string) or can be converted to it (e.g. number type can be converted to string).

- Use type any to disable type validation starting from a certain depth or when multiple types should be supported.

- Value {} is sometimes a map but sometimes an object. Use tomap(...) to make a map because there is no way to make an object.

### Code examples of output

```terraform
output "storage_account_id" {
  description = "The ID of the Storage Account."
  value       = azurerm_storage_account.example.id
}
```

#### Use plural name if the returning value is a list

```terraform
output "storage_account_ids" {
  description = "The IDs of the Storage Accounts."
  value       = azurerm_storage_account.example.*.id
}
```