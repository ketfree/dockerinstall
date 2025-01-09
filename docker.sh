#!/bin/bash

# Función para mostrar el spinner mientras se ejecuta un comando en segundo plano
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

# Limpiar la pantalla antes de comenzar
clear

# Actualizar el sistema
echo "Actualizando repositorios y paquetes del sistema..."
(sudo apt-get update -y > /dev/null 2>&1 && sudo apt-get upgrade -y > /dev/null 2>&1) & spinner
echo "✔ Sistema actualizado correctamente."

# Instalar los paquetes necesarios para usar el repositorio HTTPS de Docker
echo "Instalando paquetes necesarios para Docker..."
(sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release > /dev/null 2>&1) & spinner
echo "✔ Paquetes necesarios instalados."

# Agregar la clave GPG oficial de Docker
echo "Agregando la clave GPG de Docker..."
(curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg > /dev/null 2>&1) & spinner
echo "✔ Clave GPG de Docker agregada."

# Agregar el repositorio de Docker al sistema
echo "Agregando el repositorio de Docker al sistema..."
(
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" |
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null &&
    sudo apt-get update > /dev/null 2>&1
) & spinner
echo "✔ Repositorio de Docker agregado."

# Instalar Docker
echo "Instalando Docker..."
(sudo apt-get install -y docker-ce docker-ce-cli containerd.io > /dev/null 2>&1) & spinner
echo "✔ Docker instalado correctamente."

# Verificar la instalación de Docker con un contenedor de prueba
echo "Verificando la instalación de Docker..."
(sudo docker run hello-world > /dev/null 2>&1) & spinner

if [ $? -eq 0 ]; then
    echo "✔ Docker se instaló y verificó exitosamente."
else
    echo "✘ Hubo un problema al verificar la instalación de Docker."
fi
