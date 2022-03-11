# Azure File Processor

This repo includes code and assets to demonstrate how a system could upload and process files in Azure.

## Requirements

The following resources are required to use this demo.

- An Azure subscription. This is where the cluster virtual machines will be deployed.
- Azure CLI, +v2.34.1
- Terraform, +v1.1.7 on local machine. Terraform is used to provision the environment in Azure.

> This has been tested and verified using `Ubuntu 21.10`.

## Deploy Azure Infrastructure

This section will guide you through deploying the Azure infrastructure to support this solution.

### Set Terraform template variables

There is one template variable you may want to change before proceeding, which is the ___location___ (Azure region) where the solution will be deployed. This can be set in the `./az-infra/variables.tf` file. You're free to modify other variables to fit your needs.
### Authenticate to Azure

```bash
# Login to your Azure subscription
az login
```

### Deploy Azure infrastructure

```bash
# Change directory to where the Azure infrastructure assets are located in this repo
cd ./az-infra

# Deploy the Azure infrastructure
terraform init
terraform plan
terraform apply

# Move up one directory to the 'demo' folder
cd ..
```