#!/bin/bash
apt update -y; apt upgrade -y > /dev/null 2>&1
apt install curl -y

# Definir los enlaces a los scripts en GitHub
MENU_URL="https://raw.githubusercontent.com/ketfree/dockerinstall/refs/heads/main/menu.sh" > /dev/null 2>&1
DOCKER_URL="https://raw.githubusercontent.com/ketfree/dockerinstall/refs/heads/main/docker.sh" > /dev/null 2>&1
THETA_URL="https://raw.githubusercontent.com/ketfree/dockerinstall/refs/heads/main/theta.sh" > /dev/null 2>&1
FILE_URL="https://raw.githubusercontent.com/ketfree/dockerinstall/refs/heads/main/file.sh"
# Descargar los tres scripts desde GitHub
echo "Descargando el script del menú..."
curl -O $MENU_URL

echo "Descargando el script de instalación de Docker..."
curl -O $DOCKER_URL

echo "Descargando el script para instalar Theta Edge Node..."
curl -O $THETA_URL

echo "Descargando el script para instalar file..."
curl -O $FILE_URL

# Dar permisos de ejecución a los tres scripts
echo "Otorgando permisos de ejecución a los scripts..."
chmod +x menu.sh docker.sh theta.sh > /dev/null 2>&1

mkdir ~/.mis_scripts > /dev/null 2>&1
mv menu.sh docker.sh theta.sh file.sh ~/.mis_scripts/ > /dev/null 2>&1

# Verificar si el archivo .bashrc existe
if [ ! -f ~/.bashrc ]; then > /dev/null 2>&1
    echo "El archivo .bashrc no existe. Creándolo..."
    touch ~/.bashrc > /dev/null 2>&1
fi

# Agregar el alias al archivo .bashrc
echo "alias menu='~/.mis_scripts/menu.sh'" >> ~/.bashrc

# Recargar el archivo .bashrc
source ~/.bashrc > /dev/null 2>&1

# Ejecutar el menú
echo "Ejecutando el menú de instalación..."
source ~/.bashrc

menu > /dev/null 2>&1
