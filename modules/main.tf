terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.38.0"
    }
  }

     backend "azurerm" {
    resource_group_name  = "aks-rg"
    storage_account_name = "aksstorrage"
    container_name       = "aks-container"
    key                  = "terraform.tfstate"
}



}

provider "azurerm" {
  features {}
  subscription_id = "a29ac6ee-0d4f-41fe-8359-df26a6fce56c"


}


resource "azurerm_resource_group" "aks-rg" {
  name     = var.resource_group_name
  location = var.location

}



resource "azurerm_virtual_network" "aks-vnet" {
  depends_on          = [azurerm_resource_group.aks-rg]
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]

}


resource "azurerm_subnet" "aks-subnet" {
    depends_on = [ azurerm_virtual_network.aks-vnet ]
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.0.0.0/24"]
}


resource "azurerm_network_interface" "aks-nic" {
  name                = var.virtua_interface
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.aks-subnet.id
    private_ip_address_allocation = "Dynamic"
  }

}