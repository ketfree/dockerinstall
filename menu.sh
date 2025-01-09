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
    case "$opcion" in
        1)
            echo -e "${Green}Instalando Docker...${NC}"
            # Llama a la función para instalar Docker aquí
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
            echo -e "${Red}Saliendo...${NC}"
            exit 0
            ;;
        *)
            echo -e "${Red}Opción inválida, por favor selecciona una opción válida.${NC}"
            ;;
    esac
}

# Bucle principal para mantener el menú activo hasta que el usuario elija salir
while true; do
    menu
done
