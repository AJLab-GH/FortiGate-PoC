param location string = resourceGroup().location
param DeploymentPrefix string
param Username string
@secure()
param Password string
param fortiGateNamePrefix string

var resourcegroup = resourceGroup().name
var subscriptionid = subscription().subscriptionId
var vNETName = '${fortiGateNamePrefix}-VNET'
var vmName = '${DeploymentPrefix}-VM'
var diskName = '${DeploymentPrefix}-disk'
var NicName = '${DeploymentPrefix}-NIC'
var NicID = networkInterface.id
var NSGName = '${DeploymentPrefix}-NSG'
var nsgId = resourceId('Microsoft.Network/networkSecurityGroups', NSGName)


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
          privateIPAllocationMethod: 'Dynamic'
            subnet: {
            id: '/subscriptions/${subscriptionid}/resourceGroups/${resourcegroup}/providers/Microsoft.Network/virtualNetworks/${vNETName}/subnets/ProtectedASubnet'
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsgId
    }
  }
  dependsOn: [
    networkSecurityGroup
  ]
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
