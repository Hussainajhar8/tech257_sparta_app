#!/bin/bash

# Update and upgrade the system, `DEBIAN_FRONTEND=noninteractive` to bypass user-prompts
sudo DEBIAN_FRONTEND=noninteractive apt update -y
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y

# Install nginx
sudo DEBIAN_FRONTEND=noninteractive apt install nginx -y

# Start and enable nginx
sudo DEBIAN_FRONTEND=noninteractive systemctl restart nginx
sudo DEBIAN_FRONTEND=noninteractive systemctl enable nginx

# Install nodejs
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo DEBIAN_FRONTEND=noninteractive -E bash -
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs

# Clone the repository
git clone https://github.com/Hussainajhar8/tech257_sparta_app.git

# Configure reverse proxy
sudo sed -i '51s/.*/                proxy_pass http:\/\/localhost:3000;/' /etc/nginx/sites-available/default

# Reload Nginx to apply changes
sudo DEBIAN_FRONTEND=noninteractive systemctl reload nginx

# Move to the app directory
cd tech257_sparta_app/repo/app/

# Install npm
sudo DEBIAN_FRONTEND=noninteractive npm install

# Install pm2
sudo DEBIAN_FRONTEND=noninteractive npm install pm2@latest -g

# Start the app
pm2 start app.js

# Restart the process
pm2 restart app.js

# Save the process
pm2 save