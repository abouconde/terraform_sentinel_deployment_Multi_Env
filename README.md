This repository contains Terraform scripts and configurations for automating the deployment of Microsoft Sentinel, a cloud-native SIEM (Security Information and Event Management) solution on Azure. The configurations are tailored for a multi-stage deployment strategy, allowing for seamless and consistent setups across different environments - development, staging, and production - and regions - France Central (dev), North Europe (staging), and West Europe (prod). The repository includes Terraform scripts for resource provisioning, including Log Analytics Workspaces and necessary solutions, with a separate storage account configuration for the production environment. These scripts are designed with best practices and modularity in mind to facilitate maintenance and scalability. The repository also features PowerShell automation for initializing and applying the Terraform plans, listing Azure subscriptions, and managing the entire deployment lifecycle.
Features
Terraform configurations for multi-stage deployments.
Azure Log Analytics Workspaces setup.
Modular design for easy customization.
PowerShell scripts for environment management.
Requirements
Terraform v0.14.9 or higher.
Azure CLI.
PowerShell.
An Azure subscription with necessary permissions.
