#!/bin/bash
# setup.sh - CONTEXT BRAIN: Deployment Protocol
# Versión: 1.0.0

set -e

# ═══════════════════════════════════════════════════════════════
# PALETA DE COLORES (XTERM-256)
# ═══════════════════════════════════════════════════════════════

P_MAGENTA='\033[38;5;201m'
P_CYAN='\033[38;5;51m'
P_LIME='\033[38;5;46m'
P_GOLD='\033[38;5;220m'
P_BLUE='\033[38;5;33m'
P_GRAY='\033[38;5;244m'
P_DARK='\033[38;5;236m'
BG_DARK='\033[48;5;234m'
BOLD='\033[1m'
NC='\033[0m'

# ICONOS Y SÍMBOLOS
ICO_TOOL="🛠️"
ICO_PATH="📂"
ICO_FOLDERS="🌿"
ICO_SYNC="⚡"
ICO_SUCCESS="💎"
SIDE_L="▒▓█"
SIDE_R="█▓▒"

# CONFIGURACIÓN
VERSION="1.0.0"
TOOLS=("OpenCode" "Claude Code" "Openclaw")
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ═══════════════════════════════════════════════════════════════
# COMPONENTES VISUALES
# ═══════════════════════════════════════════════════════════════

draw_hero() {
    clear
    echo -e "${P_CYAN}"
    echo -e "  ██████╗ ██████╗ ███╗   ██╗████████╗███████╗██╗  ██╗████████╗"
    echo -e " ██╔════╝██╔═══██╗████╗  ██║╚══██╔══╝██╔════╝╚██╗██╔╝╚══██╔══╝"
    echo -e " ██║     ██║   ██║██╔██╗ ██║   ██║   █████╗   ╚███╔╝    ██║   "
    echo -e " ██║     ██║   ██║██║╚██╗██║   ██║   ██╔══╝   ██╔██╗    ██║   "
    echo -e " ╚██████╗╚██████╔╝██║ ╚████║   ██║   ███████╗██╔╝ ██╗   ██║   "
    echo -e "  ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚═╝  ╚═╝   ╚═╝   "
    echo -e "${P_MAGENTA}"
    echo -e " ███████╗███╗   ██╗ ██████╗ ██╗███╗   ██╗███████╗███████╗██████╗ ██╗███╗   ██╗ ██████╗ "
    echo -e " ██╔════╝████╗  ██║██╔════╝ ██║████╗  ██║██╔════╝██╔════╝██╔══██╗██║████╗  ██║██╔════╝ "
    echo -e " █████╗  ██╔██╗ ██║██║  ███╗██║██╔██╗ ██║█████╗  █████╗  ██████╔╝██║██╔██╗ ██║██║  ███╗"
    echo -e " ██╔══╝  ██║╚██╗██║██║   ██║██║██║╚██╗██║██╔══╝  ██╔══╝  ██╔══██╗██║██║╚██╗██║██║   ██║"
    echo -e " ███████╗██║ ╚████║╚██████╔╝██║██║ ╚████║███████╗███████╗██║  ██║██║██║ ╚████║╚██████╔╝"
    echo -e " ╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝ "
    echo -e "${P_LIME}"
    echo -e " ████████╗███████╗██████╗ ███╗   ███╗██╗███╗   ██╗ █████╗ ██╗     "
    echo -e " ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║████╗  ██║██╔══██╗██║     v${VERSION}"
    echo -e "    ██║   █████╗  ██████╔╝██╔████╔██║██║██╔██╗ ██║███████║██║     "
    echo -e "    ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║██║╚██╗██║██╔══██║██║     "
    echo -e "    ██║   ███████╗██║  ██║██║ ╚═╝ ██║██║██║ ╚████║██║  ██║███████╗"
    echo -e "    ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝"
    echo -e "${NC}"

    echo -e "${BG_DARK}${BOLD}${P_CYAN}  SYSTEM CORE  ${NC}${BG_DARK} ▒░░ Inicializando Entorno by @andressotelo ░▒ ${NC}"
    echo ""
    
    # Efecto de carga falso para estética
    echo -ne "${P_GRAY}  Iniciando protocolos...${NC}" && sleep 0.3
    echo -e "\r${P_LIME}  Protocolos [READY]          ${NC}"
    sleep 0.2
}

