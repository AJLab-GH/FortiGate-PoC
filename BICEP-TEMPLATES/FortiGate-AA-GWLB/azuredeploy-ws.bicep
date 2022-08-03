param location string = 'canadacentral'
param DeploymentPrefix string = 'AJLab-WS'
param vNETCIDR string = '10.0.0.0/16'
param sn1Name string = 'default'
param sn1CIDR string = '10.0.0.0/24'
param Username string
@secure()
param Password string
param fortiGateNamePrefix string

var resourcegroup = resourceGroup().name
var subscriptionid = subscription().subscriptionId
var vNETName = '${DeploymentPrefix}-vNET'
var vmName = '${DeploymentPrefix}-VM'
var diskName = '${DeploymentPrefix}-disk'
var NicName = '${DeploymentPrefix}-NIC'
var snID = resourceId('Microsoft.Network/virtualNetworks/subnets', vNETName, sn1Name)
var NicID = networkInterface.id
var PipName = '${DeploymentPrefix}-PIP'
var PipId = publicIPAddress.id
var NSGName = '${DeploymentPrefix}-NSG'
var NSGId = networkSecurityGroup.id
var GWLBName_var = '${fortiGateNamePrefix}-GWLB'



resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: vNETName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vNETCIDR
      ]
    }
    subnets: [
      {
        name: sn1Name
        properties: {
          addressPrefix: sn1CIDR
          networkSecurityGroup: {
            id: NSGId
          }
        }
      }
    ]
  }
}

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2019-11-01' = {
  name: NSGName
  location: location
  properties: {
    securityRules: [
      {
        name: 'unblock_all_tcp_rule'
        properties: {
          description: 'unblock_all_tcp_rule'
          protocol: 'Tcp'
          sourcePortRange: '0-65535'
          destinationPortRange: '0-65535'
          sourceAddressPrefix: '0.0.0.0/0'
          destinationAddressPrefix: '0.0.0.0/0'
          access: 'Allow'
          priority: 123
          direction: 'Inbound'
        }
      }
      {
        name: 'unblock_all_tcp_outrule'
        properties: {
          description: 'unblock_all_tcp_outrule'
          protocol: 'Tcp'
          sourcePortRange: '0-65535'
          destinationPortRange: '0-65535'
          sourceAddressPrefix: '0.0.0.0/0'
          destinationAddressPrefix: '0.0.0.0/0'
          access: 'Allow'
          priority: 123
          direction: 'Outbound'
        }
      }
      {
        name: 'unblock_all_udp_ports'
        properties: {
          description: 'Unblock_all_udp_ports'
          protocol: 'Udp'
          sourcePortRange: '0-65535'
          destinationPortRange: '0-65535'
          sourceAddressPrefix: '0.0.0.0/0'
          destinationAddressPrefix: '0.0.0.0/0'
          access: 'Allow'
          priority: 125
          direction: 'Inbound'
        }
      }
    ]
  }
}


resource networkInterface 'Microsoft.Network/networkInterfaces@2021-08-01' = {
  name: NicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          gatewayLoadBalancer: {
            id: '/subscriptions/${subscriptionid}/resourceGroups/${resourcegroup}/providers/Microsoft.Network/loadBalancers/${GWLBName_var}/frontendIPConfigurations/${GWLBName_var}-ProviderSubnet-FrontEnd'
          }
          privateIPAllocationMethod: 'Dynamic'
          
          publicIPAddress: {
            id: PipId
          }
          subnet: {
            id: snID
          }
        }
      }
    ]
  }
  dependsOn: [
    virtualNetwork
    networkSecurityGroup
  ]
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2019-11-01' = {
  name: PipName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'  
  }
}


resource windowsVM 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_A2_v2'
    }
    osProfile: {
      computerName: 'WindowsServer'
      adminUsername: Username
      adminPassword: Password
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2012-R2-Datacenter'
        version: 'latest'
      }
      osDisk: {
        name: diskName
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: NicID
        }
      ]
    }
  }
}

output WindowsServerPublicIP string = reference(PipId).ipAddress
