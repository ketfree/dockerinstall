#!/bin/bash

# Colores
NC='\033[0m'        # Sin color
Red='\033[0;31m'
Green='\033[0;32m'
Yellow='\033[1;33m'
Blue='\033[0;34m'
Purple='\033[0;35m'
Cyan='\033[0;36m'
White='\033[1;37m'

# Ruta del directorio
cd ~/.edgelauncher/edgeencoder/key/encrypted || { echo -e "${Red}El directorio no existe.${NC}"; exit 1; }

# Listar los archivos en el directorio
FILES=(*)
if [ ${#FILES[@]} -eq 0 ]; then
    echo -e "${Yellow}No hay archivos en el directorio.${NC}"
    exit 1
fi

echo -e "${Green}Archivos disponibles:${NC}"
for i in "${!FILES[@]}"; do
    echo -e "$((i + 1)). ${FILES[$i]}"
done

# Pedir al usuario que seleccione un archivo
while true; do
    read -p "$(echo -e ${Blue}Selecciona el número del archivo a subir:${NC} )" CHOICE
    if [[ "$CHOICE" =~ ^[0-9]+$ ]] && [ "$CHOICE" -ge 1 ] && [ "$CHOICE" -le ${#FILES[@]} ]; then
        SELECTED_FILE="${FILES[$((CHOICE - 1))]}"
        break
    else
        echo -e "${Red}Por favor, selecciona un número válido.${NC}"
    fi
done

# Subir el archivo a file.io y obtener la respuesta
RESPONSE=$(curl -s -F "file=@$SELECTED_FILE" https://file.io)

# Extraer solo el enlace del archivo subido
LINK=$(echo "$RESPONSE" | grep -oP '(?<="link":")[^"]*')

if [ -n "$LINK" ]; then
    echo -e "${Green}Archivo subido exitosamente.${NC}"
    echo -e "${Cyan}Enlace de descarga: $LINK${NC}"
else
    echo -e "${Red}Error al subir el archivo o no se obtuvo el enlace.${NC}"
    echo -e "${Yellow}Respuesta del servidor: $RESPONSE${NC}"
fi

# Opción para regresar al menú
echo -e "\n${Yellow}¿Quieres regresar al menú?${NC} (Presiona Enter para regresar o cualquier otra tecla para salir)"
read -p "Opción: " choice
if [ -z "$choice" ]; then
    # Si el usuario presiona Enter, regresa al menú
~/.mis_scripts/menu.sh
else
    echo -e "${Red}Saliendo...${NC}"
    exit 0  # Salir del script si el usuario no presiona Enter
fi