step_header() {
    echo -e "${P_BLUE}┃${NC}"
    echo -e "${P_BLUE}┃${NC} ${BOLD}${P_BLUE}┏${NC} $1"
    echo -e "${P_BLUE}┃${NC} ${P_BLUE}┗━${NC} ${P_GRAY}░▒▓█${NC}"
}

# ═══════════════════════════════════════════════════════════════
# LÓGICA DEL SCRIPT
# ═══════════════════════════════════════════════════════════════

select_tool() {
    step_header "${ICO_TOOL} SELECCIÓN DE ENTORNO"
    local i=1
    for tool in "${TOOLS[@]}"; do
        echo -e "${P_BLUE}┃${NC}   ${P_DARK}${i}.${NC} ${BOLD}${tool}${NC}"
        ((i++))
    done
    echo -e "${P_BLUE}┃${NC}"
    echo -ne "${P_BLUE}┃${NC}   ${P_MAGENTA}❯${NC} "
    
    # Leer entrada del usuario con soporte para modo no interactivo
    local choice
    if [ -t 0 ]; then
        # Terminal interactivo: leer directamente desde stdin
        read choice
    else
        # Modo no interactivo (stdin es pipe o redirección)
        # Intentar leer desde stdin con timeout, si falla usar default
        if ! read -t 1 choice 2>/dev/null; then
            choice="1"
        fi
        echo "$choice"  # Mostrar la elección en modo no interactivo
    fi
    
    SELECTED_TOOL="${TOOLS[$((choice-1))]}"
    echo -e "${P_BLUE}┃${NC}   ${P_LIME}◆ Herramienta: ${SELECTED_TOOL}${NC}"
}

get_project_path() {
    step_header "${ICO_PATH} RUTA DE DESTINO"
    
    # Path fijo usando $HOME (compatible macOS/Linux/WSL)
    DEFAULT_PATH="${HOME}/.config/opencode"
    
    # Permitir sobrescribir con variable de entorno
    PROJECT_PATH="${OPENCODE_CONFIG_PATH:-$DEFAULT_PATH}"
    
    # Expandir ~ si el usuario lo usó en la variable de entorno
    PROJECT_PATH="${PROJECT_PATH/#\~/$HOME}"
    
    echo -e "${P_BLUE}┃${NC}   ${P_GRAY}Destino configurado:${NC}"
    echo -e "${P_BLUE}┃${NC}   ${P_LIME}${PROJECT_PATH}${NC}"
    
    if [ ! -d "$PROJECT_PATH" ]; then
        echo -e "${P_BLUE}┃${NC}   ${P_GOLD}⚠ Creando directorio...${NC}"
        mkdir -p "$PROJECT_PATH"
    fi
    
    echo -e "${P_BLUE}┃${NC}   ${P_LIME}◆ Ruta fijada: ${PROJECT_PATH}${NC}"
}

get_openclaw_path() {
    step_header "${ICO_PATH} RUTA DE OPENCLAW"
    
    # Path fijo para Openclaw skills
    OPENCLAW_PATH="${HOME}/.openclaw/skills"
    
    echo -e "${P_BLUE}┃${NC}   ${P_GRAY}Destino Openclaw:${NC}"
    echo -e "${P_BLUE}┃${NC}   ${P_LIME}${OPENCLAW_PATH}${NC}"
    
    if [ ! -d "$OPENCLAW_PATH" ]; then
        echo -e "${P_BLUE}┃${NC}   ${P_GOLD}⚠ Creando directorio...${NC}"
        mkdir -p "$OPENCLAW_PATH"
    fi
    
    echo -e "${P_BLUE}┃${NC}   ${P_LIME}◆ Ruta fijada: ${OPENCLAW_PATH}${NC}"
}

