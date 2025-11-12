#!/bin/bash

# Log everything for debugging
exec > >(tee -a /var/log/user_data.log | logger -t user_data -s 2>/dev/console) 2>&1
set -x

# Wait for the network and IAM
sleep 10

for i in {1..5}; do
          mkdir -p /tmp/platform && break
          echo "mkdir failed, retrying in 5s..."
          sleep 5
        done
# Detect OS
OS=$(awk -F= '/^ID=/{print $2}' /etc/os-release | tr -d '"')

echo "Detected OS: $OS"

#######################################
# Ubuntu Docker Installation
#######################################
if [[ "$OS" == "ubuntu" ]]; then
    echo "Installing Docker for Ubuntu..."

    apt-get update -y
    apt-get install -y ca-certificates curl gnupg

    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    chmod a+r /etc/apt/keyrings/docker.gpg

    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    | tee /etc/apt/sources.list.d/docker.list > /dev/null

    apt-get update -y

    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    systemctl enable docker
    systemctl start docker
    usermod -aG docker ubuntu

    # download script and execute
    for i in {1..5}; do
        if curl -fsSL -o /tmp/platform/docker-compose.yml https://raw.githubusercontent.com/Carlo-05/Docker-Arcade-Platform-Project/refs/heads/main/documents/docker-compose.yml; then
            echo "docker-compose file download succeeded"
            break
        else
            echo "Attempt downloading docker-compose file failed, retrying in 10s..."
            sleep 10
        fi
        done

    # download nginx config file
    for i in {1..5}; do
        if curl -fsSL -o /tmp/platform/nginx.conf https://raw.githubusercontent.com/Carlo-05/Docker-Arcade-Platform-Project/refs/heads/main/documents/nginx.conf; then
            echo "nginx.conf file download succeeded"
            break
        else
            echo "Attempt downloading nginx.conf file failed, retrying in 10s..."
            sleep 5
        fi
        done
    mv /tmp/platform /home/ubuntu/
#######################################
# Amazon Linux 2 Docker Installation
#######################################
elif [[ "$OS" == "amzn" ]]; then
    echo "Installing Docker for Amazon Linux 2..."

    yum update -y
    amazon-linux-extras install docker -y

    systemctl enable docker
    systemctl start docker

    # Add default user to docker group
    usermod -aG docker ec2-user

    # download script and execute
    for i in {1..5}; do
        if curl -fsSL -o /tmp/platform/docker-compose.yml https://raw.githubusercontent.com/Carlo-05/Docker-Arcade-Platform-Project/refs/heads/main/documents/docker-compose.yml; then
            echo "docker-compose file download succeeded"
            break
        else
            echo "Attempt downloading docker-compose file failed, retrying in 10s..."
            sleep 10
        fi
        done

    # download nginx config file
    for i in {1..5}; do
        if curl -fsSL -o /tmp/platform/nginx.conf https://raw.githubusercontent.com/Carlo-05/Docker-Arcade-Platform-Project/refs/heads/main/documents/nginx.conf; then
            echo "nginx.conf file download succeeded"
            break
        else
            echo "Attempt downloading nginx.conf file failed, retrying in 10s..."
            sleep 5
        fi
        done
    mv /tmp/platform /home/ec2-user/
else
    echo "Unsupported OS: $OS"
    exit 1
fi
echo "Docker installation complete!"

