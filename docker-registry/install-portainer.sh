#!/bin/bash

# Update reposistories 

sudo apt update

# Install Docker 

sudo apt install -y docker.io

# Download portainer image and run it as a container

docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

# Check portainer container has started

docker ps
