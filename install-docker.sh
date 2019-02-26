#!/bin/bash

# Remove any old jank
printf '%s\n' "Updating apt caches and removing any old Docker related jank"
sudo apt update
sudo apt remove docker docker-engine docker.io containerd runc

# Installing pre-reqs
printf '%s\n' "Installing prerequisites"
sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

# Setup Docker Repos
printf '%s\n' "Adding Dockr GPG Keys and Repo"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Actually install Docker-CE
printf '%s\n' "Actually installing Docker-CE"
sudo apt update && sudo apt install docker-ce docker-ce-cli containerd.io

# Run Docker "Hello World" to confirm install
printf '%s\n' "Running Dockers Hello World to confirm install"
sudo docker run hello-world
