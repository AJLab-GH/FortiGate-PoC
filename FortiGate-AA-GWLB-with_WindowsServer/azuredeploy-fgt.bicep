@description('Username for the FortiGate VM')
param adminUsername string

@description('Password for the FortiGate VM')
@secure()
param adminPassword string

@description('Naming prefix for all deployed resources. The FortiGate VMs will have the suffix \'-FGT-A\' and \'-FGT-B\'. For example if the prefix is \'ACME-01\' the FortiGates will be named \'ACME-01-FGT-A\' and \'ACME-01-FGT-B\'')
param fortiGateNamePrefix string

@description('Identifies whether to to use PAYG (on demand licensing) or BYOL license model (where license is purchased separately)')
@allowed([
  'fortinet_fg-vm'
  'fortinet_fg-vm_payg_20190624'
])
param fortiGateImageSKU string = 'fortinet_fg-vm'

@description('Select the image version')
@allowed([
  '6.2.0'
  '6.2.2'
  '6.2.4'
  '6.2.5'
  '6.4.0'
  '6.4.2'
  '6.4.3'
  '6.4.5'
  '6.4.6'
  '6.4.7'
  '6.4.8'
  '7.0.0'
  '7.0.1'
  '7.0.2'
  '7.0.3'
  '7.0.4'
  '7.0.5'
  'latest'
])
param fortiGateImageVersion string = 'latest'

@description('The ARM template provides a basic configuration. Additional configuration can be added here.')
param fortiGateAdditionalCustomData string = ''

@description('Virtual Machine size selection')
@allowed([
  'Standard_F1'
  'Standard_F2'
  'Standard_F4'
  'Standard_F8'
  'Standard_F16'
  'Standard_F1s'
  'Standard_F2s'
  'Standard_F4s'
  'Standard_F8s'
  'Standard_F16s'
  'Standard_F2s_v2'
  'Standard_F4s_v2'
  'Standard_F8s_v2'
  'Standard_F16s_v2'
  'Standard_F32s_v2'
  'Standard_D1_v2'
  'Standard_D2_v2'
  'Standard_D3_v2'
  'Standard_D4_v2'
  'Standard_D5_v2'
  'Standard_DS1_v2'
  'Standard_DS2_v2'
  'Standard_DS3_v2'
  'Standard_DS4_v2'
  'Standard_DS5_v2'
  'Standard_D2_v3'
  'Standard_D4_v3'
  'Standard_D8_v3'
  'Standard_D16_v3'
  'Standard_D32_v3'
  'Standard_D2s_v3'
  'Standard_D4s_v3'
  'Standard_D8s_v3'
  'Standard_D16s_v3'
  'Standard_D32s_v3'
])
param instanceType string = 'Standard_F2s'

@description('Deploy FortiGate VMs in an Availability Set or Availability Zones. If Availability Zones deployment is selected but the location does not support Availability Zones an Availability Set will be deployed. If Availability Zones deployment is selected and Availability Zones are available in the location, FortiGate A will be placed in Zone 1, FortiGate B will be placed in Zone 2')
@allowed([
  'Availability Set'
  'Availability Zones'
])
param availabilityOptions string = 'Availability Set'

@description('Accelerated Networking enables direct connection between the VM and network card. Only available on 2 CPU F/Fs and 4 CPU D/Dsv2, D/Dsv3, E/Esv3, Fsv2, Lsv2, Ms/Mms and Ms/Mmsv2')
@allowed([
  false
  true
])
param acceleratedNetworking bool = true

@description('Public IP for FortiGate-A for management purposes')
@allowed([
  'new'
  'existing'
])
param publicIP1NewOrExisting string = 'new'

@description('Name of Public IP address for FortiGate-A, if no name is provided the default name will be the Resource Group Name as the Prefix and \'-FGT-A-PIP\' as the suffix')
param publicIP1Name string = ''

@description('Public IP Resource Group, this value is required if an existing Public IP is selected')
param publicIP1ResourceGroup string = ''

@description('Public IP for FortiGate-B for management purposes')
@allowed([
  'new'
  'existing'
])
param publicIP2NewOrExisting string = 'new'

@description('Name of Public IP address for FortiGate-B, if no name is provided the default name will be the Resource Group Name as the Prefix and \'-FGT-B-PIP\' as the suffix')
param publicIP2Name string = ''

