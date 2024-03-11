# Deployment Guide: Sparta Test App on Azure VM

To deploy Sparta Test App machine:

1. **Create VM with Ubuntu 22.04 LTS**:
   - Use Ubuntu 22.04 LTS for the VM image.
   - Create a virtual network (VNet) with CIDR range 10.0.0.0/16 and divide it into public and private subnets (e.g., public subnet: 10.0.0.0/24).
   - Launch the VM in the public subnet.
   
2. **Network Security Group (NSG)**:
   - Create a Network Security Group (NSG).
   - Allow inbound traffic for SSH (TCP port 22), HTTP (TCP port 80), and custom TCP port 3000.

## Overview

The Sparta Test App deployment involves setting up an Ubuntu 22.04 LTS Azure VM, installing Nginx, Node.js (version 20.x), and copying or cloning the app folder onto the VM. Additionally, the application needs to be started using the `npm start` or `pm2` command.

## Method 1: Copying App Folder using SCP

1. **SSH Key Setup**:
   - Add an SSH key to your local SSH agent.

2. **Copy App Folder**:
   - Navigate to the parent folder of your `tech257_sparta_app` folder.
   - Use SCP or Rsync to copy the `tech257_sparta_app` directory from your local machine to the Azure VM.<br>
   - You have to configure SSH agent with the private key for VM access:
     - Create an SSH agent process: eval `ssh-agent`
     - Add the SSH key to the SSH agent: `ssh-add ~/.ssh/<private_key_name>`
     - alternatively you can provide the input `-i ~/.ssh/<private_key_name>` to the scp command.

  <br>`scp -r path_to_app/app username@<public-ip>:/destination_path/`

## Method 2: Cloning from GitHub Repository

1. **GitHub Repository Setup**:
   - Ensure the app folder is available on a GitHub public repository called `tech257-sparta-app`.

2. **Clone Repository**:
   - On the Azure VM, use the `git clone` command to clone the `tech257-sparta-app` repository onto the VM.
  <br> Note: make sure to change into the correct directory before running npm commands (provided in order in the bash script provided at the bottom)

## Testing the Application

- Once the app is deployed, test it by accessing `<public IP>:3000` in a web browser.
- Use `CTRL+C` to exit and stop the app running.

## Bash Script for Automation

Use the provided Bash script to automate the deployment process. The script performs the following tasks:

1. Updates and upgrades the system.
2. Installs Nginx.
3. Installs Node.js (version 20.x).
4. Clones the `tech257_sparta_app` repository.
5. Installs npm and pm2.
6. Starts the application using pm2.

```bash
#!/bin/bash

# Update and upgrade the system
sudo apt update -y
sudo apt upgrade -y

# Install nginx
sudo apt install nginx -y

# Start and enable nginx
sudo systemctl restart nginx
sudo systemctl enable nginx

# Install nodejs
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# Clone the repository
git clone https://github.com/Hussainajhar8/tech257_sparta_app.git

# Move to the app directory
cd tech257_sparta_app/nodejs20-sparta-test-app/app/

# Install npm
sudo npm install

# Install pm2
sudo npm install pm2@latest -g

# Start the app
pm2 restart app.js