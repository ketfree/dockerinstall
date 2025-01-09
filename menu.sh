#!/bin/bash

# Colores
NC='\033[0m'  # Sin color
Red='\033[0;31m'
Green='\033[0;32m'
Yellow='\033[1;33m'
Blue='\033[0;34m'
Purple='\033[0;35m'
Cyan='\033[0;36m'
White='\033[1;37m'

# Función para mostrar el menú
menu() {
    clear  # Limpiar la pantalla antes de mostrar el menú
    echo -e "\033[0;36m
      ▄▀▄─────▄▀▄
─────▄█░░▀▀▀▀▀░░█▄
─▄▄──█░░░░░░░░░░░█──▄▄
█▄▄█─█░░▀░░┬░░▀░░█─█▄▄█\033[0m"

    echo -e "\033[0;32m#############################"
    echo -e "\033[0;32m#\033[0m \033[0;34mMenú de Instalación \033[0m"
    echo -e "\033[0;32m############################# \033[0m"
    echo -e "\033[1;33mSelecciona una opción: \033[0m"
    echo -e "\033[0;36m1. \033[0m Instalar Docker \033[0m"
    echo -e "\033[0;36m2. \033[0m Instalar Theta Edge Node \033[0m"
    echo -e "\033[0;36m3. \033[0m Subir la key wallet \033[0m"
    echo -e "\033[0;36m4. \033[0m ver contenedores \033[0m"
    echo -e "\033[0;36m0. \033[0m Salir \033[0m"
    echo -e "\033[1;33m***************************** \033[0m"
    
    read -p "Opción: " opcion
    case $opcion in
        1)
            echo -e "${Green}Instalando Docker...${NC}"
            ~/.mis_scripts/docker.sh
            ;;
        2)
            echo -e "${Green}Instalando Theta Edge Node...${NC}"
            ~/.mis_scripts/theta.sh
            ;;
        3)
            echo -e "${Green}Subiendo la key wallet...${NC}"
            # Llama al script de subida del archivo
            ~/.mis_scripts/file.sh
            ;;
        4)
            echo -e "${Green}Ejecutando docker ps...${NC}"
            # Ejecutar el comando docker ps
            docker ps
            ;;
        0)
            echo -e "${Yellow}Saliendo...${NC}"
            exit 0  # Termina el script
            ;;
        *)
            echo -e "${Red}Opción inválida${NC}"
            ;;
    esac
    # Esperar antes de mostrar nuevamente el menú
    read -p "Presiona Enter para continuar..." dummy
}

#~/.mis_scripts/menu.sh

# Mostrar el menú
while true; do
    menu
done
