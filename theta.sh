#!/bin/bash

spinner() {
    local pid=$! # Captura el PID del último comando ejecutado en segundo plano
    local delay=0.1
    local spinstr='|/-\'
    while ps -p $pid > /dev/null; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    echo "     " # Limpia la línea después de terminar
}
# Verificar si Docker está instalado
if ! command -v docker &> /dev/null; then > /dev/null 2>&1
    echo "Docker no está instalado. Por favor, instala Docker primero."
    exit 1
fi

# Solicitar la contraseña para la instalación (la contraseña será visible mientras se escribe)
read -p "Por favor, ingresa tu contraseña: " EDGELAUNCHER_PASSWORD
echo

# Descargar la imagen de Docker con una barra de carga
echo "Descargando la imagen de Docker... Esto puede tardar algunos minutos."
docker pull thetalabsorg/edgelauncher_mainnet:latest > /dev/null 2>&1 & spinner

# Comprobar si la descarga fue exitosa
if [ $? -eq 0 ]; then > /dev/null 2>&1
    echo "Imagen descargada exitosamente."
else
    echo "Hubo un error al descargar la imagen."
    exit 1
fi

# Eliminar cualquier contenedor anterior llamado edgelauncher
docker rm edgelauncher > /dev/null 2>&1

# Ejecutar el contenedor con la configuración indicada
echo "Ejecutando el contenedor de Theta Edge Node..."
docker run -e EDGELAUNCHER_CONFIG_PATH=/edgelauncher/data/mainnet \ > /dev/null 2>&1
           -e PASSWORD=$EDGELAUNCHER_PASSWORD \ > /dev/null 2>&1
           -v ~/.edgelauncher:/edgelauncher/data/mainnet \ > /dev/null 2>&1
           -p 127.0.0.1:15888:15888 \ > /dev/null 2>&1
           -p 127.0.0.1:17888:17888 \ > /dev/null 2>&1
           -p 127.0.0.1:17935:17935 \ > /dev/null 2>&1
           --name edgelauncher -it thetalabsorg/edgelauncher_mainnet:latest > /dev/null 2>&1 & spinner

# Verificar si el contenedor se ejecutó correctamente
if [ $? -eq 0 ]; then
    echo "¡Instalación exitosa! El Theta Edge Node está corriendo."
else
    echo "Hubo un error al ejecutar el contenedor."
    exit 1
fi
