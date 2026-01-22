# OpenCode Agents - Referencia de Agentes Estandarizados

**Última actualización**: Jan 22, 2025

## 📋 Resumen de Cambios

Todos los agentes han sido **estandarizados** a partir de `_template.md` para garantizar consistencia, mantenibilidad y documentación clara.

### Estructura Uniforme

Cada agente ahora sigue esta estructura:

```yaml
---
description: [Breve descripción]
mode: [primary | subagent]
model: [Modelo IA]
temperature: [0.0-1.0]
tools:
  [Configuración granular de herramientas]
---

## 1. Persona y Rol
## 2. Responsabilidades
## 3. Protocolo de Trabajo
## 4. Formato de Salida
## 5. Límites y Restricciones
## 6. Ejemplos de Uso
```

---

## 🤖 Agentes Disponibles

### 0. **data-engineer** (Principal - Senior)
- **Modo**: Primary ⭐ **RECOMENDADO PARA INICIAR**
- **Modelo**: Claude Sonnet 3.5
- **Temperature**: 0.3 (Equilibrio entre precisión y flexibilidad)
- **Propósito**: Ingeniero de Datos Senior que coordina flujos completos
- **Herramientas principales**: Todas (read, write, edit, bash, glob, grep, webfetch, task)
- **Entrada típica**: Requerimiento de negocio de datos (alto nivel)
- **Salida típica**: Solución completa (código, tests, documentación, commits)

**Cuándo usarlo**: Es el punto de entrada principal para cualquier trabajo de ingeniería de datos. Analiza requerimientos, coordina a todos los agentes especializados, valida calidad y entrega soluciones completas.

**Flujo que orquesta**:
```
data-engineer (análisis)
    ↓
git-manager (rama feature)
    ↓
tdd-architect (tests RED)
    ↓
python-coder (implementación GREEN)
    ↓
validación técnica
    ↓
git-manager (commit semántico)
```

---

### 0b. **sql-specialist** (Especialista)
- **Modo**: Primary
- **Modelo**: Claude Sonnet 3.5
- **Temperature**: 0.1 (Precisión máxima en queries)
- **Propósito**: Especialista en SQL que diseña, optimiza y ejecuta queries
- **Herramientas principales**: read, write, edit, bash, glob, grep
- **Entrada típica**: Requerimiento de acceso a datos, optimización, esquema
- **Salida típica**: Queries optimizadas, EXPLAIN PLAN, documentación

**Cuándo usarlo**: Para cualquier trabajo relacionado con SQL: diseño de esquemas, escritura de queries, optimización de performance, análisis de EXPLAIN PLAN, migraciones de datos.

**Casos de uso**:
- Diseñar esquemas de base de datos
- Escribir queries complejas (CTEs, window functions, agregaciones)
- Optimizar queries lentas
- Crear índices estratégicos
- Migraciones de datos
- Reportes y dashboards SQL

---

### 1. **data-maker** (Orquestador)
- **Modo**: Primary
- **Modelo**: Claude Sonnet 3.5
- **Temperature**: 0.2
- **Propósito**: Coordinar tareas de ingeniería de datos
- **Herramientas principales**: task, read, glob, grep
- **Flujo**: Análisis → git-manager → tdd-architect → python-coder → git-manager

**Cuándo usarlo**: Para orquestar pipelines de datos complejos que requieren múltiples agentes especializados. Alternativa a data-engineer cuando necesitas control más granular de la orquestación.

---

### 2. **git-manager** (Control de Versiones)
- **Modo**: Primary
- **Modelo**: Google Gemini 2.0 Flash
- **Temperature**: 0.1
- **Propósito**: Gestión de ramas, commits semánticos
- **Herramientas principales**: bash, edit, read, glob
- **Permisos bash**: ask (git status/diff allow)

**Cuándo usarlo**: Para crear ramas, hacer commits, manejar flujos de Git con seguridad.

### 3. **python-coder** (Implementación)
- **Modo**: Primary
- **Modelo**: Google Gemini 2.5 Flash Lite
- **Temperature**: 0.1
- **Propósito**: Implementar código Python conforme a PEP 8
- **Herramientas principales**: read, write, edit, bash, glob, grep
- **Regla lingüística**: Código en inglés, docstrings en español

**Cuándo usarlo**: Para implementar soluciones Python basadas en tests, con énfasis en tipado y documentación.

### 4. **tdd-architect** (Diseño de Pruebas)
- **Modo**: Subagent
- **Modelo**: Claude Sonnet 3.5
- **Temperature**: 0.0
- **Propósito**: Crear test suites con documentación TDD
- **Herramientas principales**: read, write, edit, bash, glob, grep
- **Protocolo**: Análisis → Planificación → Codificación (RED) → Validación

**Cuándo usarlo**: Para diseñar pruebas documentadas que guíen la implementación (Test-Driven Development).

### 5. **_template.md** (Plantilla)
- **Propósito**: Referencia para crear nuevos agentes
- **Incluye**: Comentarios explicativos de todos los campos
- **Uso**: Copiar y personalizar