@description('Public IP Resource Group, this value is required if an existing Public IP is selected')
param publicIP2ResourceGroup string = ''

@description('Identify whether to use a new or existing vnet')
@allowed([
  'new'
  'existing'
])
param vnetNewOrExisting string = 'new'

@description('Name of the Azure virtual network, required if utilizing and existing VNET. If no name is provided the default name will be the Resource Group Name as the Prefix and \'-VNET\' as the suffix')
param vnetName string = ''

@description('Resource Group containing the existing virtual network, leave blank if a new VNET is being utilized')
param vnetResourceGroup string = ''

@description('Virtual Network Address prefix')
param vnetAddressPrefix string = '172.16.136.0/22'

@description('Subnet 1 Name')
param subnet1Name string = 'ProviderSubnet'

@description('Subnet 1 Prefix')
param subnet1Prefix string = '172.16.136.0/26'

@description('Subnet 1 start address, 2 consecutive private IPs are required')
param subnet1StartAddress string = '172.16.136.4'

@description('Subnet 2 Name')
param subnet2Name string = 'ManagementSubnet'

@description('Subnet 2 Prefix')
param subnet2Prefix string = '172.16.136.64/26'

@description('Subnet 2 start address, 2 consecutive private IPs are required')
param subnet2StartAddress string = '172.16.136.68'


@description('Enable Serial Console')
@allowed([
  'yes'
  'no'
])
param serialConsole string = 'yes'

@description('Connect to FortiManager')
@allowed([
  'yes'
  'no'
])
param fortiManager string = 'no'

@description('FortiManager IP or DNS name to connect to on port TCP/541')
param fortiManagerIP string = ''

@description('FortiManager serial number to add the deployed FortiGate into the FortiManager')
param fortiManagerSerial string = ''

@description('Primary FortiGate BYOL license content')
param fortiGateLicenseBYOLA string = ''

@description('Secondary FortiGate BYOL license content')
param fortiGateLicenseBYOLB string = ''

@description('Primary FortiGate BYOL Flex-VM license token')
param fortiGateLicenseFlexVMA string = ''

@description('Secondary FortiGate BYOL Flex-VM license token')
param fortiGateLicenseFlexVMB string = ''

@description('Location for all resources.')
param location string = resourceGroup().location
param fortinetTags object = {
  publisher: 'Fortinet'
  template: 'Active-Active-ELB-ILB'
  provider: '6EB3B02F-50E5-4A3E-8CB8-2E12925831AA'
}

