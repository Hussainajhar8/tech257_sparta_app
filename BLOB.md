# Blob Storage Documentation

## Overview

Blob storage in Azure is a service designed for storing unstructured data like documents, images, and videos. It's an object-based storage solution where data is stored in containers within storage accounts.

### Key Concepts

- **Object Storage**: Blob storage is an object-based storage system, allowing for unstructured data.

- **Resource Group, Storage Account, and Container**: To use blob storage, you'll need to set up a resource group, a storage account, and a storage container. Blobs are stored within containers.

- **Redundancy Options**: Blob storage offers redundancy options to ensure data durability. The Locally Redundant Storage (LRS) option is cost-effective, storing three copies of data locally within a region for redundancy.

## Installation

To interact with Azure blob storage, you'll need to install the Azure CLI on your VM. Use the following command:

`curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash`

## Commands

Here are the commands we used for managing blob storage:

1. **Login to Azure**:
   `az login`

2. **Create Storage Account**:
   `az storage account create --name <name> --resource-group <rg-name> --location uksouth --sku Standard_LRS`

3. **List Storage Accounts**:
   `az storage account list --resource-group tech257`

4. **List Storage Accounts (Formatted)**:
   `az storage account list --resource-group tech257 --query "[].{Name:name, Location:location, Kind:kind}" --output table`
   (in JSON format and not easy to read)

5. **Create Storage Container**:
   `az storage container create --account-name tech257ajharstorage --name testcontainer`
   (Commands still run but we get yellow text warning to provide credentials, to resolve this we will use –auth-mode login in future commands)

6. **Delete Storage Container**:
   `az storage container delete --account-name tech257ajharstorage --name testcontainer --auth-mode login`
   (This ^ didn’t work as intended because the backslash “\” wasn’t at the end of –name testcontainer so ran –auth-mode as a separate command)

7. **List Storage Containers**:
   `az storage container list --account-name tech257ajharstorage --output table --auth-mode login`
   (For a more user-friendly list format)

8. **Upload Blob**:
   `az storage blob upload --account-name tech257ajharstorage --container-name testcontainer --name newname.txt --file test.txt --auth-mode login`

9. **List Blobs**:
   `az storage blob list --account-name tech257ajharstorage --container-name testcontainer --output table --auth-mode login`
