# 🏗️ Arquitectura del Sistema - Ingeniería de Contexto

**Versión**: 1.0  
**Última actualización**: Jan 23, 2025  
**Propósito**: Documentación detallada de la arquitectura, patrones y decisiones de diseño del sistema de agentes.

---

## 📋 Tabla de Contenidos

1. [Visión General](#visión-general)
2. [Patrón de Orquestación](#patrón-de-orquestación)
3. [Anatomía de un Agente](#anatomía-de-un-agente)
4. [Flujo de Comunicación](#flujo-de-comunicación)
5. [Patrones de Diseño](#patrones-de-diseño)
6. [Configuración (opencode.jsonc)](#configuración)
7. [Extensibilidad](#extensibilidad)
8. [Decisiones de Arquitectura](#decisiones-de-arquitectura)

---

## 🎯 Visión General

El sistema de **Ingeniería de Contexto** es una orquestación de agentes especializados usando OpenCode. Implementa el patrón:

```
1 ORQUESTADOR + N SUBAGENTES ESPECIALIZADOS
```

### Características Clave

- **Modularidad**: Cada agente tiene responsabilidad única
- **Orquestación Centralizada**: Un agente principal coordina el workflow
- **Trazabilidad**: Logging en cada invocación
- **Configuración Explícita**: opencode.jsonc controla permisos
- **Extensibilidad**: Fácil agregar nuevos subagentes

### Beneficios

| Aspecto | Beneficio |
|--------|----------|
| **Escalabilidad** | Agregar agentes sin cambiar existentes |
| **Mantenibilidad** | Cada agente enfocado en su dominio |
| **Debuggabilidad** | Logs claros de qué hizo cada agente |
| **Reusabilidad** | Subagentes usables por múltiples orquestadores |
| **Testing** | Fácil aislar y probar agentes |

---

## 🔄 Patrón de Orquestación

### Estructura Jerárquica

```
┌─────────────────────────────────────────────────┐
│  USER REQUEST                                   │
└────────────────┬────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────┐
│  @data-engineer (PRIMARY ORCHESTRATOR)          │
│  - Analiza requerimiento                        │
│  - Crea plan de ejecución                       │
│  - Invoca subagentes                            │
│  - Valida calidad                               │
│  - Entrega solución final                       │
└────────┬──────┬──────┬──────┬───────────────────┘
         │      │      │      │
    ┌────▼┐ ┌──▼──┐ ┌─▼───┐ ┌▼──────────┐
    │git- │ │tdd- │ │py   │ │sql-       │
    │mgr  │ │arch │ │coder│ │specialist │
    └─────┘ └─────┘ └─────┘ └──────────┘
      git    tests   impl    schema
```

### Estados de Ejecución

```
USER INPUT
    ↓
@data-engineer STARTS
    ├─ ANALYZE requirement
    ├─ CREATE execution plan
    │
    ├─ INVOKE subagent (git-manager)
    │  ├─ Create branch
    │  └─ RETURN result
    │
    ├─ INVOKE subagent (sql-specialist)
    │  ├─ Design schema
    │  └─ RETURN result
    │
    ├─ INVOKE subagent (tdd-architect)
    │  ├─ Design tests
    │  └─ RETURN result (RED phase)
    │
    ├─ INVOKE subagent (python-coder)
    │  ├─ Implement code
    │  └─ RETURN result (GREEN phase)
    │
    ├─ VALIDATE quality
    ├─ INVOKE subagent (git-manager)
    │  ├─ Commit changes
    │  └─ RETURN result
    │
    └─ DELIVER final report
         ↓
      USER RECEIVES SOLUTION
```

### Invocación de Subagentes

La comunicación entre agentes usa el **Task tool** de OpenCode:

```markdown
@data-engineer invoca @git-manager:
┌─────────────────────────────────────┐
│ task(                               │
│   description: "Crear rama feature" │
│   prompt: "Crea rama feature/..."   │
│   subagent_type: "git-manager"      │
│ )                                   │
└─────────────────────────────────────┘
         ↓
    @git-manager STARTS
         ↓
    Crea rama feature/...
         ↓
    RETORNA resultado
         ↓
    @data-engineer recibe
```

---

## 🔍 Anatomía de un Agente

### Estructura Base de un Archivo .md

```markdown
# 🤖 [Agent Name]

**Tipo**: primary | subagent
**Modelo**: Claude 3.5 Sonnet | Gemini 2.5 Flash
**Temperatura**: 0.0 - 1.0
**Versión**: 1.0

---

## 🎯 Responsabilidades

- [Responsabilidad 1]
- [Responsabilidad 2]

---

## 📋 Protocolo de Trabajo

### Fase 1: Análisis
[Detalles de cómo el agente analiza]

### Fase 2: Ejecución
[Detalles de cómo el agente ejecuta]

### Fase 3: Entrega
[Detalles de cómo el agente entrega resultados]

---

## 📚 Estándares y Restricciones

[Restricciones específicas del agente]

---

## 🔗 Integraciones

[Qué otros agentes invoca]

```

### Componentes Clave

1. **Metadata Header**
   - Tipo (primary/subagent)
   - Modelo a usar
   - Temperatura (0 = determinístico, 1 = creativo)
   - Versión

2. **Responsabilidades**
   - Lista clara de qué hace
   - No solapamiento con otros agentes

3. **Protocolo de Trabajo**
   - Pasos secuenciales
   - Entradas esperadas
   - Salidas generadas

4. **Estándares**
   - Qué standards debe seguir
   - Restricciones (no hacer force push, etc)

5. **Logging Headers**
   - Imprime al iniciar
   - Imprime al terminar
   - Muestra artefactos generados

### Logging Format (Estandarizado)

```markdown
═══════════════════════════════════════════════════════════════════
🤖 AGENTE: [agent-name] | INVOCACIÓN INICIADA
📋 Tarea: [task-description]
⏰ Timestamp: [ISO-8601 datetime]
═══════════════════════════════════════════════════════════════════

[Agent work here]

═══════════════════════════════════════════════════════════════════
✅ AGENTE: [agent-name] | TAREA COMPLETADA
📦 Artefactos Generados:
   - artifact1.py
   - artifact2.py
   - artifact3.py
═══════════════════════════════════════════════════════════════════
```

---

## 📡 Flujo de Comunicación

### Invocación Directa (Usuario → Agente)

```
User: @data-engineer "Crear validador de emails"

OpenCode:
├─ Verifica que data-engineer es PRIMARY
├─ Verifica permisos en opencode.jsonc
├─ Carga agents/data-engineer.md
└─ Invoca con prompt del usuario
```

### Invocación de Subagentes (Agente → Agente)

```
@data-engineer quiere invocar @git-manager:

@data-engineer.md:
├─ Usa Task tool
├─ Especifica subagent_type: "git-manager"
├─ Proporciona descripción y prompt detallado
│
OpenCode:
├─ Verifica que data-engineer puede invocar git-manager
├─ Verifica en opencode.jsonc el campo can_invoke
├─ Carga agents/git-manager.md
├─ Ejecuta con prompt de data-engineer
│
@git-manager:
├─ Procesa request
├─ Genera artefactos
├─ Retorna resultado
│
@data-engineer:
├─ Recibe resultado
├─ Continúa con siguiente fase
```

### Datos Retornados

Cuando un subagente completa, retorna:

```json
{
  "status": "completed",
  "artifacts": [
    "src/validators.py",
    "tests/test_validators.py"
  ],
  "summary": "Implementado validador con tests",
  "logs": "Full console output"
}
```

---

## 🎨 Patrones de Diseño

### Patrón 1: Orquestación Secuencial

**Cuándo**: Tareas que dependen una de otra  
**Ejemplo**: Git branch → Tests → Code → Commit

```
Phase 1: @git-manager crea rama
    ↓ (espera resultado)
Phase 2: @tdd-architect crea tests
    ↓ (espera resultado)
Phase 3: @python-coder implementa
    ↓ (espera resultado)
Phase 4: @git-manager hace commit
```

**Ventajas**:
- Control sobre el flujo
- Cada fase depende de la anterior
- Error handling claro

### Patrón 2: Especialización Profunda

**Cuándo**: Cada agente es experto en su dominio  
**Ejemplo**: tdd-architect diseña TODOS los tests

```
@tdd-architect:
├─ Entiende TDD profundamente
├─ Conoce pytest, fixture patterns
├─ Sabe edge cases comunes
├─ Escribe docstrings ESCENARIO/COMPORTAMIENTO
└─ 100% enfocado en tests

NO es responsable de:
├─ Implementación
├─ SQL
├─ Control de versiones
```

**Ventajas**:
- Excelencia en su área
- Reutilizable por múltiples orquestadores
- Fácil de mantener

### Patrón 3: Logging Transparente

**Cuándo**: Usuario necesita ver qué está pasando  
**Implementación**: Headers en cada agente

```
Cuando @git-manager se invoca:
├─ Imprime: 🤖 AGENTE: git-manager | INVOCACIÓN INICIADA
├─ Hace el trabajo
└─ Imprime: ✅ AGENTE: git-manager | TAREA COMPLETADA
             📦 Artefactos: lista
```

**Ventajas**:
- Debugging fácil
- Usuario ve progreso
- Trazabilidad completa

### Patrón 4: Configuración Explícita

**Cuándo**: Sistema necesita ser predecible  
**Implementación**: opencode.jsonc centraliza reglas

```json
{
  "agents": {
    "data-engineer": {
      "mode": "primary",
      "can_invoke": ["git-manager", "tdd-architect", "python-coder", "sql-specialist"]
    },
    "git-manager": {
      "mode": "subagent",
      "can_invoke": []
    }
  }
}
```

**Ventajas**:
- Permisos explícitos
- Imposible invocar mal
- Seguridad mejorada

---

## ⚙️ Configuración (opencode.jsonc)

### Estructura Completa

```jsonc
{
  // Metadata del proyecto
  "project": {
    "name": "Ingeniería de Contexto",
    "version": "1.0",
    "description": "Sistema de agentes especializados"
  },

  // Definiciones de agentes
  "agents": {
    // AGENTE PRIMARIO
    "data-engineer": {
      "mode": "primary",
      "description": "Orquestador principal",
      "can_invoke": [
        "git-manager",
        "tdd-architect", 
        "python-coder",
        "sql-specialist"
      ],
      "temperature": 0.3
    },
    
    // SUBAGENTES
    "git-manager": {
      "mode": "subagent",
      "description": "Control de versiones",
      "can_invoke": [],
      "temperature": 0.1
    },
    
    "tdd-architect": {
      "mode": "subagent",
      "description": "Diseño de tests",
      "can_invoke": [],
      "temperature": 0.0
    },
    
    "python-coder": {
      "mode": "subagent",
      "description": "Implementación Python",
      "can_invoke": [],
      "temperature": 0.1
    },
    
    "sql-specialist": {
      "mode": "subagent",
      "description": "Especialista SQL",
      "can_invoke": [],
      "temperature": 0.1
    }
  },

  // Reglas de seguridad
  "security": {
    "prevent_force_push": true,
    "require_commit_messages": true,
    "ban_files": [".env", "secrets.json", "credentials.json"]
  }
}
```

### Campos Principales

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `mode` | "primary" \| "subagent" | Tipo de agente |
| `can_invoke` | Array[string] | Subagentes que puede invocar |
| `temperature` | 0.0 - 1.0 | Determinístico (0) ↔ Creativo (1) |

### Reglas de Invocación

1. **Solo PRIMARY puede ser invocado directamente por usuario**
   ```
   ✅ User: @data-engineer "..."
   ❌ User: @git-manager "..."  // Subagent, no permitido
   ```

2. **Solo agentes con permiso pueden invocar otros**
   ```
   ✅ @data-engineer invoca @git-manager (tiene permiso)
   ❌ @git-manager invoca @tdd-architect (no tiene permiso)
   ```

3. **Subagentes NO pueden invocar otros agentes**
   ```json
   "git-manager": {
     "can_invoke": []  // Lista vacía = no puede invocar
   }
   ```

---

## 🔌 Extensibilidad

### Agregar un Nuevo Subagente

**Paso 1**: Crear archivo `agents/[agent-name].md`

```markdown
# 🤖 Code Reviewer

**Tipo**: subagent
**Modelo**: Claude 3.5 Sonnet
**Temperatura**: 0.2

## 🎯 Responsabilidades

- Revisar código Python
- Sugerir mejoras
- Validar estándares

## 📋 Protocolo de Trabajo

### Fase 1: Análisis del Código
1. Lee archivos
2. Identifica issues

### Fase 2: Generación de Reporte
[...]
```

**Paso 2**: Actualizar opencode.jsonc

```jsonc
{
  "agents": {
    "data-engineer": {
      "can_invoke": [
        "git-manager",
        "tdd-architect",
        "python-coder",
        "sql-specialist",
        "code-reviewer"  // ← Agregar
      ]
    },
    "code-reviewer": {  // ← Agregar nuevo
      "mode": "subagent",
      "can_invoke": [],
      "temperature": 0.2
    }
  }
}
```

**Paso 3**: Actualizar data-engineer.md

```markdown
## 🔗 Integraciones

Puede invocar:
- @git-manager - Control de versiones
- @tdd-architect - Tests
- @python-coder - Implementación
- @sql-specialist - SQL
- @code-reviewer - Revisión de código  ← Agregar
```

### Agregar un Nuevo Orquestador PRIMARY

Para crear un orquestador especializado en otro dominio:

**Paso 1**: Crear `agents/[orchestrator-name].md`

```markdown
# 🤖 Data Pipeline Orchestrator

**Tipo**: primary
**Modelo**: Claude 3.5 Sonnet
**Temperatura**: 0.3
```

**Paso 2**: Actualizar opencode.jsonc

```jsonc
{
  "agents": {
    "[orchestrator-name]": {
      "mode": "primary",
      "can_invoke": ["list of subagents"]
    }
  }
}
```

**Ventaja**: Múltiples entry points para diferentes dominios
```
User: @data-engineer "..."      (data engineering)
User: @pipeline-orchestrator "..."  (pipeline design)
User: @api-architect "..."      (API design)
```

---

## 🏛️ Decisiones de Arquitectura

### Decisión 1: 1 Orquestador + N Subagentes

**Problema**: Sistema anterior tenía múltiples agentes sin coordinación clara

**Solución**: Patrón jerárquico con orquestador central

**Rationale**:
- ✅ Control centralizado
- ✅ Flujo predecible
- ✅ Fácil de debuggear
- ✅ Escalable

**Trade-offs**:
- ❌ El orquestador es punto de falla único
- ❌ Menos paralelización

**Alternativas Consideradas**:
- Workflow dirigido por grafo (más complejo)
- Agentes autónomos sin coordinación (caótico)

### Decisión 2: Configuración Explícita (opencode.jsonc)

**Problema**: ¿Cómo controlar qué agente puede invocar qué?

**Solución**: Archivo central de configuración con permisos

**Rationale**:
- ✅ Permisos explícitos
- ✅ Fácil auditar
- ✅ No hay sorpresas
- ✅ Seguridad

**Trade-offs**:
- ❌ Requiere mantener config sincronizada
- ❌ Más archivos para cambiar

### Decisión 3: Logging Transparente

**Problema**: Usuario no sabe qué está haciendo el agente

**Solución**: Headers/footers estandarizados con emoji visual

**Rationale**:
- ✅ Debugging fácil
- ✅ Trazabilidad
- ✅ User feedback
- ✅ Profesional

**Trade-offs**:
- ❌ Más líneas de output
- ❌ Mantenimiento de formato

### Decisión 4: Temperatura Baja para Subagentes

**Problema**: Queremos resultados predecibles

**Solución**: 
- Orquestador: temperatura 0.3 (análisis inteligente)
- Subagentes: temperatura 0.0-0.1 (determinístico)

**Rationale**:
- ✅ Resultados consistentes
- ✅ Menos surpresas
- ✅ Mejor para codegen

**Trade-offs**:
- ❌ Menos creatividad
- ❌ Respuestas más mecánicas

### Decisión 5: TDD como Estándar

**Problema**: ¿Cómo asegurar calidad en tests?

**Solución**: @tdd-architect diseña tests ANTES de código

**Rationale**:
- ✅ Calidad garantizada
- ✅ Mejor cobertura
- ✅ Diseño más claro
- ✅ Menos bugs

**Trade-offs**:
- ❌ Más lento (tests primero)
- ❌ Requiere disciplina

---

## 📊 Comparativa: Antes vs Después

| Aspecto | Antes | Después |
|--------|-------|---------|
| **Estructura** | Agentes desorganizados | 1 Orquestador + 4 Subagentes |
| **Flujo** | Incierto | Secuencial predecible |
| **Permisos** | Implícitos | Explícitos en config |
| **Logging** | Mínimo | Logging completo con headers |
| **Testabilidad** | Difícil | Fácil (agentes aislados) |
| **Extensibilidad** | Frágil | Robusta (config + agregar agente) |
| **Documentación** | Incompleta | Completa |

---

## 🚀 Performance y Escalabilidad

### Benchmarks (Esperados)

| Operación | Tiempo | Bottleneck |
|-----------|--------|-----------|
| Análisis requerimiento | 2-5s | LLM latency |
| Crear rama + commit | 1-2s | Git I/O |
| Diseñar tests | 10-20s | LLM reasoning |
| Implementar código | 20-40s | LLM generation |
| Validar tests | 5-10s | pytest execution |
| **Total workflow** | **40-80s** | LLM sequential |

### Escalabilidad

**Número de Agentes**: No hay límite teórico
- Actualmente: 1 primary + 4 subagents
- Posible: 1 primary + 20+ subagents

**Usuarios Concurrentes**: Limitado por OpenCode
- Cada invocación es independiente
- Sin estado compartido
- Escalable horizontalmente

**Tamaño de Proyectos**: Sin límite
- Agentes no tienen estado persistente
- Todo es en-memoria por invocación

---

## 🔐 Seguridad

### Principios

1. **Least Privilege**: Cada agente solo tiene permisos necesarios
2. **Explicit Allow**: Permisos deben ser explícitamente permitidos
3. **No Force Push**: Nunca force push sin aprobación
4. **Secrets Protection**: Archivos sensibles nunca committeados

### Implementación

```jsonc
"security": {
  "prevent_force_push": true,
  "require_commit_messages": true,
  "ban_files": [".env", "secrets.json", "credentials.json"]
}
```

### Auditoría

Cada invocación:
- ✅ Se loguea en header/footer
- ✅ Muestra qué hizo
- ✅ Lista artefactos generados
- ✅ Guardado en git commits

---

## 📚 Referencias

- **[AGENTS.md](../AGENTS.md)** - Guía de agentes
- **[CONTRIBUTING.md](../CONTRIBUTING.md)** - Guía de contribución
- **[opencode.jsonc](../opencode.jsonc)** - Configuración central
- **[agents/docs/](../agents/docs/)** - Documentación de agentes

---

**Editado**: Jan 23, 2025  
**Mantenedor**: Equipo de Ingeniería de Contexto  
**Licencia**: Consultar repositorio principal