var imagePublisher = 'fortinet'
var imageOffer = 'fortinet_fortigate-vm_v5'
var availabilitySetName_var = '${fortiGateNamePrefix}-AvailabilitySet'
var availabilitySetId = {
  id: availabilitySetName.id
}
var vnetName_var = ((vnetName == '') ? '${fortiGateNamePrefix}-VNET' : vnetName)
var subnet1Id = ((vnetNewOrExisting == 'new') ? resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName_var, subnet1Name) : resourceId(vnetResourceGroup, 'Microsoft.Network/virtualNetworks/subnets', vnetName_var, subnet1Name))
var subnet2Id = ((vnetNewOrExisting == 'new') ? resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName_var, subnet2Name) : resourceId(vnetResourceGroup, 'Microsoft.Network/virtualNetworks/subnets', vnetName_var, subnet2Name))
var fgaVmName_var = '${fortiGateNamePrefix}-FGT-A'
var fgbVmName_var = '${fortiGateNamePrefix}-FGT-B'
var fmgCustomData = ((fortiManager == 'yes') ? '\nconfig system central-management\nset type fortimanager\n set fmg ${fortiManagerIP}\nset serial-number ${fortiManagerSerial}\nend\n config system interface\n edit port1\n append allowaccess fgfm\n end\n config system interface\n edit port2\n append allowaccess fgfm\n end\n' : '')
var fgaCustomDataFlexVM = ((fortiGateLicenseFlexVMA == '') ? '' : 'exec vm-license ${fortiGateLicenseFlexVMA}\n')
var fgbCustomDataFlexVM = ((fortiGateLicenseFlexVMB == '') ? '' : 'exec vm-license ${fortiGateLicenseFlexVMB}\n')
var customDataHeader = 'Content-Type: multipart/mixed; boundary="12345"\nMIME-Version: 1.0\n--12345\nContent-Type: text/plain; charset="us-ascii"\nMIME-Version: 1.0\nContent-Transfer-Encoding: 7bit\nContent-Disposition: attachment; filename="config"\n\n'
var fgaCustomDataGWLB = '${customDatafgaFabricSDN}${customDatafgaHostname}${customDatafgaProbeResponse}${customDatafgaAddresses}${customDatafgaInterfaces}${customDatafgaRouter}${customDatafgaVXLan}${customDatafgaVirtualWirePair}${customDatafgaFWPolicy}${customDataFMGandFlexVMA}'
var fgbCustomDataGWLB = '${customDatafgbFabricSDN}${customDatafgbHostname}${customDatafgbProbeResponse}${customDatafgbAddresses}${customDatafgbInterfaces}${customDatafgbRouter}${customDatafgbVXLan}${customDatafgbVirtualWirePair}${customDatafgbFWPolicy}${customDataFMGandFlexVMB}'
var customDatafgaFabricSDN = 'config system sdn-connector\nedit AzureSDN\nset type azure\nnext\nend\n'
var customDatafgaHostname = 'config system global\n set hostname ${fgaVmName_var}\n end\n'
var customDatafgaProbeResponse = 'config system probe-response\n set http-probe-value OK\n set mode http-probe\n end\n'
var customDatafgaAddresses = 'config firewall address\n edit AzureProbeSourceIP\n set allow-routing enable\n set subnet 168.63.129.16/32\n set comment Azure_PIP_used_for_internal_platform_resources\n next\n end\n'
var customDatafgaInterfaces = 'config system interface\n edit port1\nset mode static\n set ip ${sn1IPfga}/${sn1CIDRmask}\n set description External\n set mtu-override enable\n set mtu 1570\n set allowaccess probe-response\n next\n edit port2\n set mode static\n set ip ${sn2IPfga}/${sn2CIDRmask}\n set allowaccess ping https ssh fgfm probe-response\n set description Management\n next\n end\n'
var customDatafgaRouter = 'config router static\n edit 1\n set gateway ${sn2GatewayIP}\n set device port2\n next\n edit 2\nset dstaddr AzureProbeSourceIP\nset device port1\n set gateway ${sn1GatewayIP}\n next\n end\n'
var customDatafgaVXLan = 'config system vxlan\n edit extvxlan\n set interface port1\n set vni 801\n set dstport 2001\n set remote-ip ${sn1IPgwlb}\n next\n edit intvxlan\n set interface port1\n set vni 800 \n set dstport 2000 \n set remote-ip ${sn1IPgwlb}\n next\n end\n'
var customDatafgaVirtualWirePair = 'config system virtual-wire-pair \n edit vxlanvwpair \n set member extvxlan intvxlan \n next \n end\n'
var customDatafgaFWPolicy = 'config firewall policy \n edit 1\n set name int-ext_vxlan \n set srcintf extvxlan intvxlan\n set dstintf extvxlan intvxlan \n set srcaddr all\n set dstaddr all \n set action accept\n set schedule always\n set service ALL\n set logtraffic all\n set utm-status enable\n set ssl-ssh-profile certificate-inspection \n set ips-sensor default \n next\n end\n'
var customDataFMGandFlexVMA = '${fmgCustomData}${fortiGateAdditionalCustomData}\n${fgaCustomDataFlexVM}\n'
var customDatafgbFabricSDN = 'config system sdn-connector\nedit AzureSDN\nset type azure\nnext\nend\n'
var customDatafgbHostname = 'config system global\n set hostname ${fgbVmName_var}\n end\n'
var customDatafgbProbeResponse = 'config system probe-response\n set http-probe-value OK\n set mode http-probe\n end\n'
var customDatafgbAddresses = 'config firewall address\n edit AzureProbeSourceIP\n set allow-routing enable\n set subnet 168.63.129.16/32\n set comment Azure_PIP_used_for_internal_platform_resources\n next\n end\n'
var customDatafgbInterfaces = 'config system interface\n edit port1\nset mode static\n set ip ${sn1IPfgb}/${sn1CIDRmask}\n set description External\n set mtu-override enable\n set mtu 1570\n set allowaccess probe-response\n next\n edit port2\n set mode static\n set ip ${sn2IPfgb}/${sn2CIDRmask}\n set allowaccess ping https ssh fgfm probe-response\n set description Management\n next\n end\n'
var customDatafgbRouter = 'config router static\n edit 1\n set gateway ${sn2GatewayIP}\n set device port2\n next\n edit 2\nset dstaddr AzureProbeSourceIP\nset device port1\n set gateway ${sn1GatewayIP}\n next\n end\n'
var customDatafgbVXLan = 'config system vxlan\n edit extvxlan\n set interface port1\n set vni 801\n set dstport 2001\n set remote-ip ${sn1IPgwlb}\n next\n edit intvxlan\n set interface port1\n set vni 800 \n set dstport 2000 \n set remote-ip ${sn1IPgwlb}\n next\n end\n'
var customDatafgbVirtualWirePair = 'config system virtual-wire-pair \n edit vxlanvwpair \n set member extvxlan intvxlan \n next \n end\n'
var customDatafgbFWPolicy = 'config firewall policy \n edit 1\n set name int-ext_vxlan \n set srcintf extvxlan intvxlan\n set dstintf extvxlan intvxlan \n set srcaddr all\n set dstaddr all \n set action accept\n set schedule always\n set service ALL\n set logtraffic all\n set utm-status enable\n set ssl-ssh-profile certificate-inspection \n set ips-sensor default \n next\n end\n'
var customDataFMGandFlexVMB = '${fmgCustomData}${fortiGateAdditionalCustomData}\n${fgbCustomDataFlexVM}\n'
var customDataLicenseHeader = '--12345\nContent-Type: text/plain; charset="us-ascii"\nMIME-Version: 1.0\nContent-Transfer-Encoding: 7bit\nContent-Disposition: attachment; filename="fgtlicense"\n\n'
var customDataFooter = '--12345--\n'
var fgaCustomDataCombined = '${customDataHeader}${fgaCustomDataGWLB}${customDataLicenseHeader}${fortiGateLicenseBYOLA}${customDataFooter}'
var fgbCustomDataCombined = '${customDataHeader}${fgbCustomDataGWLB}${customDataLicenseHeader}${fortiGateLicenseBYOLB}${customDataFooter}'
var fgaCustomData = base64(((fortiGateLicenseBYOLA == '') ? fgaCustomDataGWLB : fgaCustomDataCombined))
var fgbCustomData = base64(((fortiGateLicenseBYOLB == '') ? fgbCustomDataGWLB : fgbCustomDataCombined))
var fgaNic1Name_var = '${fgaVmName_var}-Nic1'
var fgaNic1Id = fgaNic1Name.id
var fgaNic2Name_var = '${fgaVmName_var}-Nic2'
var fgaNic2Id = fgaNic2Name.id
var fgbNic1Name_var = '${fgbVmName_var}-Nic1'
var fgbNic1Id = fgbNic1Name.id
var fgbNic2Name_var = '${fgbVmName_var}-Nic2'
var fgbNic2Id = fgbNic2Name.id
var serialConsoleStorageAccountName_var = 'console${uniqueString(resourceGroup().id)}'
var serialConsoleStorageAccountType = 'Standard_LRS'
var serialConsoleEnabled = ((serialConsole == 'yes') ? true : false)
var publicIP1Name_var = ((publicIP1Name == '') ? '${fortiGateNamePrefix}-FGT-A-PIP' : publicIP1Name)
var publicIP1Id = ((publicIP1NewOrExisting == 'new') ? publicIP1Name_resource.id : resourceId(publicIP1ResourceGroup, 'Microsoft.Network/publicIPAddresses', publicIP1Name_var))
var publicIP2Name_var = ((publicIP2Name == '') ? '${fortiGateNamePrefix}-FGT-B-PIP' : publicIP2Name)
var publicIP2Id = ((publicIP2NewOrExisting == 'new') ? publicIP2Name_resource.id : resourceId(publicIP2ResourceGroup, 'Microsoft.Network/publicIPAddresses', publicIP2Name_var))
var nsgName_var = '${fortiGateNamePrefix}-NSG-Allow-All'
var nsgId = nsgName.id
var sn1IPArray = split(subnet1Prefix, '.')
var sn1IPArray2ndString = string(sn1IPArray[3])
var sn1IPArray2nd = split(sn1IPArray2ndString, '/')
var sn1CIDRmask = string(int(sn1IPArray2nd[1]))
var sn1IPArray3 = string((int(sn1IPArray2nd[0]) + 1))
var sn1IPArray2 = string(int(sn1IPArray[2]))
var sn1IPArray1 = string(int(sn1IPArray[1]))
var sn1IPArray0 = string(int(sn1IPArray[0]))
var sn1GatewayIP = '${sn1IPArray0}.${sn1IPArray1}.${sn1IPArray2}.${sn1IPArray3}'
var sn1IPStartAddress = split(subnet1StartAddress, '.')
var sn1IPgwlb = '${sn1IPArray0}.${sn1IPArray1}.${sn1IPArray2}.${int(sn1IPStartAddress[3])}'
var sn1IPfga = '${sn1IPArray0}.${sn1IPArray1}.${sn1IPArray2}.${(int(sn1IPStartAddress[3]) + 1)}'
var sn1IPfgb = '${sn1IPArray0}.${sn1IPArray1}.${sn1IPArray2}.${(int(sn1IPStartAddress[3]) + 2)}'
var sn2IPArray = split(subnet2Prefix, '.')
var sn2IPArray2ndString = string(sn2IPArray[3])
var sn2IPArray2nd = split(sn2IPArray2ndString, '/')
var sn2CIDRmask = string(int(sn2IPArray2nd[1]))
var sn2IPArray3 = string((int(sn2IPArray2nd[0]) + 1))
var sn2IPArray2 = string(int(sn2IPArray[2]))
var sn2IPArray1 = string(int(sn2IPArray[1]))
var sn2IPArray0 = string(int(sn2IPArray[0]))
var sn2GatewayIP = '${sn2IPArray0}.${sn2IPArray1}.${sn2IPArray2}.${sn2IPArray3}'
var sn2IPStartAddress = split(subnet2StartAddress, '.')
var sn2IPfga = '${sn2IPArray0}.${sn2IPArray1}.${sn2IPArray2}.${(int(sn2IPStartAddress[3]) + 1)}'
var sn2IPfgb = '${sn2IPArray0}.${sn2IPArray1}.${sn2IPArray2}.${(int(sn2IPStartAddress[3]) + 2)}'
var GWLBName_var = '${fortiGateNamePrefix}-GWLB'
var GWLBFEName = '${fortiGateNamePrefix}-GWLB-${subnet1Name}-FrontEnd'
var GWLBFEId = resourceId('Microsoft.Network/loadBalancers/frontendIPConfigurations', GWLBName_var, GWLBFEName)
var GWLBBEName = '${fortiGateNamePrefix}-GWLB-${subnet1Name}-BackEnd'
var GWLBBEId = resourceId('Microsoft.Network/loadBalancers/backendAddressPools', GWLBName_var, GWLBBEName)
var GWLBProbeName = 'lbprobe'
var GWLBProbeId = resourceId('Microsoft.Network/loadBalancers/probes', GWLBName_var, GWLBProbeName)
var useAZ = ((!empty(pickZones('Microsoft.Compute', 'virtualMachines', location))) && (availabilityOptions == 'Availability Zones'))
var zone1 = [
  '1'
]
var zone2 = [
  '2'
]

