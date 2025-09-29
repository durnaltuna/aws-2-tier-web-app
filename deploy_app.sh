#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration ---
# Get the public IP from your Terraform state
EC2_PUBLIC_IP=$(terraform output -raw web_server_public_ip)
# The name of the key file
SSH_KEY_FILE="~/my-terraform-key.pem"

# --- Deployment ---
echo "Copying essential project files to EC2 instance..."
# This command copies the essential files
scp -i "$SSH_KEY_FILE" app.py requirements.txt ubuntu@$EC2_PUBLIC_IP:/home/ubuntu/

echo "Connecting to EC2 instance and running deployment script..."
# The '<< EOF' tells the script to run the following commands on the server.
ssh -i "$SSH_KEY_FILE" ubuntu@$EC2_PUBLIC_IP << EOF

echo "Installing Python dependencies..."
sudo apt-get update
sudo apt-get install -y python3 python3-pip

pip3 install -r requirements.txt

# --- Database Variables ---
# Replace these with your actual credentials.
export DB_HOST=$(terraform output -raw rds_endpoint)
export DB_USER="admin1"
export DB_PASSWORD="Password123"
export DB_NAME="mydb"
# --- End Database Variables ---

echo "Killing any previous app processes..."
killall -q python3
    
echo "Starting Flask application..."
nohup python3 app.py > app.log 2>&1 &

echo "Deployment complete."
EOF