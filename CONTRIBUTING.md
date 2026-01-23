# 🤝 Guía de Contribución - Ingeniería de Contexto

Bienvenido a **Ingeniería de Contexto**. Esta guía te ayudará a entender cómo usar el sistema de agentes especializados y contribuir al proyecto.

---

## 📋 Tabla de Contenidos

1. [Antes de Empezar](#antes-de-empezar)
2. [Usando el Sistema de Agentes](#usando-el-sistema-de-agentes)
3. [Flujos de Trabajo](#flujos-de-trabajo)
4. [Estándares de Código](#estándares-de-código)
5. [Pruebas](#pruebas)
6. [Commits y Pull Requests](#commits-y-pull-requests)
7. [Reportar Problemas](#reportar-problemas)

---

## 🚀 Antes de Empezar

### Requisitos
- Acceso a OpenCode con Task tool capability
- Lectura de [AGENTS.md](./AGENTS.md) para entender la arquitectura
- Familiaridad con git y commits semánticos

### Setup Inicial
```bash
# 1. Clona el repositorio
git clone <repo-url>
cd context_engineering

# 2. Lee la documentación
cat AGENTS.md
cat agents/docs/QUICKSTART.md

# 3. Explora la estructura de agentes
ls -la agents/
```

---

## 🤖 Usando el Sistema de Agentes

### Arquitectura de Agentes

El sistema usa un patrón **1 Orquestador + N Subagentes**:

```
USER
  ↓
@data-engineer (PRIMARY - Orquestador)
  ├─ @git-manager (Subagent)
  ├─ @python-coder (Subagent)
  ├─ @tdd-architect (Subagent)
  └─ @sql-specialist (Subagent)
```

### Invocación

#### Flujo Completo (Recomendado)
Invoca el orquestador principal con una descripción clara:

```
@data-engineer
"Necesito crear un pipeline que:
- Lee datos de un CSV
- Valida campos con Pydantic
- Almacena en PostgreSQL
- Incluye tests con pytest
- Usa Type Hints y PEP 8"
```

El agente analizará tu requerimiento y orquestará automáticamente:
1. ✅ `@git-manager` - Crea rama feature/
2. ✅ `@tdd-architect` - Diseña test suite
3. ✅ `@python-coder` - Implementa código
4. ✅ `@sql-specialist` - Diseña esquema SQL
5. ✅ `@git-manager` - Hace commit semántico

#### Flujos Específicos
Si necesitas un agente específico:

```
# Solo implementación Python
@python-coder
"Implementa una función que..."

# Solo tests
@tdd-architect
"Crea tests para..."

# Solo SQL
@sql-specialist
"Diseña una query que..."

# Solo git/versionado
@git-manager
"Crea una rama para..."
```

---

## 🔄 Flujos de Trabajo

### Flujo 1: Solicitud Completa (Feature Workflow)

**Inicio**:
```
@data-engineer
"Descripción clara del requerimiento
- Especificación funcional
- Requisitos técnicos
- Restricciones o casos especiales"
```

**Observarás**:
```
═══════════════════════════════════════════════════
🤖 AGENTE: data-engineer | INVOCACIÓN INICIADA
📋 Tarea: Tu requerimiento
═══════════════════════════════════════════════════

[Análisis...]

═══════════════════════════════════════════════════
🤖 AGENTE: git-manager | INVOCACIÓN INICIADA
[Crea rama feature/...]
✅ AGENTE: git-manager | TAREA COMPLETADA

═══════════════════════════════════════════════════
🤖 AGENTE: tdd-architect | INVOCACIÓN INICIADA
[Crea tests...]
✅ AGENTE: tdd-architect | TAREA COMPLETADA

[Más agentes...]

═══════════════════════════════════════════════════
✅ AGENTE: data-engineer | WORKFLOW COMPLETADO
📦 Artefactos: lista de archivos generados
═══════════════════════════════════════════════════
```

**Verificación Local**:
```bash
# Ver rama creada
git branch -a

# Ver cambios
git diff main

# Correr tests
pytest tests/ -v

# Ver commits
git log --oneline -5
```

### Flujo 2: Trabajo Colaborativo

**Con tu compañero**:
1. ✅ Revisan requerimiento juntos
2. ✅ Definen especificación clara
3. ✅ Uno invoca `@data-engineer`
4. ✅ Observan orquestación en consola
5. ✅ Revisan artefactos generados
6. ✅ Hacen feedback/ajustes si es necesario

**Buenas Prácticas**:
- Especificar requerimientos claramente
- Esperar a que se complete un workflow antes de empezar otro
- Revisar la salida de consola para ver qué hizo cada agente
- Usar `git diff` para entender cambios antes de mergear

### Flujo 3: Testing de Agentes

Sigue [docs/PRUEBA_ORQUESTACION.md](./docs/PRUEBA_ORQUESTACION.md):

```bash
# 1. Crea un repo vacío para testing
mkdir email-validator-test
cd email-validator-test

# 2. Copia agents y config
cp -r ../agents .
cp ../opencode.jsonc .

# 3. Setup inicial
mkdir -p src tests
git init && git add . && git commit -m "initial"

# 4. Invoca agente
@data-engineer "Requerimiento de email validator..."

# 5. Verifica salida
pytest tests/ -v
git log --oneline
```

---

## 📝 Estándares de Código

### Python (PEP 8)

**Tipo Hints Obligatorios**:
```python
def process_data(
    df: pd.DataFrame,
    threshold: float,
    user_id: Optional[str] = None,
) -> Dict[str, List[int]]:
    """Procesa datos con umbral especificado."""
    pass
```

**Docstrings (Google Style)**:
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
    
    Example:
        >>> validate_email("user@example.com")
        True
    """
    pass
```

**Imports (Orden Correcta)**:
```python
# Stdlib
import os
from typing import Dict, List

# Third-party
import pandas as pd
from pydantic import BaseModel

# Local
from .validators import validate_email
```

**Validación con Pydantic**:
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

**Manejo de Errores**:
```python
import logging

logger = logging.getLogger(__name__)

try:
    result = risky_operation()
except ValueError as e:
    logger.error(f"Error de validación: {e}")
    raise
except Exception as e:
    logger.exception("Error inesperado")
    raise
```

### Naming Conventions

| Tipo | Convención | Ejemplo |
|------|-----------|---------|
| Variables | `snake_case` | `user_email`, `total_price` |
| Funciones | `snake_case` | `calculate_total()`, `validate_input()` |
| Clases | `PascalCase` | `UserValidator`, `DataProcessor` |
| Constantes | `SCREAMING_SNAKE_CASE` | `MAX_RETRIES`, `API_TIMEOUT` |
| Archivos | `snake_case` | `email_validator.py`, `data_processor.py` |
| Tests | `test_*.py` | `test_email_validator.py` |

---

## 🧪 Pruebas

### Convención de Tests (TDD)

Los tests creados por `@tdd-architect` siguen este formato:

```python
def test_validate_email_with_valid_format():
    """
    ESCENARIO: Email con formato válido y longitud correcta
    COMPORTAMIENTO: Debe retornar True
    PROPÓSITO: Validar que emails bien formados sean aceptados
    """
    # Arrange
    email = "user@example.com"
    
    # Act
    result = validate_email(email)
    
    # Assert
    assert result is True


def test_validate_email_with_invalid_format():
    """
    ESCENARIO: Email sin símbolo @
    COMPORTAMIENTO: Debe lanzar ValueError
    PROPÓSITO: Rechazar emails inválidos
    """
    # Arrange
    email = "userexample.com"
    
    # Act & Assert
    with pytest.raises(ValueError):
        validate_email(email)
```

### Correr Tests

```bash
# Todos los tests
pytest

# Tests específicos
pytest tests/test_email_validator.py::test_validate_email_with_valid_format

# Con cobertura
pytest --cov=src tests/

# Verbose
pytest -v

# Por patrón
pytest -k "email"
```

### Coverage Mínimo
- **Tests**: Mínimo 80% de cobertura
- **Funciones públicas**: 100% cobertura
- **Edge cases**: Casos de error cubiertos

---

## 📦 Commits y Pull Requests

### Commits Semánticos

El proyecto usa [Conventional Commits](https://www.conventionalcommits.org/):

```
feat:  Nuevas características
fix:   Correcciones de bugs
docs:  Cambios en documentación
test:  Adición de tests
refactor: Cambios sin funcionalidad nueva
chore: Tareas auxiliares
style: Cambios de formato (no afectan código)
perf:  Mejoras de rendimiento
```

### Ejemplos

```bash
# ✅ Bueno
git commit -m "feat: agregar validador de emails con pydantic"
git commit -m "fix: corregir cálculo de promedio en edge case"
git commit -m "test: aumentar cobertura a 90%"
git commit -m "docs: actualizar guía de contribución"

# ❌ Malo
git commit -m "updated code"
git commit -m "WIP"
git commit -m "fixed stuff"
```

### Pull Request Workflow

1. **Crear rama** (data-engineer lo hace automáticamente):
   ```bash
   git checkout -b feature/descripcion-clara
   ```

2. **Desarrollo y commits**:
   ```bash
   # Hacer cambios
   git add .
   git commit -m "type: descripción clara"
   ```

3. **Antes de push**:
   ```bash
   # Verificar tests locales
   pytest tests/ -v
   
   # Verificar estilo
   flake8 src/
   black --check src/
   
   # Verificar tipos
   mypy src/
   ```

4. **Push y PR**:
   ```bash
   git push origin feature/descripcion-clara
   # Crear PR en GitHub
   ```

5. **Code Review**:
   - Mínimo 1 aprobación
   - Tests deben pasar
   - Coverage debe estar > 80%

### Checklist de PR

- [ ] Descripción clara del cambio
- [ ] Tests añadidos/actualizados
- [ ] Docstrings en funciones públicas
- [ ] Type Hints en todas las funciones
- [ ] PEP 8 compliance
- [ ] Commits con mensaje semántico
- [ ] No hay archivos sensibles (.env, credentials)

---

## 🐛 Reportar Problemas

### Tipos de Issues

**Bug Report**:
```markdown
## Descripción
Descripción clara del problema

## Pasos para Reproducir
1. Paso 1
2. Paso 2
3. Paso 3

## Comportamiento Esperado
Qué debería pasar

## Comportamiento Actual
Qué está pasando

## Entorno
- OpenCode versión: X
- OS: macOS/Linux/Windows
- Python: 3.9+
```

**Feature Request**:
```markdown
## Descripción
Qué funcionalidad necesitas

## Caso de Uso
Por qué la necesitas

## Solución Propuesta
Cómo debería funcionar

## Alternativas
Otras formas de resolver esto
```

**Pregunta**:
- Usa GitHub Discussions si no es un bug/feature
- Consulta AGENTS.md antes de preguntar
- Revisa docs/TROUBLESHOOTING.md

---

## 🔗 Enlaces Útiles

- **[AGENTS.md](./AGENTS.md)** - Documentación completa de agentes
- **[docs/PRUEBA_ORQUESTACION.md](./docs/PRUEBA_ORQUESTACION.md)** - Testing guide
- **[agents/docs/QUICKSTART.md](./agents/docs/QUICKSTART.md)** - 5-min setup
- **[PEP 8 Style Guide](https://pep8.org/)**
- **[Conventional Commits](https://www.conventionalcommits.org/)**

---

## 💡 Tips y Mejores Prácticas

### ✅ Haz

- ✅ Especificar requerimientos claros y detallados
- ✅ Revisar la salida de consola del agente
- ✅ Usar `git diff` antes de mergear
- ✅ Escribir tests antes de código (TDD)
- ✅ Documentar funciones públicas
- ✅ Usar Type Hints en todo

### ❌ No Hagas

- ❌ Hacer fuerza push sin consentimiento
- ❌ Commitear archivos sensibles (.env, keys)
- ❌ Ignorar warnings de linter/mypy
- ❌ Escribir tests sin docstrings
- ❌ Saltarse validaciones de pydantic
- ❌ Hacer commits sin mensaje semántico

---

## 🤝 Código de Conducta

Este proyecto sigue los principios de:
- **Respeto**: Trata a todos con respeto
- **Colaboración**: Trabaja con otros para mejorar el código
- **Calidad**: Mantén altos estándares técnicos
- **Aprendizaje**: Comparte conocimiento y aprende de otros

---

## 📞 Contacto y Soporte

- **Documentación**: Ver [AGENTS.md](./AGENTS.md)
- **Issues**: Reporta en GitHub
- **Discussions**: Usa GitHub Discussions para preguntas
- **Pull Requests**: Contribuye código mejorando el proyecto

---

**Última actualización**: Jan 23, 2025  
**Versión**: 1.0
