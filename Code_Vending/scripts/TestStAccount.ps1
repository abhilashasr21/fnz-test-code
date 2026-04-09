
$resourceGroupName = "myResourceGroup"  
$location = "eastus2"
$storageAccountName = "mystorageaccount0612tf"
$subscriptionId = "5a395407-07f8-47a9-b8bf-92c05227486c"  # Replace with your Azure subscription ID

Connect-AzAccount
#set the subscription context if needed
Select-AzSubscription -SubscriptionId $subscriptionId


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
