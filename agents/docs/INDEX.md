# 📚 Índice de Agentes OpenCode - Ingeniería de Datos

**Versión**: 1.0  
**Última actualización**: Feb 06, 2026  
**Ubicación**: `~/.config/opencode/agents/`

---

## 🎯 Inicio Rápido

### Por dónde empiezo?

**Tienes un requerimiento de datos:**
```bash
@data-engineer
"Tu requerimiento aquí"
```
⬆️ **Recomendado**: Usa `data-engineer` como punto de entrada.

### Documentos de Inicio
- 📖 **QUICKSTART.md** - Guía de inicio en 5 minutos
- 📋 **AGENTS_REFERENCE.md** - Documentación completa de agentes

---

## 🤖 Agentes Disponibles

### 1. ⭐ **data-engineer.md** (10K)
**Tipo**: Primary | **Modelo**: Claude Sonnet 3.5 | **Temp**: 0.3

**Quién es**: Ingeniero de Datos Senior  
**Qué hace**: Coordina flujos completos de ingeniería de datos  
**Cuándo usarlo**: Para cualquier requerimiento de datos (punto de entrada)

**Herramientas**: read, write, edit, bash, glob, grep, webfetch, task  
**Flujo**: Análisis → Git → Tests → Implementación → Validación → Commit

**Incluye**:
- 6 responsabilidades clave
- 9 fases de protocolo
- 3 ejemplos reales (Pipeline CSV, Validador, Refactoring)
- Reporte de progreso estructurado

---

### 2. 🔍 **sql-specialist.md** (7.8K)
**Tipo**: Subagent | **Modelo**: Claude Sonnet 3.5 | **Temp**: 0.1

**Quién es**: Especialista en SQL de Nivel Senior  
**Qué hace**: Diseña, optimiza y ejecuta queries de alta performance  
**Cuándo usarlo**: Invocado por data-engineer para cualquier trabajo relacionado con SQL

**Herramientas**: read, write, edit, bash, glob, grep

**Incluye**:
- Análisis y diseño de esquemas
- Optimización de queries
- EXPLAIN PLAN analysis
- Índices estratégicos
- 5 ejemplos reales (CTEs, optimización, migraciones, reportes, esquemas)

---

### 3. 🟢 **git-manager.md** (3.2K)
**Tipo**: Subagent | **Modelo**: Google Gemini 2.0 Flash | **Temp**: 0.1

**Quién es**: Especialista en Control de Versiones  
**Qué hace**: Gestiona ramas, commits semánticos  
**Cuándo usarlo**: Invocado por data-engineer para operaciones Git (crear ramas, commits, push)

**Herramientas**: read, edit, bash (ask), glob, grep  
**Especial**: Permisos granulares para git status/diff (allow)

---

### 4. 🔵 **python-coder.md** (3.4K)
**Tipo**: Subagent | **Modelo**: Google Gemini 2.5 Flash Lite | **Temp**: 0.1

**Quién es**: Desarrollador Senior de Python  
**Qué hace**: Implementa código Python conforme a PEP 8  
**Cuándo usarlo**: Invocado por data-engineer para implementar código basado en tests

**Herramientas**: read, write, edit, bash, glob, grep  
**Especial**: Código en inglés, docstrings en español

---

### 5. 🟣 **tdd-architect.md** (3.9K)
**Tipo**: Subagent | **Modelo**: Claude Sonnet 3.5 | **Temp**: 0.0

**Quién es**: Ingeniero de QA y Software Senior  
**Qué hace**: Diseña suites de pruebas con TDD  
**Cuándo usarlo**: Invocado por data-engineer para crear tests documentados (fase RED)

**Herramientas**: read, write, edit, bash, glob, grep  
**Especial**: Docstrings con ESCENARIO/COMPORTAMIENTO/PROPÓSITO

---

## 🧠 Skills de Brainstorming

