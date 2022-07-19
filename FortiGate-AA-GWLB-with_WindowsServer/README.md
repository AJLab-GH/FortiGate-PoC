# Instructions

# Create your Resource Group

az group create --location <Location> --name <ResourceGroupName>

# Deploy the Active/Active FortiGate Cluster with GWLB 

az deployment group create --name <GWLBDeploymentName> --resource-group <ResourceGroupName> --template-file azuredeploy-fgt.bicep --parameters @azuredeploy-fgt.parameters.json

# After a successful deployment, output your deployment outputs

az deployment group show  -g <ResourceGroupName> -n <GWLBDeploymentName>  --query properties.outputs

# Deploy the GWLB Integrated Windows Server - You will need the fortiGateNamePrefix output from the previous command handy:

az deployment group create --name AJLabWSGWLB --resource-group AJLab-GWLB-RG --template-file azuredeploy-ws.bicep

# After a successful deployment, output the Windows Server Public IP, and connect via RDP:

az deployment group show  -g <ResourceGroupName>  -n <WSDeploymentName>   --query properties.outputs