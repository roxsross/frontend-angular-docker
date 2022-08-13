#!/bin/bash

echo "init System"
sudo apt-get update
sudo apt-get install -y docker.io
sudo apt-get install -y git jq curl

# Install Docker Compose on Ubuntu
DC_VERSION=$(curl -L -s -H 'Accept: application/json' https://github.com/docker/compose/releases/latest | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
sudo curl -L "https://github.com/docker/compose/releases/download/$DC_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "docker-compose version"
docker-compose --version

echo "docker version"
docker --version

echo "Finish install"