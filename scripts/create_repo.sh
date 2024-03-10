#!/bin/bash

set -eu

module_name=$1

gh repo create "Azure NoOps/terraform-azurerm-$module_name" \
  --public \
  --template Azure NoOps/terraform-module-template

source ./configure_repo.sh "$module_name"