resource serialConsoleStorageAccountName 'Microsoft.Storage/storageAccounts@2021-02-01' = if (serialConsole == 'yes') {
  name: serialConsoleStorageAccountName_var
  location: location
  kind: 'Storage'
  sku: {
    name: serialConsoleStorageAccountType
  }
}

resource availabilitySetName 'Microsoft.Compute/availabilitySets@2021-07-01' = if (!useAZ) {
  name: availabilitySetName_var
  location: location
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  properties: {
    platformFaultDomainCount: 2
    platformUpdateDomainCount: 2
  }
  sku: {
    name: 'Aligned'
  }
}

resource vnetName_resource 'Microsoft.Network/virtualNetworks@2020-04-01' = if (vnetNewOrExisting == 'new') {
  name: vnetName_var
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnet1Name
        properties: {
          addressPrefix: subnet1Prefix
        }
      }
      {
        name: subnet2Name
        properties: {
          addressPrefix: subnet2Prefix
        }
      }
    ]
  }
}

resource GWLBName 'Microsoft.Network/loadBalancers@2021-08-01' = {
  name: GWLBName_var
  location: location
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  sku: {
    name: 'Gateway'
  }
  properties: {
    frontendIPConfigurations: [
      {
        name: GWLBFEName
        properties: {
          privateIPAddress: sn1IPgwlb
          privateIPAllocationMethod: 'Static'
          subnet: {
            id: subnet1Id
          }
        }
      }
    ]
    backendAddressPools: [
      {
        name: GWLBBEName
        properties: {
          tunnelInterfaces: [
            {
              port: 2000
              identifier: 800
              protocol: 'VxLan'
              type: 'Internal'
            }
            {
              port: 2001
              identifier: 801
              protocol: 'VxLan'
              type: 'External' 
            }
          ]
        }
        }
    ]
    loadBalancingRules: [
      {
        properties: {
          frontendIPConfiguration: {
            id: GWLBFEId
          }
          backendAddressPool: {
            id: GWLBBEId
          }
          probe: {
            id: GWLBProbeId
          }
          protocol: 'All'
          frontendPort: 0
          backendPort: 0
          }
        name: 'lbruleFEall'
      }
    ]
    probes: [
      {
        properties: {
          protocol: 'Tcp'
          port: 8008
          intervalInSeconds: 5
          numberOfProbes: 2
        }
        name: GWLBProbeName
      }
    ]
  }
  dependsOn: [
    vnetName_resource
  ]
}


