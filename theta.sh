#!/bin/bash

# Verificar si Docker está instalado
if ! command -v docker &> /dev/null; then > /dev/null 2>&1
    echo "Docker no está instalado. Por favor, instala Docker primero."
    exit 1
fi

# Solicitar la contraseña y volver a pedirla si está vacía
while true; do
    read -p "Por favor, ingresa tu contraseña: " EDGELAUNCHER_PASSWORD
    if [ -z "$EDGELAUNCHER_PASSWORD" ]; then
        echo "La contraseña no puede estar vacía. Inténtalo nuevamente."
    else
        break
    fi
done
echo

# Descargar la imagen de Docker con una barra de carga
echo "Descargando la imagen de Docker... Esto puede tardar algunos minutos."
docker pull thetalabsorg/edgelauncher_mainnet:latest
# Comprobar si la descarga fue exitosa
if [ $? -eq 0 ]; then
    echo "Imagen descargada exitosamente."
else
    echo "Hubo un error al descargar la imagen."
    exit 1
fi

# Eliminar cualquier contenedor anterior llamado edgelauncher
docker rm edgelauncher > /dev/null 2>&1

# Ejecutar el contenedor con la configuración indicada
echo "Ejecutando el contenedor de Theta Edge Node..."
docker run -e EDGELAUNCHER_CONFIG_PATH=/edgelauncher/data/mainnet \
           -e PASSWORD=$EDGELAUNCHER_PASSWORD \
           -v ~/.edgelauncher:/edgelauncher/data/mainnet \
           -p 127.0.0.1:15888:15888 \
           -p 127.0.0.1:17888:17888 \
           -p 127.0.0.1:17935:17935 \
           --name edgelauncher -it thetalabsorg/edgelauncher_mainnet:latest

# Verificar si el contenedor se ejecutó correctamente
if [ $? -eq 0 ]; then
    echo "¡Instalación exitosa! El Theta Edge Node está corriendo."
else
    echo "Hubo un error al ejecutar el contenedor."
    exit 1
fi
