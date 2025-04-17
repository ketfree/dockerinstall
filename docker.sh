#!/bin/bash

# Limpiar la pantalla
clear

# Verificar si se ejecuta como root
if [[ $EUID -ne 0 ]]; then
    echo "Este script debe ejecutarse como root o con sudo."
    exit 1
fi

echo "========== Instalación de Docker =========="

# Actualizar sistema
echo "Actualizando repositorios y paquetes..."
apt-get update -y > /dev/null && apt-get upgrade -y > /dev/null
echo "✔ Sistema actualizado."

# Eliminar versiones antiguas de Docker (si existen)
echo "Eliminando versiones antiguas de Docker (si las hay)..."
apt-get remove -y docker docker-engine docker.io containerd runc > /dev/null 2>&1

# Instalar dependencias necesarias
echo "Instalando paquetes necesarios..."
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release > /dev/null
echo "✔ Paquetes necesarios instalados."

# Agregar la clave GPG de Docker
echo "Agregando la clave GPG oficial de Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Agregar repositorio oficial de Docker
echo "Agregando repositorio de Docker..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  > /etc/apt/sources.list.d/docker.list

# Actualizar repositorios con Docker incluido
apt-get update -y > /dev/null

# Instalar Docker Engine
echo "Instalando Docker Engine..."
apt-get install -y docker-ce docker-ce-cli containerd.io > /dev/null
echo "✔ Docker instalado."

# Habilitar e iniciar Docker
systemctl enable docker
systemctl start docker

# Verificar la instalación con contenedor hello-world
echo "Verificando instalación de Docker..."
if docker run --rm hello-world > /dev/null 2>&1; then
    echo "✔ Docker se instaló y verificó correctamente."
else
    echo "✘ Error al verificar Docker. Revisa la instalación manualmente."
    exit 1
fi
