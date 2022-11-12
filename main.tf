terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"

  backend "azurerm" {
    resource_group_name  = "tf-blobstore-rg"
    storage_account_name = "tfstoragesmishra"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "resource-group"
  location = "South India"
}

resource "azurerm_container_group" "cg" {
  name                = "weatherapi"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_address_type = "Public"
  dns_name_label  = "souryamishra-weather-api"
  os_type         = "Linux"

  container {
    name   = "weatherapi"
    image  = "${var.imageName}:${var.imageBuild}"
    cpu    = "1"
    memory = "1"
    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}