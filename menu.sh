#!/bin/bash

# Alias para mostrar el menú
alias menu='echo "Selecciona una opción:"; echo "1. Instalar Docker"; echo "2. Instalar Theta Edge Node"; read -p "Opción: " opcion; case $opcion in 1) ./docker.sh ;; 2) ./theta.sh ;; *) echo "Opción inválida";; esac'

# Actualizar el sistema
echo "Actualizando el sistema..."
apt-get update -y && apt-get upgrade -y

# Mostrar el menú
menu
