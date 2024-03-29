# Blob Storage Documentation

## Overview

Blob storage in Azure is a service designed for storing unstructured data like documents, images, and videos. It's an object-based storage solution where data is stored in containers within storage accounts.

### Key Concepts

- **Object Storage**: Blob storage is an object-based storage system, allowing for unstructured data.

- **Resource Group, Storage Account, and Container**: To use blob storage, you'll need to set up a resource group, a storage account, and a storage container. Blobs are stored within containers.

- **Redundancy Options**: Blob storage offers redundancy options to ensure data durability. The Locally Redundant Storage (LRS) option is cost-effective, storing three copies of data locally within a region for redundancy.

### Difference Between Blob Storage and File System

- **Blob Storage**: Data in Blob Storage is organized in a flat hierarchy. It comprises a storage account, which can hold multiple containers, and each container can store an unlimited number of blobs (files). There are no traditional folders or directories, and blobs are accessed via unique URLs.

- **File System**: Operating systems like Linux, Windows, or Mac use a hierarchical structure with directories (folders) containing files. Navigation through directories is required to locate specific files.

### Advantages and Disadvantages of Blob Storage

**Advantages**:

- **Scalability**: Blob Storage can scale to handle massive volumes of data efficiently.
- **Accessibility**: Data stored in Blob Storage can be accessed from anywhere with an internet connection.
- **Durability**: Blob Storage offers high durability, ensuring data integrity even in the face of hardware failures.
- **Cost-Effectiveness**: It can be more cost-effective than maintaining an on-premises storage infrastructure.

**Disadvantages**:

- Blob Storage may lack certain features compared to traditional file systems in specific use cases.
- It may require some time to understand and adapt to Blob Storage, especially for users accustomed to traditional file systems.
- Blob Storage relies on internet connection which could be a blocker.

### Different Tiers in Blob Storage

- **Hot Access Tier**: Designed for frequently accessed data, offering higher storage costs but lower access costs.
- **Cool Access Tier**: Optimized for infrequently accessed data, featuring lower storage costs but higher access costs.
- **Archive Access Tier**: Tailored for rarely accessed data stored over extended periods, providing the lowest storage costs but highest access costs. 

### Parts of Azure Blob Storage

- **Account**: The primary storage account created in Azure, serving as a container for all stored data.
- **Container**: Within the storage account, users can create multiple containers, each acting as a bucket to store blobs.
- **Blob**: Actual files uploaded to Blob Storage, which can include various types of data.

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


## Getting started with automation
### Script to create storage account, container and upload image to application
```bash
#!/bin/bash

# Install azure cli on vm
# curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Login to azure
# az login

# Create a storage account
az storage account create --name tech257ajharstorage --resource-group tech257 --location uksouth --sku Standard_LRS --allow-blob-public-access true

# Sleep for 15 seconds to allow the storage account to be created
sleep 15

# Create a storage container
az storage container create \
    --account-name tech257ajharstorage \
    --name testcontainer \
    --auth-mode login \
    --public-access container

# Get cat image
curl -o cat_jumping.png https://as2.ftcdn.net/v2/jpg/05/99/90/93/1000_F_599909341_ACLSiB9s2KekiUlrEUCRlPyVAaY6XQFu.webp

# Upload cat image to blob
az storage blob upload \
    --account-name tech257ajharstorage \
    --container-name testcontainer \
    --name cat.png \
    --file cat_jumping.png \
    --auth-mode login \
    --overwrite

# Get the blob url
blob_url=$(az storage blob url \
    --account-name tech257ajharstorage \
    --container-name testcontainer \
    --name cat.png \
    --output tsv)

# Print the blob url for testing purposes
# echo "Blob URL: $blob_url"

# CD into app directory
cd /tech257_sparta_app/repo/app/

# Replace the image source in the index.ejs file
sudo sudo sed -i "28s~.*~    <img src=\"$blob_url\" />~" /tech257_sparta_app/repo/app/views/index.ejs

pm2 restart app.js

# Print the index.ejs file for testing purposes
# cat /tech257_sparta_app/repo/app/views/index.ejs
```

Script to revert back and remove storage account and image from application:
```bash
#!/bin/bash

# Install azure cli on vm
# curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Login to azure
# az login

# Delete the storage account
az storage account delete --name tech257ajharstorage --resource-group tech257

# Remove the cat image
sudo sed -i '28s/.*/ /' /tech257_sparta_app/repo/app/views/index.ejs

# CD into app directory
cd /tech257_sparta_app/repo/app/

# Stop any running processes
pm2 stop all

# Run the application using pm2
pm2 start app.js
```
