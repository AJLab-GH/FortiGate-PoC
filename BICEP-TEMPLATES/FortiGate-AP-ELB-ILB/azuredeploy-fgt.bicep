@description('Username for the Virtual Machine')
param adminUsername string

@description('Password for the Virtual Machine')
@secure()
param adminPassword string

@description('Naming prefix for all deployed resources. The FortiGate VMs will have the suffix \'-FGT-A\' and \'-FGT-B\'. For example if the prefix is \'ACME01\' the FortiGates will be named \'ACME01-FGT-A\' and \'ACME01-FGT-B\'')
param fortiGateNamePrefix string

@description('Identifies whether to to use PAYG (on demand licensing) or BYOL license model (where license is purchased separately)')
@allowed([
  'fortinet_fg-vm'
  'fortinet_fg-vm_payg_20190624'
])
param fortiGateImageSKU string = 'fortinet_fg-vm'

@description('Select the FortiGate image version')
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

@description('Virtual Machine size selection - must be F4 or other instance that supports 4 NICs')
@allowed([
  'Standard_F4s'
  'Standard_F8s'
  'Standard_F16s'
  'Standard_F4'
  'Standard_F8'
  'Standard_F16'
  'Standard_F8s_v2'
  'Standard_F16s_v2'
  'Standard_F32s_v2'
  'Standard_DS3_v2'
  'Standard_DS4_v2'
  'Standard_DS5_v2'
  'Standard_D8s_v3'
  'Standard_D16s_v3'
  'Standard_D32s_v3'
])
param instanceType string = 'Standard_F4s'

@description('Deploy FortiGate VMs in an Availability Set or Availability Zones. If Availability Zones deployment is selected but the location does not support Availability Zones an Availability Set will be deployed. If Availability Zones deployment is selected and Availability Zones are available in the location, FortiGate A will be placed in Zone 1, FortiGate B will be placed in Zone 2')
@allowed([
  'Availability Set'
  'Availability Zones'
])
param availabilityOptions string = 'Availability Set'

@description('Accelerated Networking enables direct connection between the VM and network card. Only available on 2 CPU F/Fs and 4 CPU D/Dsv2, D/Dsv3, E/Esv3, Fsv2, Lsv2, Ms/Mms and Ms/Mmsv2')
@allowed([
  true
  false
])
param acceleratedNetworking bool = true

@description('Public IP for the Load Balancer for inbound and outbound data of the FortiGate VMs')
@allowed([
  'new'
  'existing'
])
param publicIP1NewOrExisting string = 'new'

@description('Name of Public IP address, if no name is provided the default name will be the Resource Group Name as the Prefix and \'-FGT-PIP\' as the suffix')
param publicIP1Name string = ''

@description('Public IP Resource Group, this value is required if an existing Public IP is selected')
param publicIP1ResourceGroup string = ''

@description('Public IP for management of the FortiGate A. This deployment uses a Standard SKU Azure Load Balancer and requires a Standard SKU public IP. Microsoft Azure offers a migration path from a basic to standard SKU public IP. The management IP\'s for both FortiGate can be set to none. If no alternative internet access is provided, the SDN Connector functionality for dynamic objects will not work.')
@allowed([
  'new'
  'existing'
  'none'
])
param publicIP2NewOrExisting string = 'new'

@description('Name of Public IP address, if no name is provided the default name will be the Resource Group Name as the Prefix and \'-FGT-A-MGMT-PIP\' as the suffix')
param publicIP2Name string = ''

@description('Public IP Resource Group, this value is required if an existing Public IP is selected')
param publicIP2ResourceGroup string = ''

@description('Public IP for management of the FortiGate B. This deployment uses a Standard SKU Azure Load Balancer and requires a Standard SKU public IP. Microsoft Azure offers a migration path from a basic to standard SKU public IP. The management IP\'s for both FortiGate can be set to none. If no alternative internet access is provided, the SDN Connector functionality for both HA failover and dynamic objects will not work.')
@allowed([
  'new'
  'existing'
  'none'
])
param publicIP3NewOrExisting string = 'new'

@description('Name of Public IP address, if no name is provided the default name will be the Resource Group Name as the Prefix and \'-FGT-B-MGMT-PIP\' as the suffix')
param publicIP3Name string = ''

@description('Public IP Resource Group, this value is required if an existing Public IP is selected')
param publicIP3ResourceGroup string = ''

