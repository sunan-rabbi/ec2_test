#!/bin/bash

echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "Installing essential tools..."
sudo apt install -y git curl nginx build-essential

echo "Basic file is installed!"
echo ""

#############################################
# PART 2 — Install Node.js
#############################################

echo "Installing NVM (Node Version Manager)..."

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.bashrc

nvm install --lts
nvm use --lts
echo ""

node -v
npm -v

#############################################
# PART 3 — Install & Configure PostgreSQL
#############################################

echo "Installing PostgreSQL..."
sudo apt install -y postgresql postgresql-contrib

echo "🔧 Starting PostgreSQL service..."
sudo systemctl start postgresql
sudo systemctl enable postgresql

echo "PostgreSQL installation completed!"