#!/bin/bash
# setup.sh - Context Engineering Setup Script
# Versión: 1.0
# Descripción: Crea symlinks de los archivos del primer nivel de las carpetas
#              seleccionadas del repositorio Context Engineering a un proyecto destino.
#              (No incluye subcarpetas como docs/)

set -e  # Salir en error

# ═══════════════════════════════════════════════════════════════
# CONFIGURACIÓN
# ═══════════════════════════════════════════════════════════════

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERSION="1.0.0"

# Herramientas disponibles (extensible)
TOOLS=("OpenCode" "Claude")

# Colores (compatibles con la mayoría de terminales)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# ═══════════════════════════════════════════════════════════════
# FUNCIONES DE UI
# ═══════════════════════════════════════════════════════════════

print_header() {
    clear
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║           CONTEXT ENGINEERING - SETUP v${VERSION}              ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_step() {
    local step_num=$1
    local step_title=$2
    echo ""
    echo -e "${BLUE}┌─ PASO ${step_num}: ${step_title} ─────────────────────────────────┐${NC}"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# ═══════════════════════════════════════════════════════════════
# PASO 1: SELECCIÓN DE HERRAMIENTA
# ═══════════════════════════════════════════════════════════════

select_tool() {
    print_step 1 "Selecciona tu herramienta"
    echo ""
    
    local i=1
    for tool in "${TOOLS[@]}"; do
        echo "   [${i}] ${tool}"
        ((i++))
    done
    
    echo ""
    while true; do
        read -p "   Selección: " choice
        if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#TOOLS[@]}" ]; then
            SELECTED_TOOL="${TOOLS[$((choice-1))]}"
            print_success "Herramienta seleccionada: ${SELECTED_TOOL}"
            break
        else
            print_error "Opción inválida. Intenta de nuevo."
        fi
    done
}

# ═══════════════════════════════════════════════════════════════
# PASO 2: RUTA DEL PROYECTO
# ═══════════════════════════════════════════════════════════════

get_project_path() {
    print_step 2 "Ruta del proyecto"
    echo ""
    
    while true; do
        read -p "   Ingresa la ruta absoluta: " PROJECT_PATH
        
        # Expandir ~ si se usa
        PROJECT_PATH="${PROJECT_PATH/#\~/$HOME}"
        
        if [ -d "$PROJECT_PATH" ]; then
            if [ -w "$PROJECT_PATH" ]; then
                print_success "Directorio válido: ${PROJECT_PATH}"
                break
            else
                print_error "Sin permisos de escritura en: ${PROJECT_PATH}"
            fi
        else
            print_error "Directorio no existe: ${PROJECT_PATH}"
            read -p "   ¿Crear directorio? [s/N]: " create_dir
            if [[ "$create_dir" =~ ^[sS]$ ]]; then
                mkdir -p "$PROJECT_PATH"
                print_success "Directorio creado: ${PROJECT_PATH}"
                break
            fi
        fi
    done
}

# ═══════════════════════════════════════════════════════════════
# PASO 3: DETECCIÓN Y SELECCIÓN DE CARPETAS
# ═══════════════════════════════════════════════════════════════

get_available_folders() {
    AVAILABLE_FOLDERS=()
    for dir in "$SCRIPT_DIR"/*/; do
        if [ -d "$dir" ]; then
            folder_name=$(basename "$dir")
            # Excluir carpetas ocultas, .git, node_modules, etc.
            if [[ ! "$folder_name" =~ ^\. ]] && \
               [[ "$folder_name" != "node_modules" ]] && \
               [[ "$folder_name" != "venv" ]]; then
                AVAILABLE_FOLDERS+=("$folder_name")
            fi
        fi
    done
}

select_folders() {
    print_step 3 "Selecciona carpetas a importar"
    echo ""
    
    get_available_folders
    
    if [ ${#AVAILABLE_FOLDERS[@]} -eq 0 ]; then
        print_error "No hay carpetas disponibles para importar"
        exit 1
    fi
    
    # Array para tracking de selecciones (0=no, 1=sí)
    declare -a SELECTIONS
    for i in "${!AVAILABLE_FOLDERS[@]}"; do
        SELECTIONS[$i]=0
    done
    
    while true; do
        echo "   Carpetas disponibles (usa números para toggle):"
        echo ""
        
        for i in "${!AVAILABLE_FOLDERS[@]}"; do
            if [ "${SELECTIONS[$i]}" -eq 1 ]; then
                echo -e "   ${GREEN}[x]${NC} $((i+1)). ${AVAILABLE_FOLDERS[$i]}"
            else
                echo -e "   [ ] $((i+1)). ${AVAILABLE_FOLDERS[$i]}"
            fi
        done
        
        echo ""
        echo "   [Enter] Confirmar | [a] Todas | [n] Ninguna | [q] Salir"
        echo ""
        read -p "   Opción: " opt
        
        case "$opt" in
            "")
                # Confirmar selección
                SELECTED_FOLDERS=()
                for i in "${!AVAILABLE_FOLDERS[@]}"; do
                    if [ "${SELECTIONS[$i]}" -eq 1 ]; then
                        SELECTED_FOLDERS+=("${AVAILABLE_FOLDERS[$i]}")
                    fi
                done
                
                if [ ${#SELECTED_FOLDERS[@]} -eq 0 ]; then
                    print_error "Debes seleccionar al menos una carpeta"
                else
                    break
                fi
                ;;
            [aA])
                for i in "${!SELECTIONS[@]}"; do
                    SELECTIONS[$i]=1
                done
                ;;
            [nN])
                for i in "${!SELECTIONS[@]}"; do
                    SELECTIONS[$i]=0
                done
                ;;
            [qQ])
                echo "   Cancelado por el usuario."
                exit 0
                ;;
            *)
                if [[ "$opt" =~ ^[0-9]+$ ]] && [ "$opt" -ge 1 ] && [ "$opt" -le "${#AVAILABLE_FOLDERS[@]}" ]; then
                    idx=$((opt-1))
                    if [ "${SELECTIONS[$idx]}" -eq 1 ]; then
                        SELECTIONS[$idx]=0
                    else
                        SELECTIONS[$idx]=1
                    fi
                fi
                ;;
        esac
        
        # Limpiar pantalla para actualizar
        clear
        print_header
        print_step 3 "Selecciona carpetas a importar"
        echo ""
    done
    
    print_success "Carpetas seleccionadas: ${SELECTED_FOLDERS[*]}"
}

# ═══════════════════════════════════════════════════════════════
# PASO 4: CONFIRMACIÓN
# ═══════════════════════════════════════════════════════════════

confirm_action() {
    print_step 4 "Confirmación"
    echo ""
    
    # Contar archivos a enlazar (solo primer nivel)
    FILE_COUNT=0
    for folder in "${SELECTED_FOLDERS[@]}"; do
        count=$(find "$SCRIPT_DIR/$folder" -maxdepth 1 -type f | wc -l | tr -d ' ')
        FILE_COUNT=$((FILE_COUNT + count))
    done
    
    echo "   Resumen de operación:"
    echo "   • Herramienta: ${SELECTED_TOOL}"
    echo "   • Proyecto: ${PROJECT_PATH}"
    echo "   • Carpetas: ${SELECTED_FOLDERS[*]}"
    echo "   • Archivos a enlazar: ${FILE_COUNT}"
    echo ""
    
    read -p "   ¿Continuar? [s/N]: " confirm
    if [[ ! "$confirm" =~ ^[sS]$ ]]; then
        echo "   Cancelado por el usuario."
        exit 0
    fi
}

# ═══════════════════════════════════════════════════════════════
# PASO 5: CREACIÓN DE SYMLINKS (ARCHIVO POR ARCHIVO)
# ═══════════════════════════════════════════════════════════════

create_symlinks() {
    print_step 5 "Creando symlinks"
    echo ""
    
    SUCCESS_COUNT=0
    ERROR_COUNT=0
    
    for folder in "${SELECTED_FOLDERS[@]}"; do
        echo "   Procesando ${folder}/"
        
        SOURCE_FOLDER="$SCRIPT_DIR/$folder"
        DEST_FOLDER="$PROJECT_PATH/$folder"
        
        # Crear directorio destino si no existe
        if [ ! -d "$DEST_FOLDER" ]; then
            mkdir -p "$DEST_FOLDER"
        fi
        
        # Iterar SOLO por los archivos del PRIMER nivel (sin subcarpetas)
        for file in "$SOURCE_FOLDER"/*; do
            # Solo procesar archivos (no directorios)
            if [ -f "$file" ]; then
                # Obtener nombre de archivo
                filename=$(basename "$file")
                dest_file="$DEST_FOLDER/$filename"
                
                # Verificar si symlink ya existe o es archivo regular
                if [ -L "$dest_file" ] || [ -f "$dest_file" ]; then
                    # Eliminar link o archivo existente (sobrescribir siempre)
                    rm -f "$dest_file"
                fi
                
                # Crear symlink
                if ln -s "$file" "$dest_file" 2>/dev/null; then
                    print_success "${folder}/${filename}"
                    ((SUCCESS_COUNT++))
                else
                    print_error "${folder}/${filename} (error al crear symlink)"
                    ((ERROR_COUNT++))
                fi
            fi
        done
    done
    
    echo ""
    echo "   ══════════════════════════════════════════════════════════"
    if [ $ERROR_COUNT -eq 0 ]; then
        echo -e "   ${GREEN}✓ ${SUCCESS_COUNT} symlinks creados exitosamente${NC}"
    else
        echo -e "   ${YELLOW}⚠ ${SUCCESS_COUNT} creados, ${ERROR_COUNT} errores${NC}"
    fi
}

# ═══════════════════════════════════════════════════════════════
# MAIN
# ═══════════════════════════════════════════════════════════════

main() {
    print_header
    select_tool
    get_project_path
    select_folders
    confirm_action
    create_symlinks
    
    echo ""
    echo -e "${GREEN}¡Setup completado!${NC}"
    echo ""
    echo "Próximos pasos:"
    echo "  1. cd ${PROJECT_PATH}"
    echo "  2. Verifica los symlinks: ls -la ${SELECTED_FOLDERS[0]}/"
    echo "  3. Consulta AGENTS.md para convenciones"
    echo ""
}

main "$@"