#!/bin/bash

set -e

# Required input
PROJECT_NAME=$1
GITHUB_USER=$2

if [ -z "$PROJECT_NAME" ] || [ -z "$GITHUB_USER" ]; then
    echo "Usage: ./setup.sh <project_name> <github_user>"
    exit 1
fi

# Install dependencies
sudo yum update -y
sudo yum install -y git nginx python3-pip
python3.12 -m ensurepip --upgrade

# Configure SSH for GitHub access
mkdir -p ~/.ssh
chmod 700 ~/.ssh
if [ ! -f ~/.ssh/lightsail_key ]; then
    echo "No SSH key found. Generate one with ssh-keygen and add it to your GitHub account."
    exit 1
fi

# Clone repo
cd /home/ec2-user
if [ ! -d "$PROJECT_NAME" ]; then
    git clone git@github.com:$GITHUB_USER/$PROJECT_NAME.git
fi
cd "$PROJECT_NAME"

sudo yum install python3.12
# Install Python dependencies
 pip3.12 install -r requirements.txt

# Copy and enable systemd service
sudo cp ../lightsail-django-setup/config/django.service /etc/systemd/system/${PROJECT_NAME}.service
sudo sed -i "s|{{PROJECT_PATH}}|/home/ec2-user/$PROJECT_NAME|g" /etc/systemd/system/${PROJECT_NAME}.service
sudo systemctl daemon-reload
sudo systemctl enable ${PROJECT_NAME}.service
sudo systemctl restart ${PROJECT_NAME}.service

# Setup nginx
sudo mkdir -p /etc/nginx/sites-available /etc/nginx/sites-enabled
sudo bash ../lightsail-django-setup/scripts/create_nginx_conf.sh "$PROJECT_NAME" > /etc/nginx/sites-available/${PROJECT_NAME}
sudo ln -sf /etc/nginx/sites-available/${PROJECT_NAME} /etc/nginx/sites-enabled/${PROJECT_NAME}

# Ensure nginx.conf includes sites-enabled
sudo grep -qxF 'include /etc/nginx/sites-enabled/*;' /etc/nginx/nginx.conf || \
    sudo sed -i '/http {/a include /etc/nginx/sites-enabled/*;' /etc/nginx/nginx.conf

# Restart nginx
sudo systemctl restart nginx