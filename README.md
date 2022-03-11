# Azure File Processor

This repo includes code and assets to demonstrate how a system could upload and process files in Azure.

## Requirements

The following resources are required to use this demo.

- An Azure subscription. This is where the cluster virtual machines will be deployed.
- Azure CLI, +v2.32.0
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
cd ./microEdge/src/microedge-kubelet/demo/azure-infra

# Deploy the Azure infrastructure
terraform init
terraform plan
terraform apply

# Move up one directory to the 'demo' folder
cd ..
```

> When the deployment finishes, the puplic IP address of the _controlplane_, _node01_, and _node02_ will be output to your terminal. Make a note of these as you will need them in the next section when setting up your environment variables.

After the deployment completes, enable JIT access to the _controlplane_, _node01_, and _node02_ virtual machines. Instructions to enable JIT VM access via the Azure port are [here](https://docs.microsoft.com/en-us/azure/defender-for-cloud/just-in-time-access-usage?tabs=jit-config-asc%2Cjit-request-asc#enable-jit-vm-access-).

In this section, you deployed 3 virtual machines in Azure. The _controlplane_ and _node01_ have the k3s components needed to form a cluster. _node02_ is just a clean virtual machine that will eventually host the microEdge kubelet.