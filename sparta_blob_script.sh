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

# Replace the image source in the index.ejs file
sudo sudo sed -i "28s~.*~    <img src=\"$blob_url\" />~" /tech257_sparta_app/repo/app/views/index.ejs

# Print the index.ejs file for testing purposes
# cat /tech257_sparta_app/repo/app/views/index.ejs