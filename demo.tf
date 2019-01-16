##
# Configure the Microsoft Azure Provider
#
# See https://www.terraform.io/docs/providers/azurerm
##

provider "azurerm" {
  # Terraform needs to know the Azure credentials:
  #
  #   * subscription_id
  #   * client_id
  #   * client_secret
  #   * tenant_id
  #
  # Terraform supports a number of different methods for authenticating to Azure:
  #
  #   * Using the Azure CLI
  #   * Using a Managed Service Identity
  #   * Using a Service Principal and a Client Certificate
  #   * Using a Service Principal and a Client Secret
  #
  # When we run Terraform automatically (such as in a CI server) we recommend
  # authentication using a Service Principal or Managed Service Identity.
  #
  # When we run Terraform interactively (such as on a command line) we recommend
  # authenticating using the Azure CLI when running Terraform locally.
  #
  # Arguments:
  #
  #   * client_id - (Optional) The Client ID which should be used.
  #     This can also be sourced from the ARM_CLIENT_ID Environment Variable.
  #
  #   * subscription_id - (Optional) The Subscription ID which should be used.
  #     This can also be sourced from the ARM_SUBSCRIPTION_ID Environment Variable.
  #
  #   * tenant_id - (Optional) The Tenant ID which should be used.
  #     This can also be sourced from the ARM_TENANT_ID Environment Variable.
  #
  #   * environment - (Optional) The Cloud Environment which should be used.
  #     Possible values are public, usgovernment, german and china. Defaults to public.
  #     This can also be sourced from the ARM_ENVIRONMENT environment variable.
  #
  # When authenticating as a Service Principal using a Client Secret,
  # the following fields can be set:
  #
  #   * client_secret - (Optional) The Client Secret which should be used.
  #     This can also be sourced from the ARM_CLIENT_SECRET Environment Variable.
  #
  # If you choose to put arguments in environment varaiables,
  # then here's one way to do it:
  #
  #     export ARM_SUBSCRIPTION_ID=""
  #     export ARM_CLIENT_ID=""
  #     export ARM_CLIENT_SECRET=""
  #     export ARM_TENANT_ID=""
  #     export ARM_ENVIRONMENT="public"
  #
  # If you choose to put the credentials in this configuration file,
  # then here are the lines:
  #
  #     subscription_id = "..."
  #     client_id = ""
  #     client_secret = ""
  #     tenant_id = ""
  #     environment="public"
}

##
# Create a resource group.
#
# We must do this first, because the resource group
# is what connects all the rest for the resources.
##

resource "azurerm_resource_group" "demo" {
  name = "demo-resource-group"
  location = "West US"
}

##
# Create a virtual network.
#
# This needs the resource group.
# This is is needed by the internal subnet.
#
# This example also shows how to create a few subnets at
# the same time as the virtual network; this is optional.
# This demo does not do anything with these subnets.
##

resource "azurerm_virtual_network" "demo" {
  name = "demo-virtual-network"
  address_space = ["10.0.0.0/16"]
  location = "${azurerm_resource_group.demo.location}"
  resource_group_name = "${azurerm_resource_group.demo.name}"
  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }
  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
  }
  subnet {
    name           = "subnet3"
    address_prefix = "10.0.3.0/24"
  }
}

##
# Create an internal subnet.
#
# This needs the virtual network.
# This is needd by the network interface.
##

resource "azurerm_subnet" "internal" {
  name = "demo-subnet"
  resource_group_name = "${azurerm_resource_group.demo.name}"
  virtual_network_name = "${azurerm_virtual_network.demo.name}"
  address_prefix = "10.0.2.0/24"
}

##
# Create a network interface.
#
# We must do this before we create any virtual machines,
# because the virtual machine needs the network interface id.
##

resource "azurerm_network_interface" "demo" {
  name = "demo-network-interface"
  location = "${azurerm_resource_group.demo.location}"
  resource_group_name = "${azurerm_resource_group.demo.name}"
  ip_configuration {
    name = "demo-ip-configuration"
    subnet_id = "${azurerm_subnet.internal.id}"
    private_ip_address_allocation = "Dynamic"
  }
}

##
# Create a virtual machine.
#
# For the operating system, we like to demo using Ubuntu server,
# and with the current Long Term Support (LTS) version.
##

resource "azurerm_virtual_machine" "demo" {
  name = "demo-virtual-machine"
  location = "${azurerm_resource_group.demo.location}"
  resource_group_name = "${azurerm_resource_group.demo.name}"
  network_interface_ids = ["${azurerm_network_interface.demo.id}"]
  vm_size = "Standard_DS1_v2"
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true
  storage_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "18.04-LTS"
    version = "latest"
  }
  storage_os_disk {
    name = "myosdisk1"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }  
  os_profile {
    computer_name  = "hostname"
    admin_username = "admin"
    admin_password = "secret"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags {
    environment = "staging"
  }
}
