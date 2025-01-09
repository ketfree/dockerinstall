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

# Ruta del directorio
cd ~/.edgelauncher/edgeencoder/key/encrypted || { echo "El directorio no existe."; exit 1; }

# Listar los archivos en el directorio
FILES=(*)
if [ ${#FILES[@]} -eq 0 ]; then
    echo "No hay archivos en el directorio."
    exit 1
fi

echo "Archivos disponibles:"
for i in "${!FILES[@]}"; do
    echo "$((i + 1)). ${FILES[$i]}"
done

# Pedir al usuario que seleccione un archivo
while true; do
    read -p "\033[0;34mSelecciona el número del archivo a subir:\033[0m " CHOICE
    if [[ "$CHOICE" =~ ^[0-9]+$ ]] && [ "$CHOICE" -ge 1 ] && [ "$CHOICE" -le ${#FILES[@]} ]; then
        SELECTED_FILE="${FILES[$((CHOICE - 1))]}"
        break
    else
        echo "Por favor, selecciona un número válido."
    fi
done

# Subir el archivo a file.io y ocultar salida detallada
curl -s -F "file=@$SELECTED_FILE" https://file.io > /dev/null

# Extraer solo el enlace del archivo subido
RESPONSE=$(curl -s -F "file=@$SELECTED_FILE" https://file.io)
LINK=$(echo "$RESPONSE" | grep -oP '(?<="link":")[^"]*')

if [ -n "$LINK" ]; then
    echo "Archivo subido exitosamente."
    echo "\033[0;36mEnlace de descarga: $LINK\033[0m"
else
    echo "Error al subir el archivo. Respuesta del servidor: $RESPONSE"
fi