@description('Identify whether to use a new or existing vnet')
@allowed([
  'new'
  'existing'
])
param vnetNewOrExisting string = 'new'

@description('Name of the Azure virtual network, required if utilizing an existing VNET. If no name is provided the default name will be the Resource Group Name as the Prefix and \'-VNET\' as the suffix')
param vnetName string = ''

@description('Resource Group containing the existing virtual network, leave blank if a new VNET is being utilized')
param vnetResourceGroup string = ''

@description('Virtual Network Address prefix')
param vnetAddressPrefix string = '172.16.136.0/22'

@description('Subnet 1 Name')
param subnet1Name string = 'ExternalSubnet'

@description('Subnet 1 Prefix')
param subnet1Prefix string = '172.16.136.0/26'

@description('Subnet 1 start address, 2 consecutive private IPs are required')
param subnet1StartAddress string = '172.16.136.4'

@description('Subnet 2 Name')
param subnet2Name string = 'InternalSubnet'

@description('Subnet 2 Prefix')
param subnet2Prefix string = '172.16.136.64/26'

@description('Subnet 2 start address, 3 consecutive private IPs are required')
param subnet2StartAddress string = '172.16.136.68'

@description('Subnet 3 Name')
param subnet3Name string = 'HASyncSubnet'

@description('Subnet 3 Prefix')
param subnet3Prefix string = '172.16.136.128/26'

@description('Subnet 3 start address, 2 consecutive private IPs are required')
param subnet3StartAddress string = '172.16.136.132'

@description('Subnet 4 Name')
param subnet4Name string = 'ManagementSubnet'

@description('Subnet 4 Prefix')
param subnet4Prefix string = '172.16.136.192/26'

@description('Subnet 4 start address, 2 consecutive private IPs are required')
param subnet4StartAddress string = '172.16.136.196'

@description('Subnet 5 Name')
param subnet5Name string = 'ProtectedASubnet'

