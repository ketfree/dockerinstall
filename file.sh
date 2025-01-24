#!/bin/bash
# Colores
NC='\033[0m'
Red='\033[0;31m'
Green='\033[0;32m'
Yellow='\033[1;33m'
Cyan='\033[0;36m'

# Directorio de origen (carpeta de las claves)
ORIGIN_DIR="$HOME/.edgelauncher/edgeencoder/key/encrypted"

# Ruta fija para el directorio público
PUBLIC_PATH="/var/www/html/uploads"

# Función para verificar la existencia de la ruta pública
check_public_path() {
    if [ ! -d "$PUBLIC_PATH" ]; then
        echo -e "${Yellow}La ruta pública no existe. Creándola...${NC}"
        sudo mkdir -p "$PUBLIC_PATH"
        sudo chown -R $USER:$USER "$PUBLIC_PATH"
        sudo chmod -R 755 "$PUBLIC_PATH"
        echo -e "${Green}Ruta pública creada correctamente.${NC}"
    fi
}

# Función para listar archivos disponibles en el directorio de origen
list_files() {
    FILES=("$ORIGIN_DIR"/*)
    if [ ${#FILES[@]} -eq 0 ]; then
        echo -e "${Yellow}No hay archivos en el directorio de origen.${NC}"
        return 1
    fi
    echo -e "${Green}Archivos disponibles en ${ORIGIN_DIR}:${NC}"
    for i in "${!FILES[@]}"; do
        echo -e "$((i + 1)). ${FILES[$i]##*/}"
    done
}

# Función para subir un archivo
upload_file() {
    # Limpiar archivos existentes en la ruta pública antes de copiar uno nuevo
    echo -e "${Yellow}Limpiando archivos existentes en ${PUBLIC_PATH}...${NC}"
    sudo rm -f "$PUBLIC_PATH"/*
    if [ $? -eq 0 ]; then
        echo -e "${Green}Archivos existentes eliminados.${NC}"
    else
        echo -e "${Red}Error al eliminar archivos existentes.${NC}"
        return 1
    fi

    # Selección de archivo
    while true; do
        read -p "$(echo -e "${Cyan}Selecciona el número del archivo a copiar:${NC}") " CHOICE
        if [[ "$CHOICE" =~ ^[0-9]+$ ]] && [ "$CHOICE" -ge 1 ] && [ "$CHOICE" -le ${#FILES[@]} ]; then
            SELECTED_FILE="${FILES[$((CHOICE - 1))]}"
            break
        else
            echo -e "${Red}Por favor, selecciona un número válido.${NC}"
        fi
    done

    # Intentar copiar el archivo seleccionado al directorio público
    echo -e "${Yellow}Copiando archivo ${SELECTED_FILE##*/} a ${PUBLIC_PATH}...${NC}"
    sudo cp "$SELECTED_FILE" "$PUBLIC_PATH"
    if [ $? -eq 0 ]; then
        echo -e "${Green}Archivo copiado exitosamente.${NC}"
        # Obtener la IP pública
        echo -e "${Yellow}Detectando la IP pública del servidor...${NC}"
        SERVER_IP=$(curl -s ifconfig.me)
        if [ -z "$SERVER_IP" ]; then
            echo -e "${Red}No se pudo detectar la IP pública. Verifica tu conexión a Internet.${NC}"
            return 1
        fi
        # Generar el enlace de descarga
        FILE_NAME=$(basename "$SELECTED_FILE")
        DOWNLOAD_LINK="http://$SERVER_IP/uploads/$FILE_NAME"
        echo -e "${Cyan}Enlace de descarga: ${DOWNLOAD_LINK}${NC}"
    else
        echo -e "${Red}Error al copiar el archivo. Asegúrate de tener permisos suficientes.${NC}"
        return 1
    fi
}

# Función para eliminar un archivo subido
delete_file() {
    echo -e "${Green}Archivos subidos a ${PUBLIC_PATH}:${NC}"
    FILES=("$PUBLIC_PATH"/*)
    if [ ${#FILES[@]} -eq 0 ]; then
        echo -e "${Yellow}No hay archivos subidos para eliminar.${NC}"
        return 1
    fi

    # Mostrar archivos en lista numerada
    for i in "${!FILES[@]}"; do
        echo -e "$((i + 1)). ${FILES[$i]##*/}"
    done

    # Seleccionar archivo a eliminar
    while true; do
        read -p "$(echo -e "${Cyan}Selecciona el número del archivo a eliminar:${NC}") " CHOICE
        if [[ "$CHOICE" =~ ^[0-9]+$ ]] && [ "$CHOICE" -ge 1 ] && [ "$CHOICE" -le ${#FILES[@]} ]; then
            SELECTED_FILE="${FILES[$((CHOICE - 1))]}"
            break
        else
            echo -e "${Red}Por favor, selecciona un número válido.${NC}"
        fi
    done

    # Eliminar el archivo seleccionado
    echo -e "${Yellow}Eliminando archivo ${SELECTED_FILE##*/}...${NC}"
    sudo rm -f "$SELECTED_FILE"
    if [ $? -eq 0 ]; then
        echo -e "${Green}Archivo ${SELECTED_FILE##*/} eliminado exitosamente.${NC}"
    else
        echo -e "${Red}Error al eliminar el archivo.${NC}"
    fi
}

# Función para listar los archivos subidos
list_uploaded_files() {
    echo -e "${Green}Archivos subidos a ${PUBLIC_PATH}:${NC}"
    if [ "$(ls -A $PUBLIC_PATH)" ]; then
        ls -1 $PUBLIC_PATH
    else
        echo -e "${Yellow}No hay archivos subidos en la ruta pública.${NC}"
    fi
}

# Menú principal
while true; do
    echo -e "\n${Green}Menú de gestión de archivos:${NC}"
    echo -e "1. Subir un archivo"
    echo -e "2. Ver archivos subidos"
    echo -e "3. Eliminar un archivo subido"
    echo -e "4. Salir"
    read -p "Selecciona una opción (1, 2, 3, 4): " OPTION

    case $OPTION in
        1)
            check_public_path
            list_files
            upload_file
            ;;
        2)
            check_public_path
            list_uploaded_files
            ;;
        3)
            check_public_path
            delete_file
            ;;
        4)
            echo -e "${Yellow}Saliendo...${NC}"
            exit 0
            ;;
        *)
            echo -e "${Red}Opción no válida. Por favor, selecciona una opción válida.${NC}"
            ;;
    esac
done
