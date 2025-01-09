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

decoracion="
──────▄▀▄─────▄▀▄
─────▄█░░▀▀▀▀▀░░█▄
─▄▄──█░░░░░░░░░░░█──▄▄
█▄▄█─█░░▀░░┬░░▀░░█─█▄▄█
"

# Función para mostrar el menú
menu() {
    while true; do  # Bucle infinito para que el menú se repita
        clear  # Limpiar la pantalla antes de mostrar el menú
        echo -e "$decoracion"
        echo -e "${Green}#############################"
        echo -e "${Green}#  ${Blue}Menú de Instalación${Green}  #"
        echo -e "${Green}#############################${NC}"
        echo -e "${Yellow}Selecciona una opción:${NC}"
        echo -e "${Cyan}1. ${White}Instalar Docker${NC}"
        echo -e "${Cyan}2. ${White}Instalar Theta Edge Node${NC}"
        echo -e "${Cyan}3. ${White}Subir la key wallet${NC}"
        echo -e "${Cyan}0. ${White}Salir${NC}"
        echo -e "${Yellow}*****************************${NC}"
        
        read -p "Opción: " opcion
        case $opcion in
            1)
                echo -e "${Green}Instalando Docker...${NC}"
                # Llama a la función para instalar Docker aquí, por ejemplo:
                # ./docker.sh
                ;;
            2)
                echo -e "${Green}Instalando Theta Edge Node...${NC}"
                # ./theta.sh
                ;;
            3)
                echo -e "${Green}Subiendo la key wallet...${NC}"
                # ./file.sh
                ;;
            0)
                echo -e "${Yellow}Saliendo...${NC}"
                break  # Sale del bucle y termina el script
                ;;
            *)
                echo -e "${Red}Opción inválida${NC}"
                ;;
        esac
        # Esperar antes de mostrar nuevamente el menú
        read -p "Presiona Enter para continuar..." dummy
    done
}

# Mostrar el menú
menu
