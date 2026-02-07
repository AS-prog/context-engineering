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
- Usa la plantilla `nota_en_desarrollo.md` ubicada en `$OBSIDIAN_VAULT_PATH/00_borradores/nota_en_desarrollo.md`.
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

## Estructura del Documento Técnico

Aplica esta estructura al contenido del borrador técnico:

1. **Título:** Nombre descriptivo del componente/sistema
2. **Resumen Ejecutivo:** Visión general de alto nivel
3. **Contexto Técnico:** Estado actual del sistema, dependencias, restricciones
4. **Requisitos:** Funcionales y no funcionales identificados
5. **Diseño Propuesto:** Arquitectura, componentes, flujo de datos
6. **Alternativas Técnicas:** Otras opciones evaluadas con análisis de pros/contras
7. **Manejo de Errores:** Estrategias de recuperación y casos edge
8. **Pruebas:** Estrategia de testing y criterios de aceptación
9. **Implementación:** Plan de desarrollo y despliegue
10. **Referencias:** Documentación, recursos, notas relacionadas

## Tipos de Borradores Técnicos

### Exploración/Evaluación Técnica
- **Estructura:** Tecnología → Casos de Uso → Evaluación → Recomendación
- **Ejemplos:** Comparación de herramientas, decisiones de arquitectura
- **Plantilla:** `technical_evaluation_template.md` en `00_borradores/`

### Implementación de Sistema
- **Estructura:** Requisitos → Diseño → Componentes → Testing → Despliegue
- **Ejemplos:** Nuevos servicios, refactorizaciones mayores
- **Plantilla:** `system_implementation_template.md` en `00_borradores/`

## Fases del Proceso de Diseño

### Fase 1: Establecimiento de Contexto
1. **Detección de Vault:** Identificar ubicación del vault de Obsidian objetivo
2. **Verificación de Estructura:** Asegurar que existan directorios requeridos (`01_borradores/`, `00_borradores/`)
3. **Carga de Plantilla:** Usar plantilla apropiada desde `00_borradores/`
4. **Identificación de Tema:** Clarificar el tema técnico específico

### Fase 2: Diálogo Iterativo
1. **Enfoque de Pregunta Única:** Una pregunta enfocada a la vez
2. **Opciones de Múltiple Opción:** Proporcionar 2-3 alternativas claras cuando sea apropiado
3. **Refinamiento Progresivo:** Construir comprensión incrementalmente
4. **Puntos de Validación:** Confirmar alineación después de cada sección significativa

### Fase 3: Salida Estructurada
1. **Aplicación de Plantilla:** Aplicar plantilla estándar del vault
2. **Completitud de Metadatos:** Llenar todos los campos YAML requeridos
3. **Nombramiento de Archivo:** Usar formato consistente: `tema_YYYYMMDD.md`
4. **Ubicación:** Guardar en `01_borradores/` o directorio específico del contexto

### Fase 4: Seguimiento y Mantenimiento
1. **Seguimiento de Estado:** Actualizar campo `estado` a medida que avanza el trabajo
2. **Cross-referencing:** Crear wikilinks a documentos relacionados
3. **Generación de Resumen:** Opcionalmente crear resúmenes ejecutivos
4. **Planificación de Archivado:** Definir criterios para mover de `en_revision` a `completado`

## Validaciones y Verificación

### Pre-Creación
- [ ] Confirmar accesibilidad del vault
- [ ] Verificar estructura de directorios
- [ ] Confirmar disponibilidad de plantilla en `00_borradores/`
- [ ] Evaluar unicidad del tema técnico

### Durante Creación
- [ ] Verificar completitud de metadatos YAML
- [ ] Confirmar flujo lógico de secciones técnicas
- [ ] Validar precisión de referencias cruzadas
- [ ] Cumplir convención de nombres

### Post-Creación
- [ ] Confirmar escritura exitosa en sistema de archivos
- [ ] Verificar lectura del archivo
- [ ] Validar integridad de wikilinks
- [ ] Confirmar indexación en búsqueda