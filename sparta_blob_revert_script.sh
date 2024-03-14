#!/bin/bash

# Install azure cli on vm
# curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Login to azure
# az login

# Delete the storage account
az storage account delete --name tech257ajharstorage --resource-group tech257

# Remove the cat image
sudo sudo sed -i "28s~.*~" /tech257_sparta_app/repo/app/views/index.ejs
