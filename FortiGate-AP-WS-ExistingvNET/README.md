# Instructions:

# Create your Resource Group

az group create --location {Location} --name {ResourceGroupName}

# Deploy the Active/Active FortiGate Cluster with Windows Server in Protected Subnet

az deployment group create --name {FortiGateDeploymentName} --resource-group {ResourceGroupName} --template-file azuredeploy-fgt.bicep --parameters @azuredeploy-fgt.parameters.json