### **brainstorming-agnostico** (4.2K)
**Tipo**: Skill | **Uso**: Desarrollo de ideas abstractas

**Cuándo usarlo**: Cuando tienes una idea abstracta, proyecto o concepto que necesita ser estructurado antes de implementarlo.

**Proceso**:
1. Comprensión profunda de la idea
2. Exploración de 2-3 enfoques distintos
3. Presentación incremental del diseño
4. Salida estandarizada usando plantilla

**Requiere**: Variable de entorno `OBSIDIAN_VAULT_PATH` (opcional, usa fallback local)

---

### **brainstorming-codigo** (4.5K)
**Tipo**: Skill | **Uso**: Diseño técnico antes de implementación

**Cuándo usarlo**: DEBE usarse antes de cualquier trabajo creativo - creación de funciones, componentes, funcionalidades o modificaciones.

**Proceso**:
1. Entender la idea técnica y contexto actual
2. Explorar 2-3 enfoques técnicos
3. Presentación fragmentada del diseño
4. Documentación del diseño validado

**Requiere**: Variable de entorno `OBSIDIAN_VAULT_PATH` (opcional, usa fallback local)

---

## 📚 Documentación de Referencia

### 6. **_template.md** (3.4K)
**Tipo**: Plantilla | **Uso**: Base para crear nuevos agentes

**Contiene**:
- Comentarios explicativos para cada campo
- Estructura estándar completa (frontmatter + 6 secciones)
- Instrucciones de uso

**Cómo usarlo**:
```bash
cp _template.md mi-agente.md
# Edita mi-agente.md según necesites
```

---

### 7. **AGENTS_REFERENCE.md** (7.8K)
**Tipo**: Documentación | **Uso**: Referencia completa

**Secciones**:
- Resumen de cambios y estandarización
- Detalles de cada agente
- Tabla comparativa de herramientas
- Temperatu ras y configuración
- Flujo de trabajo recomendado
- Estándares de documentación
- Cómo crear nuevos agentes
- Checklist

**Cuándo consultar**: Para entender diferencias entre agentes, configuración, o crear nuevos.

---

### 8. **QUICKSTART.md** (6.7K)
**Tipo**: Guía | **Uso**: Inicio rápido

**Secciones**:
- Por dónde empiezo
- Estructura de agentes
- Flujo típico (4 pasos)
- 5 ejemplos rápidos
- Configuración de herramientas
- Checklist de información
- Mejores prácticas
- Soporte

**Cuándo consultar**: Para entender cómo usar los agentes, ver ejemplos.

---

## 📊 Vista General

### Árbol de Archivos
```
context-engineering/
├── agents/
│   ├── 📘 data-engineer.md          ⭐ PUNTO DE ENTRADA
│   ├── 🔍 sql-specialist.md         Especialista SQL
│   ├── 📦 git-manager.md
│   ├── 🐍 python-coder.md
│   ├── 🧪 tdd-architect.md
│   ├── 📋 _template.md              (Plantilla para nuevos)
│   └── docs/
│       ├── 📚 AGENTS_REFERENCE.md       (Documentación actualizada)
│       ├── 🚀 QUICKSTART.md             (Guía rápida)
│       ├── ⚡ CHEATSHEET.md             (Referencia rápida)
│       └── 📑 INDEX.md                  (Este archivo)
│
├── skills/
│   ├── 🧠 brainstormig-agnostico/       (Skill para ideas abstractas)
│   │   ├── SKILL.md
│   │   └── brainstormig-agnostico-template.md
│   ├── 💡 brainstormig-codigo/          (Skill para diseño técnico)
│   │   ├── SKILL.md
│   │   └── brainstorming-code-template.md
│   └── ...                               (Otros skills)
│
└── docs/
    ├── ARCHITECTURE.md
    ├── EXAMPLES.md
    └── ...
```