@description('Subnet 5 Prefix')
param subnet5Prefix string = '172.16.137.0/24'

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
  template: 'Active-Passive-ELB-ILB'
  provider: '6EB3B02F-50E5-4A3E-8CB8-2E12925831AP'
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
var subnet3Id = ((vnetNewOrExisting == 'new') ? resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName_var, subnet3Name) : resourceId(vnetResourceGroup, 'Microsoft.Network/virtualNetworks/subnets', vnetName_var, subnet3Name))
var subnet4Id = ((vnetNewOrExisting == 'new') ? resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName_var, subnet4Name) : resourceId(vnetResourceGroup, 'Microsoft.Network/virtualNetworks/subnets', vnetName_var, subnet4Name))
var fgaVmName_var = '${fortiGateNamePrefix}-FGT-A'
var fgbVmName_var = '${fortiGateNamePrefix}-FGT-B'
var fmgCustomData = ((fortiManager == 'yes') ? '\nconfig system central-management\nset type fortimanager\n set fmg ${fortiManagerIP}\nset serial-number ${fortiManagerSerial}\nend\n config system interface\n edit port1\n append allowaccess fgfm\n end\n config system interface\n edit port2\n append allowaccess fgfm\n end\n' : '')
var customDataHeader = 'Content-Type: multipart/mixed; boundary="12345"\nMIME-Version: 1.0\n--12345\nContent-Type: text/plain; charset="us-ascii"\nMIME-Version: 1.0\nContent-Transfer-Encoding: 7bit\nContent-Disposition: attachment; filename="config"\n\n'
var fgaCustomDataFlexVM = ((fortiGateLicenseFlexVMA == '') ? '' : 'exec vm-license ${fortiGateLicenseFlexVMA}\n')
var fgBCustomDataFlexVM = ((fortiGateLicenseFlexVMB == '') ? '' : 'exec vm-license ${fortiGateLicenseFlexVMB}\n')
var fgaCustomDataBody = 'config system sdn-connector\nedit AzureSDN\nset type azure\nnext\nend\nconfig router static\n edit 1\n set gateway ${sn1GatewayIP}\n set device port1\n next\n edit 2\n set dst ${vnetAddressPrefix}\n set gateway ${sn2GatewayIP}\n set device port2\n next\n edit 3\nset dst 168.63.129.16 255.255.255.255\nset device port2\n set gateway ${sn2GatewayIP}\n next\nedit 4\nset dst 168.63.129.16 255.255.255.255\nset device port1\n set gateway ${sn1GatewayIP}\n next\n end\n config system probe-response\n set http-probe-value OK\n set mode http-probe\n end\n config system interface\n edit port1\n set mode static\n set ip ${sn1IPfga}/${sn1CIDRmask}\n set description external\n set allowaccess probe-response\n next\n edit port2\n set mode static\n set ip ${sn2IPfga}/${sn2CIDRmask}\n set description internal\n set allowaccess probe-response\n next\n edit port3\n set mode static\n set ip ${sn3IPfga}/${sn3CIDRmask}\n set description hasyncport\n next\n edit port4\n set mode static\n set ip ${sn4IPfga}/${sn4CIDRmask}\n set description management\n set allowaccess ping https ssh ftm\n next\n end\n config system ha\n set group-name AzureHA\n set mode a-p\n set hbdev port3 100\n set session-pickup enable\n set session-pickup-connectionless enable\n set ha-mgmt-status enable\n config ha-mgmt-interfaces\n edit 1\n set interface port4\n set gateway ${sn4GatewayIP}\n next\n end\n set override disable\n set priority 255\n set unicast-hb enable\n set unicast-hb-peerip ${sn3IPfgb}\n end\n${fortiGateVIPConfig}\n${fortiGateIPv4Policy}\n${fmgCustomData}${fortiGateAdditionalCustomData}\n${fgaCustomDataFlexVM}\n'
var fgbCustomDataBody = 'config system sdn-connector\nedit AzureSDN\nset type azure\nnext\nend\nconfig router static\n edit 1\n set gateway ${sn1GatewayIP}\n set device port1\n next\n edit 2\n set dst ${vnetAddressPrefix}\n set gateway ${sn2GatewayIP}\n set device port2\n next\n edit 3\nset dst 168.63.129.16 255.255.255.255\nset device port2\n set gateway ${sn2GatewayIP}\n next\nedit 4\nset dst 168.63.129.16 255.255.255.255\nset device port1\n set gateway ${sn1GatewayIP}\n next\n end\n config system probe-response\n set http-probe-value OK\n set mode http-probe\n end\n config system interface\n edit port1\n set mode static\n set ip ${sn1IPfgb}/${sn1CIDRmask}\n set description external\n set allowaccess probe-response\n next\n edit port2\n set mode static\n set ip ${sn2IPfgb}/${sn2CIDRmask}\n set description internal\n set allowaccess probe-response\n next\n edit port3\n set mode static\n set ip ${sn3IPfgb}/${sn3CIDRmask}\n set description hasyncport\n next\n edit port4\n set mode static\n set ip ${sn4IPfgb}/${sn4CIDRmask}\n set description management\n set allowaccess ping https ssh ftm\n next\n end\n config system ha\n set group-name AzureHA\n set mode a-p\n set hbdev port3 100\n set session-pickup enable\n set session-pickup-connectionless enable\n set ha-mgmt-status enable\n config ha-mgmt-interfaces\n edit 1\n set interface port4\n set gateway ${sn4GatewayIP}\n next\n end\n set override disable\n set priority 1\n set unicast-hb enable\n set unicast-hb-peerip ${sn3IPfga}\n end\n${fortiGateVIPConfig}\n${fortiGateIPv4Policy}\n${fmgCustomData}${fortiGateAdditionalCustomData}\n${fgBCustomDataFlexVM}\n'
var customDataLicenseHeader = '--12345\nContent-Type: text/plain; charset="us-ascii"\nMIME-Version: 1.0\nContent-Transfer-Encoding: 7bit\nContent-Disposition: attachment; filename="fgtlicense"\n\n'
var customDataFooter = '--12345--\n'
var fortiGateVIPConfig = '\nconfig firewall vip\nedit "WS-RDP_VIP"\nset extip ${publicIP1Name_resource.properties.ipAddress}\nset mappedip "172.16.137.4"\nset extintf "any"\nset portforward enable\nset extport 3389\nset mappedport 3389\nnext\nend\n'
var fortiGateIPv4Policy = '''
config firewall policy
    edit 1
        set name "RDP_Inbound_Access"
        set srcintf "port1"
        set dstintf "port2"
        set action accept
        set srcaddr "all"
        set dstaddr "WS-RDP_VIP"
        set schedule "always"
        set service "RDP"
    next
    edit 2
        set name "WS_Outbound"
        set srcintf "port2"
        set dstintf "port1"
        set action accept
        set srcaddr "all"
        set dstaddr "all"
        set schedule "always"
        set service "ALL"
        set nat enable
    next
end
'''
var fgaCustomDataCombined = '${customDataHeader}${fgaCustomDataBody}${customDataLicenseHeader}${fortiGateLicenseBYOLA}${customDataFooter}'
var fgbCustomDataCombined = '${customDataHeader}${fgbCustomDataBody}${customDataLicenseHeader}${fortiGateLicenseBYOLB}${customDataFooter}'
var fgaCustomData = base64(((fortiGateLicenseBYOLA == '') ? fgaCustomDataBody : fgaCustomDataCombined))
var fgbCustomData = base64(((fortiGateLicenseBYOLB == '') ? fgbCustomDataBody : fgbCustomDataCombined))
var routeTableName_var = '${fortiGateNamePrefix}-RouteTable-${subnet5Name}'
var routeTableId = routeTableName.id
var fgaNic1Name_var = '${fgaVmName_var}-Nic1'
var fgaNic1Id = fgaNic1Name.id
var fgbNic1Name_var = '${fgbVmName_var}-Nic1'
var fgbNic1Id = fgbNic1Name.id
var fgaNic2Name_var = '${fgaVmName_var}-Nic2'
var fgaNic2Id = fgaNic2Name.id
var fgbNic2Name_var = '${fgbVmName_var}-Nic2'
var fgbNic2Id = fgbNic2Name.id
var fgaNic3Name_var = '${fgaVmName_var}-Nic3'
var fgaNic3Id = fgaNic3Name.id
var fgbNic3Name_var = '${fgbVmName_var}-Nic3'
var fgbNic3Id = fgbNic3Name.id
var fgaNic4Name_var = '${fgaVmName_var}-Nic4'
var fgaNic4Id = fgaNic4Name.id
var fgbNic4Name_var = '${fgbVmName_var}-Nic4'
var fgbNic4Id = fgbNic4Name.id
var serialConsoleStorageAccountName_var = 'console${uniqueString(resourceGroup().id)}'
var serialConsoleStorageAccountType = 'Standard_LRS'
var serialConsoleEnabled = ((serialConsole == 'yes') ? true : false)
var publicIP1Name_var = ((publicIP1Name == '') ? '${fortiGateNamePrefix}-FGT-PIP' : publicIP1Name)
var publicIP1Id = ((publicIP1NewOrExisting == 'new') ? publicIP1Name_resource.id : resourceId(publicIP1ResourceGroup, 'Microsoft.Network/publicIPAddresses', publicIP1Name_var))
var publicIP2Name_var = ((publicIP2Name == '') ? '${fortiGateNamePrefix}-FGT-A-MGMT-PIP' : publicIP2Name)
var publicIP2Id = ((publicIP2NewOrExisting == 'new') ? publicIP2Name_resource.id : resourceId(publicIP2ResourceGroup, 'Microsoft.Network/publicIPAddresses', publicIP2Name_var))
var publicIPAddress2Id = {
  id: publicIP2Id
}
var publicIP3Name_var = ((publicIP3Name == '') ? '${fortiGateNamePrefix}-FGT-B-MGMT-PIP' : publicIP3Name)
var publicIP3Id = ((publicIP3NewOrExisting == 'new') ? publicIP3Name_resource.id : resourceId(publicIP3ResourceGroup, 'Microsoft.Network/publicIPAddresses', publicIP3Name_var))
var publicIPAddress3Id = {
  id: publicIP3Id
}
var NSGName_var = '${fortiGateNamePrefix}-${uniqueString(resourceGroup().id)}-NSG'
var NSGId = NSGName.id
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
var sn1IPfga = '${sn1IPArray0}.${sn1IPArray1}.${sn1IPArray2}.${int(sn1IPStartAddress[3])}'
var sn1IPfgb = '${sn1IPArray0}.${sn1IPArray1}.${sn1IPArray2}.${(int(sn1IPStartAddress[3]) + 1)}'
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
var sn2IPlb = '${sn2IPArray0}.${sn2IPArray1}.${sn2IPArray2}.${int(sn2IPStartAddress[3])}'
var sn2IPfga = '${sn2IPArray0}.${sn2IPArray1}.${sn2IPArray2}.${(int(sn2IPStartAddress[3]) + 1)}'
var sn2IPfgb = '${sn2IPArray0}.${sn2IPArray1}.${sn2IPArray2}.${(int(sn2IPStartAddress[3]) + 2)}'
var sn3IPArray = split(subnet3Prefix, '.')
var sn3IPArray2ndString = string(sn3IPArray[3])
var sn3IPArray2nd = split(sn3IPArray2ndString, '/')
var sn3CIDRmask = string(int(sn3IPArray2nd[1]))
var sn3IPArray2 = string(int(sn3IPArray[2]))
var sn3IPArray1 = string(int(sn3IPArray[1]))
var sn3IPArray0 = string(int(sn3IPArray[0]))
var sn3IPStartAddress = split(subnet3StartAddress, '.')
var sn3IPfga = '${sn3IPArray0}.${sn3IPArray1}.${sn3IPArray2}.${int(sn3IPStartAddress[3])}'
var sn3IPfgb = '${sn3IPArray0}.${sn3IPArray1}.${sn3IPArray2}.${(int(sn3IPStartAddress[3]) + 1)}'
var sn4IPArray = split(subnet4Prefix, '.')
var sn4IPArray2ndString = string(sn4IPArray[3])
var sn4IPArray2nd = split(sn4IPArray2ndString, '/')
var sn4CIDRmask = string(int(sn4IPArray2nd[1]))
var sn4IPArray3 = string((int(sn4IPArray2nd[0]) + 1))
var sn4IPArray2 = string(int(sn4IPArray[2]))
var sn4IPArray1 = string(int(sn4IPArray[1]))
var sn4IPArray0 = string(int(sn4IPArray[0]))
var sn4GatewayIP = '${sn4IPArray0}.${sn4IPArray1}.${sn4IPArray2}.${sn4IPArray3}'
var sn4IPStartAddress = split(subnet4StartAddress, '.')
var sn4IPfga = '${sn4IPArray0}.${sn4IPArray1}.${sn4IPArray2}.${int(sn4IPStartAddress[3])}'
var sn4IPfgb = '${sn4IPArray0}.${sn4IPArray1}.${sn4IPArray2}.${(int(sn4IPStartAddress[3]) + 1)}'
var internalLBName_var = '${fortiGateNamePrefix}-InternalLoadBalancer'
var internalLBFEName = '${fortiGateNamePrefix}-ILB-${subnet2Name}-FrontEnd'
var internalLBFEId = resourceId('Microsoft.Network/loadBalancers/frontendIPConfigurations/', internalLBName_var, internalLBFEName)
var internalLBBEName = '${fortiGateNamePrefix}-ILB-${subnet2Name}-BackEnd'
var internalLBBEId = resourceId('Microsoft.Network/loadBalancers/backendAddressPools/', internalLBName_var, internalLBBEName)
var internalLBProbeName = 'lbprobe'
var internalLBProbeId = resourceId('Microsoft.Network/loadBalancers/probes/', internalLBName_var, internalLBProbeName)
var externalLBName_var = '${fortiGateNamePrefix}-ExternalLoadBalancer'
var externalLBFEName = '${fortiGateNamePrefix}-ELB-${subnet1Name}-FrontEnd'
var externalLBFEId = resourceId('Microsoft.Network/loadBalancers/frontendIPConfigurations/', externalLBName_var, externalLBFEName)
var externalLBBEName = '${fortiGateNamePrefix}-ELB-${subnet1Name}-BackEnd'
var externalLBBEId = resourceId('Microsoft.Network/loadBalancers/backendAddressPools/', externalLBName_var, externalLBBEName)
var externalLBProbeName = 'lbprobe'
var externalLBProbeId = resourceId('Microsoft.Network/loadBalancers/probes/', externalLBName_var, externalLBProbeName)
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

