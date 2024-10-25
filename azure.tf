resource "azurerm_resource_group" "uninstance" {
  name     = "uninstance"
  location = var.azure_region
}

resource "azurerm_network_security_group" "uninstance" {
  name                = "uninstance-firewall"
  location            = azurerm_resource_group.uninstance.location
  resource_group_name = azurerm_resource_group.uninstance.name

  security_rule {
    name                         = "allow-all-tcp-inbound-ipv4"
    priority                     = 100
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_ranges           = ["0-65535"]
    source_address_prefixes      = ["0.0.0.0/0"]
    destination_address_prefixes = ["0.0.0.0/0"]
    destination_port_ranges      = ["0-65535"]
  }

  security_rule {
    name                         = "allow-all-udp-inbound-ipv4"
    priority                     = 110
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "Udp"
    source_port_ranges           = ["0-65535"]
    source_address_prefixes      = ["0.0.0.0/0"]
    destination_address_prefixes = ["0.0.0.0/0"]
    destination_port_ranges      = ["0-65535"]
  }

  security_rule {
    name                         = "allow-all-tcp-inbound-ipv6"
    priority                     = 120
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_ranges           = ["0-65535"]
    source_address_prefixes      = ["::/0"]
    destination_address_prefixes = ["::/0"]
    destination_port_ranges      = ["0-65535"]
  }

  security_rule {
    name                         = "allow-all-udp-inbound-ipv6"
    priority                     = 130
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "Udp"
    source_port_ranges           = ["0-65535"]
    source_address_prefixes      = ["::/0"]
    destination_address_prefixes = ["::/0"]
    destination_port_ranges      = ["0-65535"]
  }
}

resource "azurerm_virtual_network" "uninstance" {
  name                = "uninstance-vnet"
  address_space       = ["10.0.0.0/16", "fd00::/8"]
  location            = azurerm_resource_group.uninstance.location
  resource_group_name = azurerm_resource_group.uninstance.name
}

resource "azurerm_subnet" "uninstance" {
  name                 = "uninstance-subnet"
  resource_group_name  = azurerm_resource_group.uninstance.name
  virtual_network_name = azurerm_virtual_network.uninstance.name
  address_prefixes     = ["10.0.1.0/24", "fd00::/64"]
}

resource "azurerm_subnet_network_security_group_association" "uninstance" {
  subnet_id                 = azurerm_subnet.uninstance.id
  network_security_group_id = azurerm_network_security_group.uninstance.id
}

resource "azurerm_public_ip" "alma_azure_pvm_node_1_ip_ipv4" {
  name                = "alma-azure-pvm-node-1-ip-ipv4"
  location            = azurerm_resource_group.uninstance.location
  resource_group_name = azurerm_resource_group.uninstance.name
  allocation_method   = "Static"
  sku                 = "Standard"
  ip_version          = "IPv4"
}

resource "azurerm_public_ip" "alma_azure_pvm_node_1_ip_ipv6" {
  name                = "alma-azure-pvm-node-1-ip-ipv6"
  location            = azurerm_resource_group.uninstance.location
  resource_group_name = azurerm_resource_group.uninstance.name
  allocation_method   = "Static"
  sku                 = "Standard"
  ip_version          = "IPv6"
}

resource "azurerm_network_interface" "alma_azure_pvm_nic" {
  name                = "alma-azure-pvm-node-1-nic"
  location            = azurerm_resource_group.uninstance.location
  resource_group_name = azurerm_resource_group.uninstance.name

  ip_configuration {
    name                          = "ipv4"
    subnet_id                     = azurerm_subnet.uninstance.id
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv4"
    public_ip_address_id          = azurerm_public_ip.alma_azure_pvm_node_1_ip_ipv4.id
    primary                       = true
  }

  ip_configuration {
    name                          = "ipv6"
    subnet_id                     = azurerm_subnet.uninstance.id
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv6"
    public_ip_address_id          = azurerm_public_ip.alma_azure_pvm_node_1_ip_ipv6.id
  }
}

resource "azurerm_linux_virtual_machine" "alma_azure_pvm_node_1" {
  name                  = "alma-azure-pvm-node-1"
  resource_group_name   = azurerm_resource_group.uninstance.name
  location              = azurerm_resource_group.uninstance.location
  size                  = "Standard_B2s"
  admin_username        = "pojntfx"
  network_interface_ids = [azurerm_network_interface.alma_azure_pvm_nic.id]

  admin_ssh_key {
    username   = "pojntfx"
    public_key = file(var.ssh_public_key)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "almalinux"
    offer     = "almalinux-x86_64"
    sku       = "9-gen2"
    version   = "latest"
  }

  computer_name                   = "alma-azure-pvm-node-1"
  disable_password_authentication = true

  custom_data = base64encode(file("cloud-init-alma-azure.yaml"))
}