**Cuándo usarlo**: Como base para crear nuevos agentes personalizados.

---

## 🔧 Configuración Común

### Herramientas Disponibles

| Herramienta | read | write | edit | bash | glob | grep | webfetch | task |
|-------------|------|-------|------|------|------|------|----------|------|
| data-engineer| ✅   | ✅    | ✅   | ✅*  | ✅   | ✅   | ✅       | ✅   |
| sql-specialist| ✅  | ✅    | ✅   | ✅*  | ✅   | ✅   | ❌       | ❌   |
| data-maker  | ✅   | ❌    | ❌   | ❌   | ✅   | ✅   | ❌       | ✅   |
| git-manager | ✅   | ❌    | ✅   | ✅*  | ✅   | ✅   | ❌       | ❌   |
| python-coder| ✅   | ✅    | ✅   | ✅   | ✅   | ✅   | ❌       | ❌   |
| tdd-architect| ✅  | ✅    | ✅   | ✅   | ✅   | ✅   | ❌       | ❌   |

*data-engineer & git-manager & sql-specialist: bash requiere "ask" para seguridad

### Temperaturas (Control de Creatividad)

- **0.0** (Determinístico): tdd-architect - Pruebas exactas
- **0.1** (Preciso): git-manager, python-coder, sql-specialist - Implementación segura
- **0.2** (Balanceado): data-maker - Coordinación flexible
- **0.3** (Flexible): data-engineer - Análisis y diseño adaptativo

---

## 📊 Flujo de Trabajo Recomendado

### Inicio: Punto de Entrada Único

```
Usuario → data-engineer (análisis y coordinación)
```

**data-engineer** es el agente principal que:
- Entiende requerimientos de alto nivel
- Analiza complejidad
- Orquesta a todos los otros agentes
- Valida calidad
- Entrega soluciones completas

### Ciclo Completo TDD + Git (Ejecutado por data-engineer)

```
data-engineer (análisis)
    ↓
git-manager (crear feature branch)
    ↓
tdd-architect (crear tests - fase RED)
    ↓
python-coder (implementar lógica - fase GREEN)
    ↓
validación técnica (data-engineer)
    ↓
git-manager (commit semántico + push)
    ↓
data-engineer (validación final y cierre)
```

### Usos Especializados

**Flujo Completo**: Usar `data-engineer`
```
Entrada: Requerimiento de negocio de datos
Salida: Solución completa (código, tests, docs, commits)
```

**Flujo Simplificado** (sin orquestación): Usar agentes especializados
```
data-engineer → git-manager (solo git)
data-engineer → python-coder (solo implementación)
data-engineer → tdd-architect (solo tests)
```

**Orquestación Avanzada**: Usar `data-maker` (múltiples pipelines)
```
data-engineer → data-maker (coordinar múltiples componentes)
```

---

## 📝 Estándares de Documentación

### Frontmatter YAML

Todos los agentes incluyen:
- `description`: Breve (max 80 caracteres)
- `mode`: primary o subagent
- `model`: Modelo específico (no placeholder)
- `temperature`: Valor numérico 0.0-1.0
- `tools`: Configuración booleana de herramientas
- `permission`: (Opcional) Controles granulares de bash

### Cuerpo del Agente

Todos incluyen 6 secciones:
1. **Persona y Rol**: Quién eres + especialidad
2. **Responsabilidades**: Listado de 3+ responsabilidades
3. **Protocolo de Trabajo**: 4+ pasos del flujo
4. **Formato de Salida**: Ejemplo de respuesta esperada
5. **Límites y Restricciones**: Siempre hacer / Nunca hacer
6. **Ejemplos de Uso**: 2+ casos reales

## 🚀 Crear Nuevo Agente

1. Copiar `_template.md` → `mi-agente.md`
2. Completar frontmatter con datos reales
3. Seguir estructura de 6 secciones
4. Incluir ejemplos específicos a tu caso
5. Guardar en `~/.config/opencode/agents/` (global) o `.opencode/agents/` (proyecto)

**Ejemplo**:
```bash
cp _template.md code-reviewer.md
# Editar code-reviewer.md
# El agente estará disponible inmediatamente en OpenCode
```

---

## ✅ Checklist para Nuevo Agente

- [ ] Frontmatter completo (description, mode, model, temperature, tools)
- [ ] Sección 1: Persona y Rol clara
- [ ] Sección 2: Responsabilidades específicas (3+)
- [ ] Sección 3: Protocolo de Trabajo (4+ pasos)
- [ ] Sección 4: Formato de Salida con ejemplo
- [ ] Sección 5: Límites y Restricciones ("Siempre/Nunca hacer")
- [ ] Sección 6: Ejemplos de Uso (2+)
- [ ] Lenguaje consistente (español para instrucciones, inglés para ejemplos de código)
- [ ] Sin placeholders (todos los campos tienen valores reales)

---

## 🔗 Referencias

- **Plantilla**: `_template.md`
- **Documentación OpenCode**: https://opencode.ai/docs
- **Ubicación global**: `~/.config/opencode/agents/`
- **Ubicación proyecto**: `.opencode/agents/`

