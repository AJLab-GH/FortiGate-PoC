# Instructions:

# Create your Resource Group

az group create --location {Location} --name {ResourceGroupName}

# Deploy the Active/Active FortiGate Cluster with GWLB 

az deployment group create --name {GWLBDeploymentName} --resource-group {ResourceGroupName} --template-file azuredeploy-fgt.bicep --parameters @azuredeploy-fgt.parameters.json

# Get Deployment Outputs and RDP to the address provided for "WindowsServerVIP"

az deployment group show  -g {ResourceGroupName} -n Windows-Server-Deployment  --query properties.outputs

