networking = {
  "vnet1" = {
    vnet_name                        = "Test-Vnet1"
    address_space                    = ["10.0.0.0/16", "101.0.0.0/16"]
    location                         = "eastus2"
    resource_group                   = "myResourceGroup-Network"
    resource_group_creation_required = true
    subnets = {
      "subnet1" = {
        name             = "Test-Subnet1"
        address_prefixes = ["10.0.1.0/24"]
      },
      "subnet2" = {
        name             = "Test-Subnet2"
        address_prefixes = ["10.0.2.0/24"]
      }
    }
  },
  "vnet2" = {
    vnet_name                        = "Test-Vnet2"
    address_space                    = ["10.1.0.0/16"]
    location                         = "eastus2"
    resource_group                   = "myResourceGroup-Network2"
    resource_group_creation_required = true
    subnets = {
      "subnet1" = {
        name             = "Test-Subnet1"
        address_prefixes = ["10.1.1.0/24"]
      },
      "subnet2" = {
        name             = "Test-Subnet2"
        address_prefixes = ["10.1.2.0/24"]
      }
    }
  },
  "vnet3" = {
    vnet_name                        = "Test-Vnet3"
    address_space                    = ["10.2.0.0/16"]
    location                         = "eastus2"
    resource_group                   = "myResourceGroup-Network2"
    resource_group_creation_required = false
    subnets = {
      "subnet1" = {
        name             = "Test-Subnet1"
        address_prefixes = ["10.2.1.0/24"]
        nsg_name         = "Test-NSG1"
        security_rule = [
          {
            name                       = "Allow-SSH"
            priority                   = 100
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_port_range          = "*"
            destination_port_range     = "22"
            source_address_prefix      = "*"
            destination_address_prefix = "*"
          }
        ]
      },
      "subnet2" = {
        name             = "Test-Subnet2"
        address_prefixes = ["10.2.2.0/24"]
        nsg_name         = "Test-NSG2"
        security_rule = [
          {
            name                       = "Allow-HTTP"
            priority                   = 100
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_port_range          = "*"
            destination_port_range     = "80"
            source_address_prefix      = "*"
            destination_address_prefix = "*"
          }
        ]
      }
    }
  }
}
