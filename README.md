# Ingeniería de Contexto

Centralizador de información de ingeniería de contexto para coordinación entre desarrolladores y agentes especializados.

## 📌 Descripción

Este repositorio organiza **agentes especializados** para ejecutar workflows completos de ingeniería de contexto, principalmente enfocado en:

- **Ingeniería de Datos**: Pipelines, transformaciones, validaciones
- **SQL**: Diseño, optimización y ejecución de queries
- **Testing**: Suites de pruebas con TDD
- **Control de Versiones**: Gestión de ramas y commits semánticos
- **Implementación Python**: Código limpio, tipado y con PEP 8

## 🤖 Agentes Disponibles

### Agentes de Ingeniería de Datos
- **data-engineer.md** - Orquestador principal (PRIMARY)
- **python-coder.md** - Implementación Python con PEP 8 (Subagent)
- **tdd-architect.md** - Diseño de test suites (Subagent)
- **sql-specialist.md** - Especialista SQL (Subagent)
- **git-manager.md** - Control de versiones (Subagent)

### Skills de Brainstorming
- **brainstorming-agnostico** - Desarrollo de ideas abstractas en diseños estructurados
- **brainstorming-codigo** - Exploración técnica antes de implementación

## 📚 Documentación

- **AGENTS.md** - Guía centralizada para todos los agentes
- **agents/docs/QUICKSTART.md** - Inicio en 5 minutos
- **agents/docs/AGENTS_REFERENCE.md** - Documentación completa
- **agents/docs/INDEX.md** - Índice de agentes
- **docs/PRUEBA_ORQUESTACION.md** - Guía para probar la orquestación de agentes

## ⚙️ Configuración

### Variable de Entorno para Skills de Brainstorming

Los skills de brainstorming requieren la variable `OBSIDIAN_VAULT_PATH` para escribir diseños en tu vault:

```bash
# Linux/Mac
export OBSIDIAN_VAULT_PATH="/ruta/a/tu/obsidian-vault"

# Windows (PowerShell)
$env:OBSIDIAN_VAULT_PATH = "C:\Users\tu-usuario\obsidian-vault"

# Windows (CMD)
setx OBSIDIAN_VAULT_PATH "C:\Users\tu-usuario\obsidian-vault"
```

> Si no está definida, los diseños se guardarán en `./docs/plans/`

## 🚀 Quick Start

```bash
# Lee la guía centralizada
cat AGENTS.md

# O accede a la documentación específica
cat agents/docs/QUICKSTART.md
```

## 🔄 Flujos de Trabajo Principales

### Flujo Completo (Recomendado)
```
Usuario → @data-engineer → análisis → git → tests → implementación → validación → commit
```

### Flujos Específicos
- **Solo implementación**: `@python-coder`
- **Solo tests**: `@tdd-architect`
- **Git y versionado**: `@git-manager`
- **SQL**: `@sql-specialist`

## 📖 Convenciones

### Commits Semánticos
- `feat:` - Nuevas características
- `fix:` - Correcciones de bugs
- `refactor:` - Cambios sin funcionalidad nueva
- `chore:` - Tareas auxiliares
- `docs:` - Documentación
- `test:` - Pruebas

### Code Style
- **Python**: PEP 8 (4 espacios, snake_case)
- **Type Hints**: Obligatorio en todas las funciones
- **Docstrings**: Google Style en español
- **Testing**: TDD con pytest

## ⚠️ Restricciones Críticas

- ✅ Verificar `git status` antes de operaciones críticas
- ✅ No commitear archivos sensibles (.env, credenciales)
- ✅ Incluir docstrings en funciones públicas
- ❌ Nunca force push sin consentimiento explícito
- ❌ Nunca saltarse validaciones de seguridad

## 📞 Contacto

**Mantenedor**: Equipo de Ingeniería de Contexto  
**Última actualización**: Jan 23, 2025

---

*Para más información, consulta [AGENTS.md](./AGENTS.md)*