resource nsgName 'Microsoft.Network/networkSecurityGroups@2020-04-01' = {
  name: nsgName_var
  location: location
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  properties: {
    securityRules: [
      {
        name: 'AllowAllInbound'
        properties: {
          description: 'Allow all in'
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
      {
        name: 'AllowAllOutbound'
        properties: {
          description: 'Allow all out'
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 105
          direction: 'Outbound'
        }
      }
    ]
  }
}

resource publicIP1Name_resource 'Microsoft.Network/publicIPAddresses@2020-04-01' = if (publicIP1NewOrExisting == 'new') {
  name: publicIP1Name_var
  location: location
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    dnsSettings: {
      domainNameLabel: '${toLower(fgaVmName_var)}-${uniqueString(resourceGroup().id)}'
    }
  }
}

resource publicIP2Name_resource 'Microsoft.Network/publicIPAddresses@2020-04-01' = if (publicIP2NewOrExisting == 'new') {
  name: publicIP2Name_var
  location: location
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    dnsSettings: {
      domainNameLabel: '${toLower(fgbVmName_var)}-${uniqueString(resourceGroup().id)}'
    }
  }
}



resource fgaNic1Name 'Microsoft.Network/networkInterfaces@2020-04-01' = {
  name: fgaNic1Name_var
  location: location
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAddress: sn1IPfga
          privateIPAllocationMethod: 'Static'
          subnet: {
            id: subnet1Id
          }
          loadBalancerBackendAddressPools: [
            {
              id: GWLBBEId
            }
          ]
        }
      }
    ]
    enableIPForwarding: true
    enableAcceleratedNetworking: acceleratedNetworking
    networkSecurityGroup: {
      id: nsgId
    }
  }
  dependsOn: [
    vnetName_resource
    GWLBName
  ]
}