deploy_openclaw_skills() {
    step_header "${ICO_SYNC} INYECCIÓN DE SKILLS EN OPENCLAW"
    
    local skill_count=0
    
    # Solo procesar la carpeta skills/
    SOURCE_SKILLS="$SCRIPT_DIR/skills"
    
    if [ -d "$SOURCE_SKILLS" ]; then
        for skill_dir in "$SOURCE_SKILLS"/*/; do
            [ -d "$skill_dir" ] || continue
            
            skill_name=$(basename "$skill_dir")
            dest_skill="$OPENCLAW_PATH/$skill_name"
            
            # Eliminar symlink existente si hay
            if [ -L "$dest_skill" ]; then
                rm -f "$dest_skill"
            fi
            
            # Crear enlace simbólico de la carpeta del skill completa
            if ln -sf "$skill_dir" "$dest_skill"; then
                echo -e "${P_BLUE}┃${NC}     ${P_DARK}⚡${NC} ${P_GRAY}Skill inyectado: ${skill_name}${NC}"
                skill_count=$((skill_count + 1))
            fi
        done
    fi
    
    echo -e "${P_BLUE}┃${NC}   ${P_LIME}◆ ${skill_count} skills inyectados en Openclaw${NC}"
    SUCCESS_COUNT=$skill_count
}

select_folders() {
    step_header "${ICO_FOLDERS} MÓDULOS DE CONOCIMIENTO"
    AVAILABLE_FOLDERS=($(ls -d */ 2>/dev/null | sed 's/\///' | grep -vE "node_modules|venv"))
    
    if [ ${#AVAILABLE_FOLDERS[@]} -eq 0 ]; then
        echo -e "${P_BLUE}┃${NC}   ${R}Error: No se encontraron carpetas.${NC}"; exit 1
    fi

    # Selección simplificada para este diseño (se pueden activar/desactivar todas)
    echo -e "${P_BLUE}┃${NC}   ${P_GRAY}Módulos detectados:${NC}"
    for folder in "${AVAILABLE_FOLDERS[@]}"; do
        echo -e "${P_BLUE}┃${NC}   ${P_LIME}[ON]${NC} ${folder}"
    done
    
    echo -e "${P_BLUE}┃${NC}"
    echo -e "${P_BLUE}┃${NC}   ${P_LIME}◆ Procesando todos los módulos activos...${NC}"
    SELECTED_FOLDERS=("${AVAILABLE_FOLDERS[@]}")
}

create_links() {
    step_header "${ICO_SYNC} EJECUCIÓN DE ENLACES (Recursivo)"
    SUCCESS_COUNT=0
    REPLACED_COUNT=0
    
    for folder in "${SELECTED_FOLDERS[@]}"; do
        echo -e "${P_BLUE}┃${NC}   ${BOLD}📦 ${folder}${NC}"
        SOURCE_FOLDER="$SCRIPT_DIR/$folder"
        DEST_FOLDER="$PROJECT_PATH/$folder"
        
        # Asegurar que el directorio base exista en el destino
        mkdir -p "$DEST_FOLDER"
        
        # Búsqueda recursiva excluyendo carpetas 'docs' DENTRO de los módulos
        # (pero no excluir la carpeta top-level 'docs' si es la que se está procesando)
        # Guardar lista de archivos en variable para evitar problemas con stdin
        if [ "$folder" = "docs" ]; then
            # Si estamos procesando la carpeta 'docs', incluir todos sus archivos
            files_list=$(find "$SOURCE_FOLDER" -type f)
        else
            # Para otros módulos, excluir subdirectorios 'docs'
            files_list=$(find "$SOURCE_FOLDER" -type f | grep -v "/$folder/docs/")
        fi
        
        while IFS= read -r file; do
            [ -z "$file" ] && continue
            
            # Calcular ruta relativa para replicar estructura
            relative_path="${file#$SOURCE_FOLDER/}"
            dest_file="$DEST_FOLDER/$relative_path"
            
            # Crear subdirectorios si es necesario
            mkdir -p "$(dirname "$dest_file")"
            
            # Verificar si existe un archivo regular (no symlink) y eliminarlo
            if [ -f "$dest_file" ] && [ ! -L "$dest_file" ]; then
                echo -e "${P_BLUE}┃${NC}     ${P_GOLD}📝 Reemplazando archivo existente: ${relative_path}${NC}"
                rm -f "$dest_file"
                REPLACED_COUNT=$((REPLACED_COUNT + 1))
            fi
            
            # Crear o sobrescribir symlink
            if ln -sf "$file" "$dest_file"; then
                echo -e "${P_BLUE}┃${NC}     ${P_DARK}⚡${NC} ${P_GRAY}${relative_path}${NC}"
                SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
            fi
        done <<< "$files_list"
    done
    
    if [ $REPLACED_COUNT -gt 0 ]; then
        echo -e "${P_BLUE}┃${NC}   ${P_GOLD}⚠ ${REPLACED_COUNT} archivos existentes fueron reemplazados${NC}"
    fi
    
    # Enlace de configuración extra si es OpenCode
    if [ "$SELECTED_TOOL" = "OpenCode" ] && [ -f "$SCRIPT_DIR/opencode.jsonc" ]; then
        # Crear enlace simbólico para opencode.jsonc
        ln -sf "$SCRIPT_DIR/opencode.jsonc" "$PROJECT_PATH/opencode.jsonc"

        # Crear archivo .env si no existe
        if [ ! -f "$PROJECT_PATH/.env" ]; then
            echo "CONTEXT7_API_KEY=YOUR_API_KEY_HERE" > "$PROJECT_PATH/.env"
            echo -e "${P_BLUE}┃${NC}   ${P_LIME}◆ Archivo .env creado para API key.${NC}"
        fi

        echo -e "${P_BLUE}┃${NC}   ${P_LIME}◆ Configuración opencode.jsonc enlazada.${NC}"
        echo -e "${P_BLUE}┃${NC}   ${P_GRAY}   Recuerda actualizar CONTEXT7_API_KEY en .env${NC}"
    fi
}

# ═══════════════════════════════════════════════════════════════
# FINALIZACIÓN
# ═══════════════════════════════════════════════════════════════

print_receipt() {
    echo -e "${P_BLUE}┃${NC}"
    echo -e "${P_BLUE}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${NC}"
    echo ""
    echo -e "   ${P_CYAN}${SIDE_L}${NC}${BG_DARK}${BOLD}${P_LIME}  SUCCESSFUL DEPLOYMENT  ${NC}${P_CYAN}${SIDE_R}${NC}"
    echo ""
    echo -e "   ${BOLD}Resumen de Operación:${NC}"
    echo -e "   ${P_GRAY}├─ Herramienta:  ${NC}${SELECTED_TOOL}"
    
    if [ "$SELECTED_TOOL" = "Openclaw" ]; then
        echo -e "   ${P_GRAY}├─ Skills:       ${NC}${P_LIME}${SUCCESS_COUNT} inyectados${NC}"
        echo -e "   ${P_GRAY}├─ Ubicación:    ${NC}${OPENCLAW_PATH}"
    else
        echo -e "   ${P_GRAY}├─ Enlaces:      ${NC}${P_LIME}${SUCCESS_COUNT} creados${NC}"
        echo -e "   ${P_GRAY}├─ Ubicación:    ${NC}${PROJECT_PATH}"
    fi
    
    echo -e "   ${P_GRAY}└─ Timestamp:    ${NC}$(date '+%Y-%m-%d %H:%M:%S')"
    echo ""
    echo -e "   ${BOLD}Próximos pasos:${NC}"
    
    if [ "$SELECTED_TOOL" = "Openclaw" ]; then
        echo -e "   ${P_BLUE}1.${NC} Los skills están disponibles en Openclaw"
        echo -e "   ${P_BLUE}2.${NC} Reinicia Openclaw si es necesario."
    else
        echo -e "   ${P_BLUE}1.${NC} Navega a: ${P_GRAY}cd ${PROJECT_PATH}${NC}"
        echo -e "   ${P_BLUE}2.${NC} Ejecuta tu IA preferida."
    fi
    
    echo ""
}

# ═══════════════════════════════════════════════════════════════
# EJECUCIÓN PRINCIPAL
# ═══════════════════════════════════════════════════════════════

main() {
    draw_hero
    select_tool
    
    # Manejo especial para Openclaw (solo inyecta skills)
    if [ "$SELECTED_TOOL" = "Openclaw" ]; then
        get_openclaw_path
        deploy_openclaw_skills
    else
        # Flujo normal para OpenCode y Claude Code
        get_project_path
        select_folders
        create_links
    fi
    
    print_receipt
}

main "$@"