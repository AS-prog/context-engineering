#!/bin/bash
# setup.sh - Context Engineering Setup Script (Modern TUI Edition)

set -e

# ═══════════════════════════════════════════════════════════════
# CONFIGURACIÓN Y COLORES
# ═══════════════════════════════════════════════════════════════

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERSION="1.0.0"
TOOLS=("OpenCode" "Claude")

# Colores ANSI (Sutiles y Modernos)
G='\033[0;32m'      # Verde (Éxito)
B='\033[0;34m'      # Azul (Pasos)
C='\033[0;36m'      # Cian (Header)
Y='\033[1;33m'      # Amarillo (Aviso)
R='\033[0;31m'      # Rojo (Error)
D='\033[0;90m'      # Gris Oscuro (Rutas y Dimmed)
NC='\033[0m'        # No Color
BOLD='\033[1m'

# Símbolos
CHECK="✔"
CROSS="✖"
INFO="ℹ"
STEP_LINE="│"
STEP_BOTTOM="└"

# ═══════════════════════════════════════════════════════════════
# FUNCIONES DE UI (ESTILO CLACK/CLAUDE)
# ═══════════════════════════════════════════════════════════════

print_header() {
    clear
    echo -e "${C}${BOLD}┌────────────────────────────────────────────────────────────┐"
    echo -e "│            CONTEXT ENGINEERING - SETUP v${VERSION}            │"
    echo -e "└────────────────────────────────────────────────────────────┘${NC}"
    echo -e "${D}  Ubicación: $SCRIPT_DIR${NC}\n"
}

print_step() {
    echo -e "${B}${BOLD}◆${NC} ${BOLD}$1${NC}"
}

print_success() {
    echo -e "  ${G}${CHECK}${NC} $1"
}

print_error() {
    echo -e "  ${R}${CROSS}${NC} $1"
}

# ═══════════════════════════════════════════════════════════════
# LÓGICA DE PASOS
# ═══════════════════════════════════════════════════════════════

select_tool() {
    print_step "Paso 1: Selecciona tu herramienta"
    echo -e "${B}${STEP_LINE}${NC}"
    
    local i=1
    for tool in "${TOOLS[@]}"; do
        echo -e "${B}${STEP_LINE}${NC}  ${D}[${i}]${NC} ${tool}"
        ((i++))
    done
    
    echo -e "${B}${STEP_LINE}${NC}"
    while true; do
        echo -ne "${B}${STEP_LINE}${NC}  Selección: "
        read choice
        if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#TOOLS[@]}" ]; then
            SELECTED_TOOL="${TOOLS[$((choice-1))]}"
            print_success "Herramienta: ${BOLD}${SELECTED_TOOL}${NC}"
            break
        else
            echo -e "${B}${STEP_LINE}${NC}  ${R}! Selección inválida${NC}"
        fi
    done
    echo -e "${B}${STEP_LINE}${NC}"
}

get_project_path() {
    print_step "Paso 2: Ruta del proyecto"
    echo -e "${B}${STEP_LINE}${NC}"
    
    while true; do
        echo -ne "${B}${STEP_LINE}${NC}  Ruta absoluta: "
        read PROJECT_PATH
        PROJECT_PATH="${PROJECT_PATH/#\~/$HOME}"
        
        if [ -d "$PROJECT_PATH" ]; then
            print_success "Directorio: ${D}${PROJECT_PATH}${NC}"
            break
        else
            echo -ne "${B}${STEP_LINE}${NC}  ${Y}! No existe. ¿Crearlo? [s/N]: "
            read create_dir
            if [[ "$create_dir" =~ ^[sS]$ ]]; then
                mkdir -p "$PROJECT_PATH"
                print_success "Creado: ${D}${PROJECT_PATH}${NC}"
                break
            fi
        fi
    done
    echo -e "${B}${STEP_LINE}${NC}"
}

select_folders() {
    print_step "Paso 3: Carpetas a importar"
    echo -e "${B}${STEP_LINE}${NC}"
    
    # Detección simplificada para el ejemplo
    AVAILABLE_FOLDERS=($(ls -d */ 2>/dev/null | sed 's/\///' | grep -vE "node_modules|venv"))
    
    declare -a SELECTIONS
    for i in "${!AVAILABLE_FOLDERS[@]}"; do SELECTIONS[$i]=0; done
    
    while true; do
        for i in "${!AVAILABLE_FOLDERS[@]}"; do
            if [ "${SELECTIONS[$i]}" -eq 1 ]; then
                echo -e "${B}${STEP_LINE}${NC}  ${G}[●]${NC} $((i+1)). ${AVAILABLE_FOLDERS[$i]}"
            else
                echo -e "${B}${STEP_LINE}${NC}  ${D}[○]${NC} $((i+1)). ${AVAILABLE_FOLDERS[$i]}"
            fi
        done
        
        echo -e "${B}${STEP_LINE}${NC}"
        echo -ne "${B}${STEP_LINE}${NC}  ${D}[Número: toggle | Enter: Confirmar]${NC}: "
        read opt
        
        if [[ -z "$opt" ]]; then
            SELECTED_FOLDERS=()
            for i in "${!AVAILABLE_FOLDERS[@]}"; do
                [ "${SELECTIONS[$i]}" -eq 1 ] && SELECTED_FOLDERS+=("${AVAILABLE_FOLDERS[$i]}")
            done
            if [ ${#SELECTED_FOLDERS[@]} -gt 0 ]; then break; fi
        elif [[ "$opt" =~ ^[0-9]+$ ]] && [ "$opt" -le "${#AVAILABLE_FOLDERS[@]}" ]; then
            idx=$((opt-1))
            SELECTIONS[$idx]=$((1 - SELECTIONS[$idx]))
        fi
        
        # Refrescar UI sutilmente
        tput cuu $(( ${#AVAILABLE_FOLDERS[@]} + 2 ))
        tput ed
    done
    
    print_success "Seleccionadas: ${G}${SELECTED_FOLDERS[*]}${NC}"
    echo -e "${B}${STEP_LINE}${NC}"
}

create_symlinks() {
    print_step "Paso 4: Creando Enlaces"
    echo -e "${B}${STEP_LINE}${NC}"
    
    for folder in "${SELECTED_FOLDERS[@]}"; do
        echo -e "${B}${STEP_LINE}${NC}  ${BOLD}${folder}/${NC}"
        SOURCE_FOLDER="$SCRIPT_DIR/$folder"
        DEST_FOLDER="$PROJECT_PATH/$folder"
        
        mkdir -p "$DEST_FOLDER"
        
        find "$SOURCE_FOLDER" -type f | grep -v "/docs/" | while read -r file; do
            rel="${file#$SOURCE_FOLDER/}"
            dest="$DEST_FOLDER/$rel"
            mkdir -p "$(dirname "$dest")"
            ln -sf "$file" "$dest"
            echo -e "${B}${STEP_LINE}${NC}    ${D}├─${NC} $rel"
        done
    done
    
    echo -e "${B}${STEP_BOTTOM}───────────────────────────────────────────────────${NC}"
    echo -e "\n${G}${BOLD}¡Setup completado con éxito!${NC} 🚀"
}

# ═══════════════════════════════════════════════════════════════
# EJECUCIÓN
# ═══════════════════════════════════════════════════════════════

main() {
    print_header
    select_tool
    get_project_path
    select_folders
    create_symlinks
    
    echo -e "\n${D}Próximos pasos:${NC}"
    echo -e "  1. cd $PROJECT_PATH"
    echo -e "  2. Verifica con: ls -la"
}

main "$@"