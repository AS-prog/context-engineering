# 🚀 Guía de Configuración Multi-Plataforma

Esta guía explica cómo configurar el sistema de brainstorming para que funcione tanto en **Linux (Linode)** como en **macOS (Mac personal)**.

---

## 📋 Requisitos Previos

- **Sistema operativo:** Linux o macOS
- **Shell:** Zsh (recomendado) o Bash
- **Git:** Instalado en ambas máquinas
- **Vault de Obsidian:** Estructura compatible

---

## 🎯 Estructura de Directorios Esperada

### Linux (Linode)
```
/home/andresrsotelo/
└── projects/
    ├── context-engineering/     # Este repositorio
    └── docs/
        └── delphi_project/       # Vault de Obsidian
```

### macOS (Mac Personal)
```
/Users/andressotelo/
└── projects/
    ├── context-engineering/     # Este repositorio (después de clonar)
    └── docs/
        └── delphi_project/       # Vault de Obsidian (después de clonar)
```

---

## ⚙️ Configuración Paso a Paso

### Paso 1: Configurar Zsh

El archivo `~/.zshrc` ya está configurado en tu máquina Linux. Para la Mac, simplemente copia el mismo contenido.

**Contenido de `~/.zshrc`:**

```zsh
# ============================================
# Configuración de Vault de Obsidian
# ============================================

# Detectar sistema operativo y configurar ruta del vault
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux (Linode)
    export OBSIDIAN_VAULT_PATH="$HOME/projects/docs/delphi_project"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    export OBSIDIAN_VAULT_PATH="$HOME/projects/docs/delphi_project"
fi

# Verificar que la variable esté configurada
if [ -z "$OBSIDIAN_VAULT_PATH" ]; then
    echo "⚠️  ADVERTENCIA: OBSIDIAN_VAULT_PATH no está configurada"
    echo "   Sistema detectado: $OSTYPE"
else
    # Solo mostrar en sesiones interactivas (no en scripts)
    if [[ $- == *i* ]]; then
        echo "✅ Vault configurado: $OBSIDIAN_VAULT_PATH"
    fi
fi
```

### Paso 2: Verificar Configuración

Después de editar `~/.zshrc`, ejecuta:

```zsh
source ~/.zshrc
echo $OBSIDIAN_VAULT_PATH
```

Debería mostrar:
- **Linux:** `/home/andresrsotelo/projects/docs/delphi_project`
- **Mac:** `/Users/andressotelo/projects/docs/delphi_project`

---

## 🔄 Checklist para Configurar Mac (Cuando clones)

### 1. Clonar Repositorios

```zsh
# Crear directorio de proyectos
mkdir -p ~/projects
cd ~/projects

# Clonar este repositorio
git clone https://github.com/tu-usuario/context-engineering.git

# Clonar el vault (cuando lo tengas en GitHub)
git clone https://github.com/tu-usuario/delphi_project.git docs/delphi_project
```

### 2. Configurar Zsh

```zsh
# Copiar el contenido del .zshrc de Linux o crearlo manualmente
nano ~/.zshrc
# [Pegar el contenido de arriba]

# Aplicar cambios
source ~/.zshrc
```

### 3. Verificar Estructura

```zsh
ls -la ~/projects/
# Debería mostrar:
#   context-engineering/
#   docs/
#     └── delphi_project/

# Verificar variable
echo $OBSIDIAN_VAULT_PATH
# Debe mostrar: /Users/andressotelo/projects/docs/delphi_project
```

### 4. Probar Skills

```zsh
# Entrar al repositorio
cd ~/projects/context-engineering

# Verificar que los skills funcionan
# (Prueba con un brainstorming simple)
```

---

## 🔄 Sincronización del Vault

### Opción 1: Git Manual (Recomendado al inicio)

```zsh
# En Linux o Mac
cd $OBSIDIAN_VAULT_PATH

# Ver cambios
git status

# Commit y push
git add -A
git commit -m "feat: actualización diaria del vault"
git push origin main

# En la otra máquina
git pull origin main
```

### Opción 2: Git + Cron (Automático)

**En Linux:**
```bash
# Editar crontab
crontab -e

# Agregar línea para sincronizar cada hora
0 * * * * cd $HOME/projects/docs/delphi_project && git pull origin main && git add -A && git commit -m "auto: sync $(date +%Y%m%d-%H%M)" && git push origin main 2>/dev/null
```

**En Mac:**
```zsh
# Usar launchd en lugar de cron (más moderno)
# O usar cron tradicional
crontab -e
```

### Opción 3: Herramientas de Sincronización

- **Obsidian Sync:** Integrado, de pago ($8/mes)
- **iCloud:** Automático si el vault está en iCloud Drive
- **Dropbox/Syncthing:** Opciones gratuitas

---

## 🐛 Solución de Problemas

### Problema: Variable no configurada

**Síntoma:**
```
$OBSIDIAN_VAULT_PATH está vacía
```

**Solución:**
```zsh
# Verificar que .zshrc existe
ls -la ~/.zshrc

# Si no existe, crearlo
nano ~/.zshrc
# [Agregar configuración]

# Aplicar cambios
source ~/.zshrc
```

### Problema: Sistema operativo no detectado

**Síntoma:**
```
⚠️  ADVERTENCIA: OBSIDIAN_VAULT_PATH no está configurada
   Sistema detectado: (vacío o desconocido)
```

**Solución:**
```zsh
# Verificar OSTYPE
echo $OSTYPE

# Debería mostrar:
# - Linux: linux-gnu
# - Mac: darwin

# Si muestra algo diferente, actualizar el if en .zshrc
```

### Problema: Directorio no existe

**Síntoma:**
```
Error: No existe el directorio /home/andresrsotelo/projects/docs/delphi_project
```

**Solución:**
```zsh
# Crear estructura de directorios
mkdir -p "$HOME/projects/docs/delphi_project/01_borradores"
mkdir -p "$HOME/projects/docs/delphi_project/02_notas"
```

---

## 📚 Referencias

- **AGENTS.md:** Documentación principal de agentes y skills
- **skills/brainstormig-agnostico/SKILL.md:** Skill para ideas abstractas
- **skills/brainstormig-codigo/SKILL.md:** Skill para diseño técnico

---

**Última actualización:** Febrero 2026  
**Versión:** 1.0.0