resource availabilitySetName 'Microsoft.Compute/availabilitySets@2021-03-01' = if (!useAZ) {
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

resource routeTableName 'Microsoft.Network/routeTables@2020-04-01' = {
  name: routeTableName_var
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  location: location
  properties: {
    routes: [
      {
        name: 'toDefault'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: sn2IPlb
        }
      }
    ]
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
      {
        name: subnet3Name
        properties: {
          addressPrefix: subnet3Prefix
        }
      }
      {
        name: subnet4Name
        properties: {
          addressPrefix: subnet4Prefix
        }
      }
      {
        name: subnet5Name
        properties: {
          addressPrefix: subnet5Prefix
          routeTable: {
            id: routeTableId
          }
        }
      }
    ]
  }
}


resource internalLBName 'Microsoft.Network/loadBalancers@2020-04-01' = {
  name: internalLBName_var
  location: location
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  sku: {
    name: 'Standard'
  }
  properties: {
    frontendIPConfigurations: [
      {
        name: internalLBFEName
        properties: {
          privateIPAddress: sn2IPlb
          privateIPAllocationMethod: 'Static'
          subnet: {
            id: subnet2Id
          }
        }
      }
    ]
    backendAddressPools: [
      {
        name: internalLBBEName
      }
    ]
    loadBalancingRules: [
      {
        properties: {
          frontendIPConfiguration: {
            id: internalLBFEId
          }
          backendAddressPool: {
            id: internalLBBEId
          }
          probe: {
            id: internalLBProbeId
          }
          protocol: 'All'
          frontendPort: 0
          backendPort: 0
          enableFloatingIP: true
          idleTimeoutInMinutes: 5
        }
        name: 'lbruleFE2all'
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
        name: internalLBProbeName
      }
    ]
  }
  dependsOn: [
    vnetName_resource
  ]
}

