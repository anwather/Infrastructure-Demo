Param($EnvironmentName)

$jsonFile = Get-Content ".\Parameters\$($EnvironmentName).json" | ConvertFrom-Json

New-AzResourceGroup -Name $jsonFile.resourceGroupName -Location $jsonFile.region -Force -Verbose

$params = @{
    virtualNetworkName = $jsonFile.virtualNetworkName
    addressSpace       = $jsonFile.addressSpace
    environment        = $EnvironmentName
    location           = $jsonFile.region
}

New-AzResourceGroupDeployment -ResourceGroupName $jsonFile.resourceGroupName -TemplateFile '.\Templates\vnet.json' -TemplateParameterObject $params -Verbose


