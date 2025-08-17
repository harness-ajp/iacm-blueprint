terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Configure the Microsoft Azure Provider.
# Authentication is handled automatically via the Azure CLI, environment variables, or a managed identity.
provider "azurerm" {
  features {}
}

# 1. Create a Resource Group
# All Azure resources must be placed in a resource group.
resource "azurerm_resource_group" "rg" {
  name     = "aj-iacm-rg"
  location = "westus" 
}

# 2. Create a Virtual Network (VNet)
# The VMs need a network to communicate.
resource "azurerm_virtual_network" "vnet" {
  name                = "aj-iacm-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# 3. Create a Subnet
# A subnet is a range of IP addresses within the VNet.
resource "azurerm_subnet" "subnet" {
  name                 = "default-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# 4. Create Network Interfaces (NICs)
# We use the 'count' meta-argument to create two NICs, one for each VM.
resource "azurerm_network_interface" "nic" {
  count               = 1
  name                = "aj-iacm-nic-${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# 5. Create Linux Virtual Machines
# This block also uses 'count' to provision two identical VMs.
resource "azurerm_linux_virtual_machine" "vm" {
  count               = 1
  name                = "aj-iacm-instance-${count.index}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B1s" # One of the smallest and cheapest VM sizes.
  admin_username      = "azureuser"

  # Each VM gets its corresponding NIC from the resource created above.
  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id,
  ]

  # This section defines authentication using an SSH public key.
  # Make sure you have a key at the specified path or update the path.
  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  # This defines the OS disk for the VM.
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # This specifies the Ubuntu 22.04 LTS image from the Azure Marketplace.
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}
