#!/bin/bash

# Definir los enlaces a los scripts en GitHub
MENU_URL="https://raw.githubusercontent.com/ketfree/dockerinstall/refs/heads/main/menu.sh"
DOCKER_URL="https://raw.githubusercontent.com/ketfree/dockerinstall/refs/heads/main/docker.sh"
THETA_URL="https://raw.githubusercontent.com/ketfree/dockerinstall/refs/heads/main/theta.sh"

# Descargar los tres scripts desde GitHub
echo "Descargando el script del menú..."
curl -O $MENU_URL

echo "Descargando el script de instalación de Docker..."
curl -O $DOCKER_URL

echo "Descargando el script para instalar Theta Edge Node..."
curl -O $THETA_URL

# Dar permisos de ejecución a los tres scripts
echo "Otorgando permisos de ejecución a los scripts..."
chmod +x menu.sh docker.sh theta.sh

# Ejecutar el menú
echo "Ejecutando el menú de instalación..."
./menu.sh
