#!/bin/bash

# Actualiza los repositorios de apt-get
sudo apt-get update

# Instala los paquetes necesarios para usar el repositorio HTTPS de Docker
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y

# Agrega la clave GPG oficial de Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Agrega el repositorio de Docker al sistema
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Actualiza los repositorios de apt-get para incluir el repositorio de Docker
sudo apt-get update

# Instala Docker
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

# Verifica si el servicio está en ejecución
#sudo systemctl status docker

#comrpobando que se instalo con un hello world
resultado=$(sudo docker run hello-world)