resource NSGName 'Microsoft.Network/networkSecurityGroups@2020-04-01' = {
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  name: NSGName_var
  location: location
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
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  name: publicIP1Name_var
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    dnsSettings: {
      domainNameLabel: '${toLower(fortiGateNamePrefix)}-${uniqueString(resourceGroup().id)}'
    }
  }
}

resource publicIP2Name_resource 'Microsoft.Network/publicIPAddresses@2020-04-01' = if (publicIP2NewOrExisting == 'new') {
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  name: publicIP2Name_var
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource publicIP3Name_resource 'Microsoft.Network/publicIPAddresses@2020-04-01' = if (publicIP3NewOrExisting == 'new') {
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  name: publicIP3Name_var
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource externalLBName 'Microsoft.Network/loadBalancers@2020-04-01' = {
  name: externalLBName_var
  location: location
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  sku: {
    name: 'Standard'
  }
  properties: {
    frontendIPConfigurations: [
      {
        name: externalLBFEName
        properties: {
          publicIPAddress: {
            id: publicIP1Id
          }
        }
      }
    ]
    backendAddressPools: [
      {
        name: externalLBBEName
      }
    ]
    loadBalancingRules: [
      {
        properties: {
          frontendIPConfiguration: {
            id: externalLBFEId
          }
          backendAddressPool: {
            id: externalLBBEId
          }
          probe: {
            id: externalLBProbeId
          }
          protocol: 'Tcp'
          frontendPort: 3389
          backendPort: 3389
          enableFloatingIP: true
          idleTimeoutInMinutes: 5
        }
        name: 'PublicLBRule-FE1-RDP'
      }
      {
        properties: {
          frontendIPConfiguration: {
            id: externalLBFEId
          }
          backendAddressPool: {
            id: externalLBBEId
          }
          probe: {
            id: externalLBProbeId
          }
          protocol: 'Udp'
          frontendPort: 10551
          backendPort: 10551
          enableFloatingIP: true
          idleTimeoutInMinutes: 5
        }
        name: 'PublicLBRule-FE1-udp10551'
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
        name: externalLBProbeName
      }
    ]
  }
}

resource fgaNic1Name 'Microsoft.Network/networkInterfaces@2020-04-01' = {
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  name: fgaNic1Name_var
  location: location
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
              id: externalLBBEId
            }
          ]
        }
      }
    ]
    enableIPForwarding: true
    enableAcceleratedNetworking: acceleratedNetworking
    networkSecurityGroup: {
      id: NSGId
    }
  }
  dependsOn: [
    vnetName_resource
    externalLBName
  ]
}

