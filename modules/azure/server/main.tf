resource "azurerm_resource_group" "this" {
  provider = azurerm.primary
  name     = "${var.name}-resource-group"

  location = var.location
}

resource "azurerm_network_security_group" "this" {
  provider = azurerm.primary
  name     = "${var.name}-firewall"

  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

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

  depends_on = [azurerm_resource_group.this]
}

resource "azurerm_virtual_network" "this" {
  provider = azurerm.primary
  name     = "${var.name}-vnet"

  address_space       = ["10.0.0.0/16", "fd00::/8"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  depends_on = [azurerm_resource_group.this]
}

resource "azurerm_subnet" "this" {
  provider = azurerm.primary
  name     = "${var.name}-subnet"

  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.1.0/24", "fd00::/64"]

  depends_on = [
    azurerm_resource_group.this,
    azurerm_virtual_network.this,
  ]
}

resource "azurerm_subnet_network_security_group_association" "this" {
  provider = azurerm.primary

  subnet_id                 = azurerm_subnet.this.id
  network_security_group_id = azurerm_network_security_group.this.id

  depends_on = [
    azurerm_resource_group.this,
    azurerm_subnet.this,
    azurerm_network_security_group.this
  ]
}

resource "azurerm_public_ip" "ipv4_address" {
  provider = azurerm.primary
  name     = "${var.name}-ipv4-address"

  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
  sku                 = "Standard"
  ip_version          = "IPv4"

  depends_on = [azurerm_resource_group.this]
}

resource "azurerm_public_ip" "ipv6_address" {
  provider = azurerm.primary
  name     = "${var.name}-ipv6-address"

  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
  sku                 = "Standard"
  ip_version          = "IPv6"

  depends_on = [azurerm_resource_group.this]
}

resource "azurerm_network_interface" "this" {
  provider = azurerm.primary
  name     = "${var.name}-nic"

  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "ipv4"
    subnet_id                     = azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv4"
    public_ip_address_id          = azurerm_public_ip.ipv4_address.id
    primary                       = true
  }

  ip_configuration {
    name                          = "ipv6"
    subnet_id                     = azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv6"
    public_ip_address_id          = azurerm_public_ip.ipv6_address.id
  }

  depends_on = [azurerm_resource_group.this]
}

resource "azurerm_linux_virtual_machine" "this" {
  provider = azurerm.primary
  name     = var.name

  resource_group_name   = azurerm_resource_group.this.name
  location              = azurerm_resource_group.this.location
  size                  = var.size
  admin_username        = "pojntfx"
  network_interface_ids = [azurerm_network_interface.this.id]

  admin_ssh_key {
    username   = "pojntfx"
    public_key = var.public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  computer_name                   = var.name
  disable_password_authentication = true

  custom_data = base64encode(var.user_data)

  depends_on = [azurerm_resource_group.this]
}
