#!/bin/bash

# This is a script to install Docker on the machine

# Update repos
apt update

# Install Docker

apt install -y docker.io

# Create a bridge network in Docker using

docker network create jenkins

# In order to execute Docker commands inside Jenkins nodes, download and run the docker:dind Docker image

docker run \
  --name jenkins-docker \
  --rm \
  --detach \
  --privileged \
  --network jenkins \
  --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --publish 2376:2376 \
  docker:dind \
  --storage-driver overlay2

# Build a new docker image from Dockerfile in the same repo and assign the image a meaningful name
docker build -t my-jenkins-itmo:2.387.2-1 .

# Run your own my-jenkins-itmo:2.387.2-1 image as a container in Docker

docker run \
  --name my-jenkins-itmo \
  --restart=on-failure \
  --detach \
  --network jenkins \
  --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client \
  --env DOCKER_TLS_VERIFY=1 \
  --publish 8080:8080 \
  --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  my-jenkins-itmo:2.387.2-1
