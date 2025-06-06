#!/bin/bash

KEY_NAME="lightsail_key"
KEY_PATH="$HOME/.ssh/$KEY_NAME"

# Check if key already exists
if [ -f "$KEY_PATH" ]; then
    echo "SSH key already exists at $KEY_PATH"
else
    echo "Generating new SSH key..."
    ssh-keygen -t rsa -b 4096 -C "lightsail-deploy" -f "$KEY_PATH" -N ""
    echo "SSH key generated at $KEY_PATH"
fi

PUB_KEY=$(cat "${KEY_PATH}.pub")

# Output public key for GitHub
echo -e "\nCopy the following public key to your GitHub account:"
echo "--------------------------------------------"
echo "$PUB_KEY"
echo "--------------------------------------------"
