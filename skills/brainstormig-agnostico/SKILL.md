---
name: brainstorming-agnostico
description: "Use when the user wants to develop a raw idea, project, or concept in Obsidian. This skill facilitates a collaborative dialogue to refine intent and explore alternatives before finalizing a structured design."
---

# Brainstorming Agnóstico

## Configuration

Este skill requiere la variable de entorno `OBSIDIAN_VAULT_PATH` para escribir los diseños en tu vault de Obsidian de manera agnóstica.

### Configuración por Sistema Operativo:

**Linux/Mac:**
```bash
# Agregar a ~/.bashrc, ~/.zshrc, o ~/.bash_profile:
export OBSIDIAN_VAULT_PATH="/home/andresrsotelo/projects/docs/delphi_project"

# Para aplicar cambios:
source ~/.bashrc  # o ~/.zshrc
```

**Windows (PowerShell):**
```powershell
# Agregar a tu perfil de PowerShell ($PROFILE):
[Environment]::SetEnvironmentVariable("OBSIDIAN_VAULT_PATH", "C:\Users\andresrsotelo\projects\docs\delphi_project", "User")

# O temporalmente en la sesión actual:
$env:OBSIDIAN_VAULT_PATH = "C:\Users\andresrsotelo\projects\docs\delphi_project"
```

**Windows (CMD):**
```cmd
setx OBSIDIAN_VAULT_PATH "C:\Users\andresrsotelo\projects\docs\delphi_project"
```

> **Nota:** Si la variable no está definida, el diseño se guardará en `$OBSIDIAN_VAULT_PATH/01_borradores/` usando el formato del vault.

## Overview
Transforma ideas abstractas en diseños estructurados mediante un diálogo iterativo, eliminando la complejidad innecesaria y asegurando la claridad antes de la ejecución.

## The Process
1. **Comprensión Profunda:**
   - Analizar notas previas relacionadas en el vault (revisar `01_borradores/` y `02_notas/`).
   - Hacer **una sola pregunta** a la vez para refinar la idea.
   - Priorizar preguntas de opción múltiple para agilizar la toma de decisiones.
2. **Exploración de Enfoques:**
   - Proponer **2-3 enfoques distintos** con sus respectivos pros y contras.
   - Recomendar uno basándose en la simplicidad (YAGNI).
3. **Presentación Incremental:**
   - Presentar el diseño en secciones de **200-300 palabras**.
   - Validar con el usuario después de cada sección.

## Key Principles
- **Una pregunta a la vez:** Evitar abrumar al usuario.
- **YAGNI:** Eliminar funciones o pasos que no sean estrictamente necesarios para el éxito.
- **Salida Estandarizada:** Al finalizar, aplicar obligatoriamente la plantilla del vault (`nota_base.md`).

## After the Design
- Usa la plantilla `nota_base.md` ubicada en `$OBSIDIAN_VAULT_PATH/00_plantillas/nota_base.md`.
- Escribe el diseño validado en la ruta determinada por la variable de entorno `OBSIDIAN_VAULT_PATH`:
  - **Ruta completa:** `$OBSIDIAN_VAULT_PATH/01_borradores/<topic>_YYYYMMDD.md`
  - **Fallback:** Si `OBSIDIAN_VAULT_PATH` no está definida, usar `./docs/plans/<topic>_YYYYMMDD.md`
- **Metadatos YAML requeridos:**
  ```yaml
  ---
  tema: <topic>
  fecha: "YYYY-MM-DD"
  curso: <categoria>
  categoria:
    - borrador
  estado: en_desarrollo
  ---
  ```
- Asegúrate de que el directorio `01_borradores/` exista dentro del vault.
- Nombre de archivo: usar formato `titulo_YYYYMMDD.md` (ej: `mi_idea_20260207.md`).
