# Deployment Guide: Sparta Test App on Azure VM

This guide provides step-by-step instructions for deploying the Sparta Test App on an Azure Linux VM. It covers two methods: copying the app folder directly from your local machine to the VM using SSH, and cloning the app from a GitHub repository onto the VM.

## Table of Contents

- [Deployment Guide: Sparta Test App on Azure VM](#deployment-guide-sparta-test-app-on-azure-vm)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Method 1: Copying App Folder using SCP](#method-1-copying-app-folder-using-scp)
  - [Method 2: Cloning from GitHub Repository](#method-2-cloning-from-github-repository)
  - [Testing the Application](#testing-the-application)
  - [Bash Script for Automation](#bash-script-for-automation)
- [Update and upgrade the system](#update-and-upgrade-the-system)
- [Install nginx](#install-nginx)
- [Start and enable nginx](#start-and-enable-nginx)
- [Install nodejs](#install-nodejs)
- [Clone the repository](#clone-the-repository)
- [Move to the app directory](#move-to-the-app-directory)
- [Install npm](#install-npm)
- [Install pm2](#install-pm2)
- [Start the app](#start-the-app)

## Overview

The Sparta Test App deployment involves setting up an Ubuntu 22.04 LTS Azure VM, installing Nginx, Node.js (version 20.x), and copying or cloning the app folder onto the VM. Additionally, the application needs to be started using the `npm start` or `pm2` command.

## Method 1: Copying App Folder using SCP

1. **SSH Key Setup**:
   - Add an SSH key to your local SSH agent.

2. **Copy App Folder**:
   - Navigate to the parent folder of your `tech257_sparta_app` folder.
   - Use SCP or Rsync to copy the `tech257_sparta_app` directory from your local machine to the Azure VM.

## Method 2: Cloning from GitHub Repository

1. **GitHub Repository Setup**:
   - Ensure the app folder is available on a GitHub public repository called `tech257-sparta-app`.

2. **Clone Repository**:
   - On the Azure VM, use the `git clone` command to clone the `tech257-sparta-app` repository onto the VM.

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
pm2 start app.js