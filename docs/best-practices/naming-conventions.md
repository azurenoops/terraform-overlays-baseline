# Naming conventions

## General conventions

> **Hint:** There should be no reason to not follow at least these conventions. They are simple and make the code more readable and maintainable.

> **Hint:** Beware that actual cloud resources often have restrictions in allowed names. Some resources, for example, can't contain dashes, some must be camel-cased. Always check the documentation for the resource you are working with.

1. Use `_` (underscore) instead of `-` (dash) everywhere (in resource names, data source names, variable names, outputs, etc).
2. Prefer to use lowercase letters and numbers (even though UTF-8 is supported).

## Resource and data source arguments

1. Do not repeat resource type in resource name (not partially, nor completely):

    > **Good**

    ```
    `resource "azurerm_route_table" "public" {}`
    ```

    > **Bad**

    ```
    `resource "azurerm_route_table" "public_route_table" {}`
    ```

    > **Bad**

    ```
    `resource "azurerm_route_table" "public_azurerm_route_table" {}`
    ```

2. Resource name should be named `this` if there is no more descriptive and general name available, or if the resource module creates a single resource of this type (eg, in [azurerm VPC module](https://github.com/terraform-azurerm-modules/terraform-azurerm-virtual-network) there is a single resource of type `azurerm_nat_gateway` and multiple resources of type`azurerm_route_table`, so `azurerm_nat_gateway` should be named `this` and `azurerm_route_table` should have more descriptive names - like `private`, `public`, `database`).

3. Always use singular nouns for names.

4. Use `-` inside arguments values and in places where value will be exposed to a human (eg, inside DNS name of RDS instance).

5. Include argument `count` / `for_each` inside resource or data source block as the first argument at the top and separate by newline after it.

6. Include argument `tags,` if supported by resource, as the last real argument, following by `depends_on` and `lifecycle`, if necessary. All of these should be separated by a single empty line.

7. When using conditions in an argument`count` / `for_each` prefer boolean values instead of using `length` or other expressions.

## Code examples of `resource`

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