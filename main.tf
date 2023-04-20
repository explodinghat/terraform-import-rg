terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.52.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

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
