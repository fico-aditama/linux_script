#!/bin/bash

# Function to install Docker
install_docker() {
    echo "Installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    sudo usermod -aG docker $USER && newgrp docker
    dockerd-rootless-setuptool.sh install
    sudo apt install uidmap -y
    echo "Docker installation completed."
}

# Function to install Minikube and kubectl
install_minikube() {
    echo "Installing Minikube and kubectl..."

    # Update and upgrade system
    sudo apt update && sudo apt upgrade -y

    # Install dependencies
    sudo apt install -y curl wget apt-transport-https virtualbox

    # Download and install Minikube
    wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo cp minikube-linux-amd64 /usr/local/bin/minikube
    sudo chmod +x /usr/local/bin/minikube
    minikube version

    # Download and install kubectl
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/
    kubectl version -o yaml

    echo "Minikube and kubectl installation completed."
}

# Function to start Minikube
start_minikube() {
    echo "Starting Minikube with Docker driver..."
    minikube start --driver=docker
    minikube start --addons=ingress --cpus=2 --cni=flannel --install-addons=true --kubernetes-version=stable --memory=6g
    minikube status
    kubectl cluster-info
    kubectl get nodes
    minikube addons list
    minikube dashboard
    echo "Minikube started successfully."
}

# Main script execution
echo "Script to install Docker, Minikube (Kubernetes), and Docker Apps"
echo "Choose an option to proceed:"
echo "1. Install Docker"
echo "2. Install Minikube and kubectl"
echo "3. Start Minikube"
echo "4. Install Docker and Minikube (Complete Setup)"
echo "5. Exit"

read -rp "Enter your choice [1-5]: " choice

case $choice in
    1)
        install_docker
        ;;
    2)
        install_minikube
        ;;
    3)
        start_minikube
        ;;
    4)
        install_docker
        install_minikube
        start_minikube
        ;;
    5)
        echo "Exiting script."
        exit 0
        ;;
    *)
        echo "Invalid choice. Please run the script again."
        exit 1
        ;;
esac
