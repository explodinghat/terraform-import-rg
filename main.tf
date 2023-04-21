terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.52.0"
    }
  }
}

provider "azurerm" {
  # if we're working in an environment with limited permissions (like acloudguru), we add below line to prevent errors
  skip_provider_registration = true
  features {}
}

/* We use 'data' to leverage existing resources whose lifecycle we don't want to incorporate into terraform, as below.
If we want to leverage existing resources and bring those into the terraform lifecycle, we would instead add the resource
to the file as a 'resource' block, then run 'terraform import [resource ID] from the commandline to bring the resource 
into the state file. Terraform destroy will subsequently destroy this resource(s). */
  
data "azurerm_resource_group" "rg" {
  name = "[paste-existing-rg-here]"
}

resource "azurerm_storage_account" "sa" {
  name                     = "[create-storage-acc-name-here]"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
