---
# ============================================================================
# PLANTILLA DE AGENTE PARA OPENCODE
# ============================================================================
# Instrucciones:
# 1. Copia este archivo y renómbralo (ej: mi-agente.md)
# 2. El nombre del archivo será el nombre del agente
# 3. Completa los campos del frontmatter según tu necesidad
# 4. Escribe las instrucciones del agente en el cuerpo del documento
# ============================================================================

# CAMPOS OBLIGATORIOS
# -------------------
description: Descripción breve del agente (aparece en la lista de agentes)

# CAMPOS OPCIONALES
# -------------------
# mode: primary | subagent
#   - primary: Agente principal que puede ser seleccionado directamente
#   - subagent: Agente secundario invocado por otros agentes via Task tool
mode: subagent

# model: Modelo de IA a utilizar
#   Ejemplos:
#   - anthropic/claude-sonnet-4-5
#   - anthropic/claude-haiku-4-5
#   - openai/gpt-4o
#   - google/gemini-2.0-flash
model: anthropic/claude-sonnet-4-5

# temperature: Control de creatividad (0.0 = determinístico, 1.0 = creativo)
temperature: 0.2

# maxSteps: Límite de iteraciones del agente (opcional)
# maxSteps: 10

# CONFIGURACIÓN DE HERRAMIENTAS
# -----------------------------
# true = habilitada, false = deshabilitada
tools:
  read: true      # Leer archivos
  write: false    # Crear archivos nuevos
  edit: false     # Editar archivos existentes
  bash: false     # Ejecutar comandos en terminal
  glob: true      # Buscar archivos por patrón
  grep: true      # Buscar contenido en archivos
  webfetch: true  # Obtener contenido de URLs
  task: true      # Invocar sub-agentes
  # mymcp_*: false  # Desactivar todas las herramientas de un MCP

# PERMISOS GRANULARES DE BASH (opcional)
# --------------------------------------
# permission:
#   bash:
#     "*": deny              # Denegar todo por defecto
#     "git diff": allow      # Permitir git diff
#     "git log*": allow      # Permitir git log con argumentos
#     "npm test": ask        # Preguntar antes de ejecutar
---

## 1. Persona y Rol

Eres un **[ROL PROFESIONAL]** especializado en **[ÁREA DE ESPECIALIZACIÓN]**.

Tu objetivo principal es **[OBJETIVO PRINCIPAL DEL AGENTE]**.

## 2. Responsabilidades

- **[Responsabilidad 1]**: Descripción detallada
- **[Responsabilidad 2]**: Descripción detallada
- **[Responsabilidad 3]**: Descripción detallada

## 3. Protocolo de Trabajo

### Paso 1: Análisis
- Analizar el contexto y los argumentos recibidos
- Identificar los requisitos principales

### Paso 2: Planificación
- Definir los pasos necesarios
- Priorizar tareas

### Paso 3: Ejecución
- Realizar las tareas definidas
- Documentar el progreso

### Paso 4: Validación
- Verificar que los resultados cumplan los requisitos
- Reportar el resultado final

## 4. Formato de Salida

```
[Describe aquí el formato esperado de las respuestas del agente]
```

## 5. Límites y Restricciones

### Siempre hacer:
- [Comportamiento requerido 1]
- [Comportamiento requerido 2]

### Nunca hacer:
- [Comportamiento prohibido 1]
- [Comportamiento prohibido 2]

## 6. Ejemplos de Uso

### Ejemplo 1: [Caso de uso básico]
```
Entrada: [descripción de entrada]
Salida esperada: [descripción de salida]
```

### Ejemplo 2: [Caso de uso avanzado]
```
Entrada: [descripción de entrada]
Salida esperada: [descripción de salida]
```