### Estadísticas
- **Total de archivos**: ~25
- **Tamaño total**: ~80K
- **Agentes**: 5 (1 principal + 4 subagentes)
- **Skills**: 2+ (brainstorming agnóstico, brainstorming código)
- **Documentación**: 5+

---

## 🔄 Flujos de Trabajo

### Flujo 1: Completo (Recomendado)
```
Usuario → @data-engineer
         ↓
      Análisis
         ↓
   @git-manager (rama)
         ↓
   @tdd-architect (tests)
         ↓
   @python-coder (código)
         ↓
    Validación
         ↓
   @git-manager (commit)
         ↓
      Entrega
```

### Flujo 2: Especializado
```
Necesidad específica → Agente específico

Ejemplos:
- Git: @git-manager
- Código: @python-coder
- Tests: @tdd-architect
- SQL: @sql-specialist
```

### Flujo 3: Híbrido
```
@data-engineer (análisis)
         ↓
@python-coder (código específico)
         ↓
@data-engineer (validación final)
```

---

## 💡 Patrones de Uso

### Patrón 1: Requerimiento Nuevo
```
@data-engineer
"[Requerimiento de datos de alto nivel]"
```
→ data-engineer ejecuta flujo completo

### Patrón 2: Código Ya Existente
```
@data-engineer
"Necesito refactorizar [componente] 
para mejorar [aspecto] manteniendo [requisito]"
```
→ data-engineer analiza y coordina refactoring

### Patrón 3: Tarea Específica
```
@[agente-específico]
"[Descripción específica de tarea]"
```
→ Agente ejecuta solo esa responsabilidad

---

## ✅ Características Garantizadas

### En Todos los Agentes
- ✅ Frontmatter YAML estándar
- ✅ 6 secciones de contenido
- ✅ Ejemplos reales
- ✅ Límites y restricciones claros
- ✅ Lenguaje consistente
- ✅ Sin placeholders

### En data-engineer Específicamente
- ✅ Acceso a todas las herramientas
- ✅ Análisis integral de requisitos
- ✅ Coordinación de 4 agentes subagentes
- ✅ Validación de calidad técnica
- ✅ Reportes estructurados
- ✅ Mentoría de otros agentes

---

## 🛠 Herramientas por Agente

| **data-engineer** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| git-manager | ✅ | ❌ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| python-coder | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| sql-specialist | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| tdd-architect | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |

---

## 📖 Cómo Leer Este Índice

1. **¿Nuevo usuario?** → Empieza en QUICKSTART.md
2. **¿Necesitas un agente específico?** → Consulta la sección "Agentes Disponibles"
3. **¿Necesitas documentación completa?** → Ve a AGENTS_REFERENCE.md
4. **¿Quieres crear un nuevo agente?** → Usa _template.md como base
5. **¿Tienes un requerimiento?** → Invoca @data-engineer

---

## 🚀 Próximos Pasos

### Inmediatos
1. Lee QUICKSTART.md (5 minutos)
2. Invoca @data-engineer con tu primer requerimiento
3. Observa cómo coordina los agentes

### Futuro
1. Crea agentes personalizados usando _template.md
2. Extiende funcionalidad con MCP servers
3. Integra con tu pipeline de CI/CD

---

## 🆘 Soporte

**Documentación OpenCode**: https://opencode.ai/docs  
**GitHub Issues**: https://github.com/anomalyco/opencode/issues

**Problemas con agentes?**
- Verifica que mode sea `primary` o `subagent`
- Comprueba que las herramientas estén habilitadas
- Revisa que el modelo sea válido
- Consulta AGENTS_REFERENCE.md

---

## 📝 Control de Versiones

| Versión | Fecha | Cambios |
|---------|-------|---------|
| 1.1 | 2026-02-06 | Agregados skills de brainstorming + configuración OBSIDIAN_VAULT_PATH |
| 1.0 | 2025-01-22 | Creación inicial con data-engineer + documentación |

---

**✨ Todos los agentes están listos para usar. ¡Comienza con @data-engineer!**
