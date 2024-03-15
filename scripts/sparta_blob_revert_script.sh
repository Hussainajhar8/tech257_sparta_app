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
