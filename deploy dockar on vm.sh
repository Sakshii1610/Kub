#Before running this script:

#Make sure you have an Ubuntu-based VM.
#Ensure you have appropriate permissions to execute the script, or run it as a user with sudo privileges.
#Review the script and adjust it as needed for your specific requirements.
#Here's how the script works:

#1.It updates the package list to ensure it has the latest package information.
#2.Installs necessary packages for adding Docker's official repository and handling HTTPS.
#3.Adds Docker's GPG key for package verification.
#4.Adds Docker's official repository to your VM's package sources.
#5.Updates the package list again with the new repository.
#6.Installs Docker.
#7.Starts and enables the Docker service.
#8.Checks the installed Docker version.
#9.Adds your user to the "docker" group so you can run Docker commands without using sudo. Note that you may need to log out and back in for this to take effect.
#After running the script, Docker should be installed and ready for use on your VM.


#!/bin/bash

# Update the package list
sudo apt update

# Install required packages to allow apt to use a repository over HTTPS
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package list (again) with the Docker repository
sudo apt update

# Install Docker
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Start and enable the Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Check Docker version
docker --version

# Add your user to the "docker" group to run Docker without sudo (you may need to log out and back in)
sudo usermod -aG docker $USER

# Print a message indicating that Docker has been installed
echo "Docker has been successfully installed. You may need to log out and back in for Docker to work without sudo."