resource fgbNic1Name 'Microsoft.Network/networkInterfaces@2020-04-01' = {
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  name: fgbNic1Name_var
  location: location
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
              id: externalLBBEId
            }
          ]
        }
      }
    ]
    enableIPForwarding: true
    enableAcceleratedNetworking: acceleratedNetworking
    networkSecurityGroup: {
      id: NSGId
    }
  }
  dependsOn: [
    vnetName_resource
    externalLBName
  ]
}

resource fgaNic2Name 'Microsoft.Network/networkInterfaces@2020-04-01' = {
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  name: fgaNic2Name_var
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Static'
          privateIPAddress: sn2IPfga
          subnet: {
            id: subnet2Id
          }
          loadBalancerBackendAddressPools: [
            {
              id: internalLBBEId
            }
          ]
        }
      }
    ]
    enableIPForwarding: true
    enableAcceleratedNetworking: acceleratedNetworking
    networkSecurityGroup: {
      id: NSGId
    }
  }
  dependsOn: [
    vnetName_resource
    internalLBName
  ]
}

resource fgbNic2Name 'Microsoft.Network/networkInterfaces@2020-04-01' = {
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  name: fgbNic2Name_var
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Static'
          privateIPAddress: sn2IPfgb
          subnet: {
            id: subnet2Id
          }
          loadBalancerBackendAddressPools: [
            {
              id: internalLBBEId
            }
          ]
        }
      }
    ]
    enableIPForwarding: true
    enableAcceleratedNetworking: acceleratedNetworking
    networkSecurityGroup: {
      id: NSGId
    }
  }
  dependsOn: [
    vnetName_resource
    internalLBName
  ]
}