resource fgbNic1Name 'Microsoft.Network/networkInterfaces@2020-04-01' = {
  name: fgbNic1Name_var
  location: location
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAddress: sn1IPfgb
          privateIPAllocationMethod: 'Static'
          subnet: {
            id: subnet1Id
          }
          loadBalancerBackendAddressPools: [
            {
              id: GWLBBEId
            }
          ]
        }
      }
    ]
    enableIPForwarding: true
    enableAcceleratedNetworking: acceleratedNetworking
    networkSecurityGroup: {
      id: nsgId
    }
  }
  dependsOn: [
    fgaNic1Name
    vnetName_resource
    GWLBName
  ]
}

resource fgaNic2Name 'Microsoft.Network/networkInterfaces@2020-04-01' = {
  name: fgaNic2Name_var
  location: location
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAddress: sn2IPfga
          privateIPAllocationMethod: 'Static'
          publicIPAddress: {
            id: publicIP1Id
          }
          subnet: {
            id: subnet2Id
          }
        }
      }
    ]
    enableIPForwarding: true
    enableAcceleratedNetworking: acceleratedNetworking
    networkSecurityGroup: {
      id: nsgId
    }
  }
  dependsOn: [
    vnetName_resource
  ]
}

resource fgbNic2Name 'Microsoft.Network/networkInterfaces@2020-04-01' = {
  name: fgbNic2Name_var
  location: location
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAddress: sn2IPfgb
          privateIPAllocationMethod: 'Static'
          publicIPAddress: {
            id: publicIP2Id
          }

          subnet: {
            id: subnet2Id
          }
        }
      }
    ]
    enableIPForwarding: true
    enableAcceleratedNetworking: acceleratedNetworking
    networkSecurityGroup: {
      id: nsgId
    }
  }
  dependsOn: [
    vnetName_resource
    fgaNic2Name
  ]
}

