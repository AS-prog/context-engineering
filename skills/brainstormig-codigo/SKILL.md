---
name: brainstorming-codigo
description: "DEBE usarse antes de cualquier trabajo creativo: creación de funciones, construcción de componentes, adición de funcionalidades o modificación de comportamientos. Explora la intención del usuario, los requisitos y el diseño antes de la implementación."
---

# Brainstorming de Código

## ⚙️ Configuración

Este skill requiere la variable de entorno `OBSIDIAN_VAULT_PATH` para escribir los diseños en tu vault de Obsidian de manera agnóstica.

### Configuración por Sistema Operativo:

**Linux/Mac (Zsh):**
```bash
# Agregar al final de ~/.zshrc:
# Detectar sistema operativo y configurar ruta del vault
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux (Linode)
    export OBSIDIAN_VAULT_PATH="$HOME/projects/docs/delphi_project"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    export OBSIDIAN_VAULT_PATH="$HOME/projects/docs/delphi_project"
fi

# Para aplicar cambios:
source ~/.zshrc
```

**Linux (Bash):**
```bash
# Agregar al final de ~/.bashrc:
export OBSIDIAN_VAULT_PATH="$HOME/projects/docs/delphi_project"

# Para aplicar cambios:
source ~/.bashrc
```

> **Nota:** Si la variable no está definida, el diseño se guardará en `$OBSIDIAN_VAULT_PATH/01_borradores/` usando el formato del vault.

## 📖 Resumen
Ayuda a transformar ideas técnicas en diseños y especificaciones completas a través de un diálogo colaborativo natural.

## 🛠️ El Proceso

### Fase 1: Entender la Idea
- **Contexto actual:** Revisar primero el estado del proyecto (archivos, documentación, commits recientes) y notas relacionadas en `01_borradores/` y `02_notas/`.
- **Iteración atómica:** Hacer preguntas de una en una para refinar la idea.
- **Preferencias:** Priorizar preguntas de opción múltiple para agilizar la toma de decisiones.
- **Foco:** Comprender el propósito, las restricciones y los criterios de éxito.

### Fase 2: Explorar Enfoques
- **Propuestas:** Presentar 2-3 enfoques técnicos diferentes con sus pros y contras.
- **Recomendación:** Liderar con la opción recomendada y explicar el razonamiento técnico.

### Fase 3: Presentación del Diseño
- **Entrega fragmentada:** Presentar el diseño en secciones de 200-300 palabras.
- **Validación incremental:** Preguntar si el diseño es correcto después de cada sección.
- **Cobertura:** Incluir arquitectura, componentes, flujo de datos, manejo de errores y pruebas.

## 📜 Principios Clave
- **Una pregunta a la vez:** No abrumar con múltiples interrogantes.
- **YAGNI (No lo vas a necesitar):** Eliminar rigurosamente características innecesarias de todos los diseños.
- **Validación constante:** Estar listo para retroceder y aclarar si algo no tiene sentido.

## 🏁 Post-Diseño
- **Documentación:** Escribir el diseño validado en la ruta determinada por la variable de entorno `OBSIDIAN_VAULT_PATH`:
  - **Ruta completa:** `$OBSIDIAN_VAULT_PATH/01_borradores/<topic>_YYYYMMDD.md`
  - **Fallback:** Si `OBSIDIAN_VAULT_PATH` no está definida, usar `./docs/plans/<topic>_YYYYMMDD.md`
- Usa la plantilla `nota_en_desarrollo.md` ubicada en `$OBSIDIAN_VAULT_PATH/00_plantillas/nota_en_desarrollo.md`.
- **Metadatos YAML requeridos:**
  ```yaml
  ---
  tema: <topic>
  fecha: "YYYY-MM-DD"
  curso: <categoria_tecnica>
  categoria:
    - desarrollo
  estado: en_revision
  version: 0.1
  ---
  ```
- **Implementación:** Preguntar "¿Listo para configurar la implementación?" antes de proceder.
- Asegúrate de que el directorio `01_borradores/` exista dentro del vault.
- Nombre de archivo: usar formato `titulo_YYYYMMDD.md` (ej: `api_diseno_20260207.md`).