resource fgaNic3Name 'Microsoft.Network/networkInterfaces@2020-04-01' = {
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  name: fgaNic3Name_var
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Static'
          privateIPAddress: sn3IPfga
          subnet: {
            id: subnet3Id
          }
        }
      }
    ]
    enableIPForwarding: true
    enableAcceleratedNetworking: acceleratedNetworking
    networkSecurityGroup: {
      id: NSGId
    }
  }
  dependsOn: [
    vnetName_resource
  ]
}

resource fgbNic3Name 'Microsoft.Network/networkInterfaces@2020-04-01' = {
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  name: fgbNic3Name_var
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Static'
          privateIPAddress: sn3IPfgb
          subnet: {
            id: subnet3Id
          }
        }
      }
    ]
    enableIPForwarding: true
    enableAcceleratedNetworking: acceleratedNetworking
    networkSecurityGroup: {
      id: NSGId
    }
  }
  dependsOn: [
    vnetName_resource
  ]
}

resource fgaNic4Name 'Microsoft.Network/networkInterfaces@2020-04-01' = {
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  name: fgaNic4Name_var
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Static'
          privateIPAddress: sn4IPfga
          publicIPAddress: ((publicIP2NewOrExisting != 'none') ? publicIPAddress2Id : json('null'))
          subnet: {
            id: subnet4Id
          }
        }
      }
    ]
    enableIPForwarding: true
    enableAcceleratedNetworking: acceleratedNetworking
    networkSecurityGroup: {
      id: NSGId
    }
  }
  dependsOn: [
    vnetName_resource
  ]
}

resource fgbNic4Name 'Microsoft.Network/networkInterfaces@2020-04-01' = {
  tags: {
    provider: toUpper(fortinetTags.provider)
  }
  name: fgbNic4Name_var
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Static'
          privateIPAddress: sn4IPfgb
          publicIPAddress: ((publicIP3NewOrExisting != 'none') ? publicIPAddress3Id : json('null'))
          subnet: {
            id: subnet4Id
          }
        }
      }
    ]
    enableIPForwarding: true
    enableAcceleratedNetworking: acceleratedNetworking
    networkSecurityGroup: {
      id: NSGId
    }
  }
  dependsOn: [
    vnetName_resource
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
        {
          properties: {
            primary: false
          }
          id: fgaNic3Id
        }
        {
          properties: {
            primary: false
          }
          id: fgaNic4Id
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
        {
          properties: {
            primary: false
          }
          id: fgbNic3Id
        }
        {
          properties: {
            primary: false
          }
          id: fgbNic4Id
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

module WSDeployment 'azuredeploy-ws.bicep' = {
  name: 'Windows-Server-Deployment'
  params: {
    Username: adminUsername
    Password: adminPassword
    DeploymentPrefix: '${fortiGateNamePrefix}-WS'
    fortiGateNamePrefix: fortiGateNamePrefix
  }
  dependsOn: [
    vnetName_resource
  ]
}


output fortiGateFQDN string = ((publicIP1NewOrExisting == 'new') ? reference(publicIP1Id).dnsSettings.fqdn : '')
output fortiGateAManagementPublicIP string = ((publicIP2NewOrExisting == 'new') ? reference(publicIP2Id).ipAddress : '')
output fortiGateBManagementPublicIP string = ((publicIP3NewOrExisting == 'new') ? reference(publicIP3Id).ipAddress : '')
output WindowsServerVIP string = ((publicIP1NewOrExisting == 'new') ? reference(publicIP1Id).ipAddress : '')

