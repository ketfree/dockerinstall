#!/bin/bash
clear

# Función para mostrar el menú
menu() {
    echo "Selecciona una opción:"
    echo "1. Instalar Docker"
    echo "2. Instalar Theta Edge Node"
    read -p "Opción: " opcion
    case $opcion in
        1) ./docker.sh ;;
        2) ./theta.sh ;;
        *) echo "Opción inválida";;
    esac
}
