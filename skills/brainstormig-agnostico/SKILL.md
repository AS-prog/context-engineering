---
name: brainstorming-agnostico
description: "Use when the user wants to develop a raw idea, project, or concept in Obsidian. This skill facilitates a collaborative dialogue to refine intent and explore alternatives before finalizing a structured design."
---

# Brainstorming Agnóstico

## Configuration

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
- Usa la plantilla `nota_base.md` ubicada en `$OBSIDIAN_VAULT_PATH/00_borradores/nota_base.md`.
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

## Estructura del Documento

Aplica esta estructura al contenido del borrador:

1. **Título:** Descriptivo y claro
2. **Contexto:** Situación, problema o antecedentes
3. **Objetivos:** Qué busca lograr este borrador
4. **Estado Actual:** Conocimiento o progreso existente
5. **Enfoque Propuesto:** Ruta recomendada
6. **Alternativas Consideradas:** Otras opciones evaluadas
7. **Siguientes Pasos:** Acciones concretas necesarias
8. **Preguntas Abiertas:** Incertidumbres por resolver

## Tipos de Borradores Soportados

### 1. Planificación de Proyecto
- **Estructura:** Problema → Objetivos → Enfoque → Cronograma
- **Ejemplos:** Desarrollo de talleres, implementación de sistemas
- **Plantilla:** `project_planning_template.md` en `00_borradores/`

### 2. Documentación de Procesos
- **Estructura:** Proceso Actual → Problemas → Cambios Propuestos → Impacto
- **Ejemplos:** Mejoras de flujo de trabajo, actualizaciones de políticas
- **Plantilla:** `process_improvement_template.md` en `00_borradores/`

### 3. Resumen de Investigación
- **Estructura:** Pregunta de Investigación → Hallazgos → Análisis → Conclusiones
- **Ejemplos:** Investigación de mercado, tendencias tecnológicas
- **Plantilla:** `research_summary_template.md` en `00_borradores/`

## Validaciones y Verificación

### Antes de Crear
- [ ] Verificar accesibilidad del vault
- [ ] Confirmar estructura de directorios (`01_borradores/` existe)
- [ ] Verificar disponibilidad de plantilla en `00_borradores/`
- [ ] Evaluar unicidad del tema

### Durante la Creación
- [ ] Verificar completitud de metadatos YAML
- [ ] Confirmar flujo lógico de secciones
- [ ] Validar precisión de cross-referencias
- [ ] Cumplir convención de nombres: `tema_YYYYMMDD.md`

### Después de Crear
- [ ] Confirmar escritura en sistema de archivos
- [ ] Verificar lectura del archivo
- [ ] Validar integridad de enlaces
- [ ] Confirmar inclusión en índice de búsqueda

## Comportamientos Context-Aware

### Contexto Personal (Andrés)
- Acceso completo a todos los vaults
- Creación en cualquier ubicación
- Máxima flexibilidad en selección de temas

### Contexto Grupal (Familia/Equipo)
- Enfoque colaborativo
- Vaults compartidos (ej: `03_grupo_familia/`)
- Contenido respetuoso de privacidad
- Énfasis en construcción de consenso

### Contexto Restringido (Otros Usuarios)
- Limitado a vaults designados por usuario
- Capacidades básicas de creación
- Límites de privacidad estrictamente aplicados