resource fgaVmName 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: fgaVmName_var
  location: location
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  identity: {
    type: 'SystemAssigned'
  }
  zones: (useAZ ? zone1 : json('null'))
  plan: {
    name: fortiGateImageSKU
    publisher: imagePublisher
    product: imageOffer
  }
  properties: {
    hardwareProfile: {
      vmSize: instanceType
    }
    availabilitySet: ((!useAZ) ? availabilitySetId : json('null'))
    osProfile: {
      computerName: fgaVmName_var
      adminUsername: adminUsername
      adminPassword: adminPassword
      customData: fgaCustomData
    }
    storageProfile: {
      imageReference: {
        publisher: imagePublisher
        offer: imageOffer
        sku: fortiGateImageSKU
        version: fortiGateImageVersion
      }
      osDisk: {
        createOption: 'FromImage'
      }
      dataDisks: [
        {
          diskSizeGB: 30
          lun: 0
          createOption: 'Empty'
        }
      ]
    }
    networkProfile: {
      networkInterfaces: [
        {
          properties: {
            primary: true
          }
          id: fgaNic1Id
        }
        {
          properties: {
            primary: false
          }
          id: fgaNic2Id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: serialConsoleEnabled
        storageUri: ((serialConsole == 'yes') ? reference(serialConsoleStorageAccountName_var, '2021-08-01').primaryEndpoints.blob : json('null'))
      }
    }
  }
}

resource fgbVmName 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: fgbVmName_var
  location: location
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  identity: {
    type: 'SystemAssigned'
  }
  zones: (useAZ ? zone2 : json('null'))
  plan: {
    name: fortiGateImageSKU
    publisher: imagePublisher
    product: imageOffer
  }
  properties: {
    hardwareProfile: {
      vmSize: instanceType
    }
    availabilitySet: ((!useAZ) ? availabilitySetId : json('null'))
    osProfile: {
      computerName: fgbVmName_var
      adminUsername: adminUsername
      adminPassword: adminPassword
      customData: fgbCustomData
    }
    storageProfile: {
      imageReference: {
        publisher: imagePublisher
        offer: imageOffer
        sku: fortiGateImageSKU
        version: fortiGateImageVersion
      }
      osDisk: {
        createOption: 'FromImage'
      }
      dataDisks: [
        {
          diskSizeGB: 30
          lun: 0
          createOption: 'Empty'
        }
      ]
    }
    networkProfile: {
      networkInterfaces: [
        {
          properties: {
            primary: true
          }
          id: fgbNic1Id
        }
        {
          properties: {
            primary: false
          }
          id: fgbNic2Id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: serialConsoleEnabled
        storageUri: ((serialConsole == 'yes') ? reference(serialConsoleStorageAccountName_var, '2021-08-01').primaryEndpoints.blob : json('null'))
      }
    }
  }
}

output fortiGateAPublicIP string = ((publicIP1NewOrExisting == 'new') ? reference(publicIP1Id).ipAddress : '')
output fortiGateBPublicIP string = ((publicIP2NewOrExisting == 'new') ? reference(publicIP2Id).ipAddress : '')
output fortiGateAFQDN string = ((publicIP1NewOrExisting == 'new') ? reference(publicIP1Id).dnsSettings.fqdn : '')
output fortiGateBFQDN string = ((publicIP1NewOrExisting == 'new') ? reference(publicIP2Id).dnsSettings.fqdn : '')
output fortiGateNamePrefix string = fortiGateNamePrefix
output SubscriptionID string = subscription().id
output ResourceGroupName string = resourceGroup().name


