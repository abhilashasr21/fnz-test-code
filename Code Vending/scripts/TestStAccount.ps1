
$resourceGroupName = "myResourceGroup"  
$location = "eastus2"
$storageAccountName = "mystorageaccount0612tf"

$result = az storage account check-name --name $storageAccountName
if ($result.nameAvailable -eq $true) {
    Write-Host "The storage account doesn't exist."
    # Create a resource group
    New-AzResourceGroup -Name $resourceGroupName -Location $location    
    # Create a storage account
    New-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -Location $location -SkuName "Standard_LRS"
    # Output the storage account details
    Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName

    # Create a container in the storage account
    $storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName
    $ctx = $storageAccount.Context  
    New-AzStorageContainer -Name "mycontainer" -Context $ctx -Permission Off

} else {
    Write-Host "The storage account already exists."
    Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName
}
