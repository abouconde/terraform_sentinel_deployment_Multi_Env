
# Log in to Azure
Write-Host "Logging into Azure..."
$credential = Get-Credential
Connect-AzAccount -Credential $credential

# List available subscriptions
$subscriptions = Get-AzSubscription | Select-Object Name
Write-Host "Available Subscriptions:"
$subscriptions | ForEach-Object { Write-Host $_.Name }

# Prompt the user to select a subscription
$subscriptionName = Read-Host "Please enter the subscription name"
$subscription = Get-AzSubscription | Where-Object { $_.Name -eq $subscriptionName } | Select-Object -First 1
Set-AzContext -SubscriptionId $subscription.Id

# Initialize Terraform
Write-Host "Initializing Terraform..."
terraform init -reconfigure

# Apply the Terraform configuration for each environment
$environments = @("dev", "staging", "prod")
foreach ($env in $environments) {
    Write-Host "Applying Terraform configuration for $env environment..."
    terraform apply -var "environment=$env" -var "prefix=mug" -auto-approve
}

# Prompt for cleanup at the end
$cleanup = Read-Host "Do you want to delete the deployed resources? (yes/no)"
if ($cleanup -eq "yes") {
    foreach ($env in $environments) {
        Write-Host "Destroying resources for $env environment..."
        terraform destroy -var "environment=$env" -var "prefix=mug" -auto-approve
    }
}
