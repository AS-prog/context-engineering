# 🤖 Ingeniería de Contexto - Guía para Agentes

**Versión**: 1.0  
**Última actualización**: Jan 22, 2025  
**Propósito**: Centralizador de información de ingeniería de contexto para coordinación entre desarrolladores y agentes.

---

## 📋 Tabla de Contenidos

1. [Visión General](#visión-general)
2. [Agentes Disponibles](#agentes-disponibles)
3. [Comandos Build/Test](#comandosbuildtest)
4. [Guía de Estilos de Código](#guía-de-estilos-de-código)
5. [Convenciones del Proyecto](#convenciones-del-proyecto)
6. [Flujos de Trabajo](#flujos-de-trabajo)

---

## 🎯 Visión General

Este repositorio organiza **agentes especializados** para ejecutar workflows completos de ingeniería de contexto en ingeniería de datos, SQL, control de versiones y testing.

**Estructura**:
```
agents/
├── data-engineer.md          # Orquestador principal (10K)
├── python-coder.md           # Implementación Python con PEP 8
├── tdd-architect.md          # Diseño de test suites
├── sql-specialist.md         # Optimización y diseño SQL
├── git-manager.md            # Control de versiones
├── data-maker.md             # Orquestación de pipelines
└── docs/
    ├── QUICKSTART.md         # Inicio en 5 minutos
    ├── AGENTS_REFERENCE.md   # Documentación completa
    └── INDEX.md              # Índice de agentes
```

---

## 🤖 Agentes Disponibles

### 1. **data-engineer.md** - Orquestador Principal
- **Tipo**: Primary Agent
- **Modelo**: Claude 3.5 Sonnet
- **Temperatura**: 0.3
- **Uso**: Punto de entrada para cualquier requerimiento de datos

**Responsabilidades**:
- Análisis integral de requerimientos
- Orquestación de git-manager, tdd-architect, python-coder
- Validación de calidad en cada fase
- Documentación y mentoría técnica

**Invocación**: `@data-engineer "Tu requerimiento aquí"`

---

### 2. **python-coder.md** - Implementación Python
- **Tipo**: Primary Agent
- **Modelo**: Gemini 2.5 Flash
- **Temperatura**: 0.1
- **Uso**: Implementación de código Python con PEP 8

**Estándares**:
- Type Hints en todas las funciones
- Docstrings Google Style (español)
- PEP 8 (4 espacios, snake_case, máx 79 chars)
- Pydantic/Typing para validación

**Invocación**: `@python-coder "Tu especificación aquí"`

---

### 3. **tdd-architect.md** - Diseño de Tests
- **Tipo**: Subagent
- **Modelo**: Claude 3.5 Sonnet
- **Temperatura**: 0.0
- **Uso**: Crear test suites con documentación detallada

**Protocolo TDD**:
1. Análisis de requisitos
2. Identificación de casos (happy path, edge cases, errores)
3. Codificación en fase RED (tests que fallan)
4. Docstrings detallados: ESCENARIO/COMPORTAMIENTO/PROPÓSITO

**Invocación**: `@tdd-architect "Tu especificación aquí"`

---

### 4. **sql-specialist.md** - Especialista SQL
- **Tipo**: Primary Agent
- **Modelo**: Claude 3.5 Sonnet
- **Temperatura**: 0.1
- **Uso**: Diseño, optimización y ejecución SQL

**Responsabilidades**:
- Diseño de esquemas y índices
- Optimización de queries (EXPLAIN PLAN)
- CTEs, agregaciones, joins complejos
- Documentación de lógica SQL

**Invocación**: `@sql-specialist "Tu consulta o diseño aquí"`

---

### 5. **git-manager.md** - Control de Versiones
- **Tipo**: Primary Agent
- **Modelo**: Gemini 2.0 Flash
- **Temperatura**: 0.1
- **Uso**: Gestión de ramas, commits semánticos

**Convenciones de Commits**:
- `feat:` - Nuevas características
- `fix:` - Correcciones de bugs
- `refactor:` - Cambios sin funcionalidad nueva
- `chore:` - Tareas auxiliares
- `docs:` - Documentación

**Invocación**: `@git-manager "Tu tarea de Git aquí"`

---

### 6. **data-maker.md** - Orquestador de Pipelines
- **Tipo**: Primary Agent
- **Modelo**: Claude 3.5 Sonnet
- **Temperatura**: 0.2
- **Uso**: Coordinar múltiples pipelines complejos

**Responsabilidades**:
- Desglose de tareas complejas
- Coordinación entre git-manager, tdd-architect, python-coder
- Validación técnica de calidad
- Supervisión de fases

**Invocación**: `@data-maker "Tu requerimiento complejo aquí"`

---

## 💻 Comandos Build/Test

### Para Correr Tests (Python)

```bash
# Tests completos en el proyecto
pytest

# Test específico
pytest tests/test_module.py::test_function_name

# Tests con cobertura
pytest --cov=src tests/

# Tests en modo verbose
pytest -v

# Tests que coincidan con patrón
pytest -k "pattern_name"
```

### Para Linting y Formato

```bash
# Verificar PEP 8
flake8 src/

# Formato automático
black src/

# Type checking
mypy src/
```

### Para Verificaciones Locales

```bash
# Estado de Git
git status

# Revisar cambios antes de commit
git diff

# Ver historial
git log --oneline -10
```

---

## 📝 Guía de Estilos de Código

### Python (PEP 8)

#### Imports
```python
# Orden: stdlib, third-party, local
import os
import sys
from typing import Dict, List, Optional

import pandas as pd
from pydantic import BaseModel

from .local_module import local_function
```

#### Nombres de Variables
```python
# ✅ Bueno
user_email = "user@example.com"
calculate_total_price()
MAX_RETRY_ATTEMPTS = 3

# ❌ Malo
userEmail = "user@example.com"
CalculateTotalPrice()
max_retry_attempts = 3  # Para constantes usar MAYUSCULA
```

#### Type Hints
```python
def process_data(
    df: pd.DataFrame,
    threshold: float,
) -> Dict[str, List[int]]:
    """
    Procesa datos con umbral especificado.
    
    Args:
        df: DataFrame con datos a procesar
        threshold: Valor mínimo para filtrado
    
    Returns:
        Diccionario con resultados por categoría
    """
    pass
```

#### Docstrings (Google Style)
```python
def validate_email(email: str) -> bool:
    """
    Valida formato de email.
    
    Args:
        email: Dirección de email a validar
    
    Returns:
        True si es válido, False en caso contrario
    
    Raises:
        ValueError: Si email es None o vacío
    """
    pass
```

#### Manejo de Errores
```python
# ✅ Bueno
try:
    result = risky_operation()
except ValueError as e:
    logger.error(f"Error de validación: {e}")
    raise

# ❌ Malo
try:
    result = risky_operation()
except:  # Demasiado genérico
    pass
```

### Validación con Pydantic
```python
from pydantic import BaseModel, EmailStr, validator

class User(BaseModel):
    """Modelo de usuario con validación automática."""
    
    email: EmailStr
    age: int
    
    @validator('age')
    def age_must_be_positive(cls, v):
        if v < 0:
            raise ValueError('Edad no puede ser negativa')
        return v
```

---

## 🎯 Convenciones del Proyecto

### Estructura de Directorios
```
project/
├── src/              # Código fuente
├── tests/            # Tests con pytest
├── docs/             # Documentación
├── agents/           # Definiciones de agentes
└── AGENTS.md         # Este archivo
```

### Nombres de Archivos
```
# Módulos Python
data_processor.py    # snake_case

# Tests
test_data_processor.py  # test_ prefijo

# Documentación
AGENTS.md, README.md  # MAYUSCULA para docs principales
```

### Estructura de Commits
```
feat: agregar validador de datos con pydantic
fix: corregir cálculo de descuento en edge case
refactor: simplificar lógica de transformación
test: aumentar cobertura a 95%
docs: actualizar guía de contribución
```

---

## 🔄 Flujos de Trabajo

### Flujo 1: Requerimiento Completo (Recomendado)
```
Usuario → @data-engineer
  ↓
1. Análisis de requerimiento
2. @git-manager: crear rama feature/
3. @tdd-architect: crear tests
4. @python-coder: implementación
5. Validación de calidad
6. @git-manager: commit semántico
7. Entrega final
```

### Flujo 2: Solo Implementación
```
Usuario → @python-coder
  ↓
1. Recibir especificación y tests
2. Implementar código
3. Validar que tests pasen
4. Retornar código implementado
```

### Flujo 3: Solo Tests
```
Usuario → @tdd-architect
  ↓
1. Analizar requerimiento
2. Crear casos de prueba
3. Escribir tests (fase RED)
4. Retornar suite de tests
```

### Flujo 4: Git y Versionado
```
Usuario → @git-manager
  ↓
1. Verificar estado (git status)
2. Revisar cambios (git diff)
3. Crear rama o commit
4. Mensaje semántico
5. Sincronizar con remoto
```

---

## ⚠️ Restricciones Críticas

### Para Todos los Agentes
- ✅ Verificar `git status` antes de operaciones críticas
- ✅ No commitear archivos sensibles (.env, credenciales)
- ✅ Seguir convenciones de nombres del proyecto
- ✅ Incluir docstrings en funciones públicas
- ❌ Nunca hacer force push sin consentimiento explícito
- ❌ Nunca saltarse validaciones de seguridad
- ❌ Nunca modificar tests para que "pasen" sin corregir código

### Para Python
- ✅ Type Hints en todas las funciones
- ✅ PEP 8 compliance (4 espacios, 79 chars max)
- ✅ Docstrings Google Style
- ❌ Nunca usar print() en producción (usar logger)
- ❌ Nunca variables en español en código (español en docs)
- ❌ Nunca ignorar warnings de linter/type checker

### Para Tests
- ✅ Crear tests antes de código (TDD)
- ✅ Incluir docstring ESCENARIO/COMPORTAMIENTO/PROPÓSITO
- ✅ Cubrir happy path, edge cases, errores
- ❌ Nunca escribir tests sin docstrings
- ❌ Nunca implementar lógica en tests
- ❌ Nunca saltarse casos de error

---

## 📚 Referencias Útiles

- **Documentación Completa**: `agents/docs/AGENTS_REFERENCE.md`
- **Inicio Rápido**: `agents/docs/QUICKSTART.md`
- **Índice de Agentes**: `agents/docs/INDEX.md`
- **PEP 8 Guide**: https://pep8.org/
- **Google Python Style Guide**: https://google.github.io/styleguide/pyguide.html

---

## 🚀 Quick Start

### Para Usuarios Nuevos
```bash
# 1. Leer guía de inicio
cat agents/docs/QUICKSTART.md

# 2. Invoca el agente principal con tu requerimiento
@data-engineer "Necesito crear un pipeline CSV → PostgreSQL"

# 3. El agente coordinará todo el workflow
```

### Para Agentes
```
1. Lee este archivo (AGENTS.md) completo
2. Revisa tu descripción específica en agents/
3. Sigue tu protocolo definido en la sección "3. Protocolo de Trabajo"
4. Consulta AGENTS_REFERENCE.md para clarificaciones
```

---

**Editado**: Jan 22, 2025  
**Mantenedor**: Equipo de Ingeniería de Contexto  
**Licencia**: Consultar repositorio principal
