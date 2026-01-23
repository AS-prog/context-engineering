# 🧪 Prueba de Orquestación de Agentes

**Objetivo**: Validar que `data-engineer` orquesta correctamente los 4 subagentes y rastrear la ejecución de cada uno.

---

## 📋 Preparación

### Paso 1: Crear Repo Vacío

```bash
mkdir email-validator-test
cd email-validator-test
git init
```

### Paso 2: Copiar Archivos de Configuración

Desde el repo `context_engineering`, copia:

```bash
# Copia la estructura de agentes
cp -r <REPO_ACTUAL>/agents/ ./

# Copia configuración de OpenCode
cp <REPO_ACTUAL>/opencode.jsonc ./

# Copia guía principal
cp <REPO_ACTUAL>/AGENTS.md ./
```

### Paso 3: Crear Estructura Básica del Proyecto

```bash
# Crear directorios
mkdir -p src tests

# Crear archivos iniciales
touch src/__init__.py
touch tests/__init__.py
touch tests/conftest.py

# Crear requirements.txt
cat > requirements.txt << 'EOF'
pydantic>=2.0
pytest>=7.0
pytest-cov>=4.0
EOF
```

### Paso 4: Crear .gitignore

```bash
cat > .gitignore << 'EOF'
__pycache__/
*.pyc
*.pyo
*.pyd
.pytest_cache/
*.db
.env
.venv/
venv/
*.egg-info/
dist/
build/
EOF
```

### Paso 5: Hacer Commit Inicial

```bash
git add -A
git commit -m "chore: initial project structure for agent orchestration test"
```

---

## 🚀 Ejecutar Prueba

### Paso 1: Abrir OpenCode

Abre OpenCode en el directorio `email-validator-test`:

```bash
# En el terminal
cd email-validator-test
opencode
# O simplemente abre el directorio en OpenCode
```

### Paso 2: Ejecutar data-engineer

En OpenCode, copia y pega exactamente:

```
@data-engineer

Crear una función validadora de emails con Pydantic que:
- Valide formato de email (debe contener @ y al menos un punto en el dominio)
- Valide longitud mínima de 5 caracteres
- Almacene emails válidos en una tabla SQLite
- Incluya tests con docstrings ESCENARIO/COMPORTAMIENTO/PROPÓSITO
- Siga PEP 8 y use Type Hints en todas las funciones
```

---

## 📊 Qué Observar

### Flujo de Orquestación Esperado

Deberías ver en la consola de OpenCode algo como:

```
═══════════════════════════════════════════════════════════════════
🤖 AGENTE: data-engineer | INVOCACIÓN INICIADA
───────────────────────────────────────────────────────────────────
📋 Tarea recibida: Crear función validadora de emails
⏱️ Timestamp: [hora actual]
═══════════════════════════════════════════════════════════════════

REPORTE DE INGENIERÍA DE DATOS
═══════════════════════════════════════════════════════════════════

PROYECTO: Email Validator
ESTADO: en progreso

ANÁLISIS INICIAL
  • Objetivo: Validador de emails con Pydantic + SQLite
  • Complejidad: media
  • Agentes involucrados: [@git-manager, @tdd-architect, @python-coder, @sql-specialist]
  
PLAN DE EJECUCIÓN
  1. Crear rama feature/email-validator
  2. Diseñar tests TDD
  3. Diseñar esquema SQLite
  4. Implementar código
  5. Validación
  6. Commit semántico

INVOCACIONES DE SUBAGENTES
  ├─ @git-manager: ⏳ En progreso
  ├─ @tdd-architect: ⏳ Pendiente
  ├─ @python-coder: ⏳ Pendiente
  ├─ @sql-specialist: ⏳ Pendiente
  └─ @git-manager: ⏳ Pendiente

─────────────────────────────────────────────────────────────────

═══════════════════════════════════════════════════════════════════
🤖 AGENTE: git-manager | INVOCACIÓN INICIADA
───────────────────────────────────────────────────────────────────
📋 Tarea recibida: Crear rama feature/email-validator
⏱️ Timestamp: [hora actual]
═══════════════════════════════════════════════════════════════════

Cambios de Git:
- Rama actual: feature/email-validator
- Estado: rama creada exitosamente

═══════════════════════════════════════════════════════════════════
✅ AGENTE: git-manager | TAREA COMPLETADA
───────────────────────────────────────────────────────────────────
📦 Artefactos generados:
  - Rama: feature/email-validator ✅
═══════════════════════════════════════════════════════════════════

─────────────────────────────────────────────────────────────────

═══════════════════════════════════════════════════════════════════
🤖 AGENTE: sql-specialist | INVOCACIÓN INICIADA
───────────────────────────────────────────────────────────────────
📋 Tarea recibida: Diseñar esquema SQLite para emails válidos
⏱️ Timestamp: [hora actual]
═══════════════════════════════════════════════════════════════════

DISEÑO DE ESQUEMA
CREATE TABLE emails (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT NOT NULL UNIQUE,
    is_valid BOOLEAN NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT email_format CHECK (email LIKE '%@%.%')
);

CREATE INDEX idx_emails_valid ON emails(is_valid);
CREATE INDEX idx_emails_created ON emails(created_at);

═══════════════════════════════════════════════════════════════════
✅ AGENTE: sql-specialist | TAREA COMPLETADA
───────────────────────────────────────────────────────────────────
📦 Artefactos generados:
  - Esquema: CREATE TABLE emails ✅
  - Índices: idx_emails_valid, idx_emails_created ✅
═══════════════════════════════════════════════════════════════════

─────────────────────────────────────────────────────────────────

═══════════════════════════════════════════════════════════════════
🤖 AGENTE: tdd-architect | INVOCACIÓN INICIADA
───────────────────────────────────────────────────────────────────
📋 Tarea recibida: Crear tests para validador de emails
⏱️ Timestamp: [hora actual]
═══════════════════════════════════════════════════════════════════

Suite de Tests - Fase RED
- test_valid_email_format: ❌ (falla como se espera)
- test_invalid_email_format: ❌ (falla como se espera)
- test_email_min_length: ❌ (falla como se espera)
- test_email_storage: ❌ (falla como se espera)
- test_duplicate_email: ❌ (falla como se espera)

═══════════════════════════════════════════════════════════════════
✅ AGENTE: tdd-architect | TAREA COMPLETADA
───────────────────────────────────────────────────────────────────
📦 Artefactos generados:
  - Archivo: tests/test_email_validator.py ✅
  - Total de tests: 5 ✅
  - Estado: Todos en fase RED ✅
═══════════════════════════════════════════════════════════════════

─────────────────────────────────────────────────────────────────

═══════════════════════════════════════════════════════════════════
🤖 AGENTE: python-coder | INVOCACIÓN INICIADA
───────────────────────────────────────────────────────────────────
📋 Tarea recibida: Implementar validador que pase los tests
⏱️ Timestamp: [hora actual]
═══════════════════════════════════════════════════════════════════

Ejecución de Tests - Fase GREEN
- test_valid_email_format: ✅ PASANDO
- test_invalid_email_format: ✅ PASANDO
- test_email_min_length: ✅ PASANDO
- test_email_storage: ✅ PASANDO
- test_duplicate_email: ✅ PASANDO

Cobertura de Código: 100% ✅
PEP 8 Compliance: Conforme ✅
Type Hints: Completos ✅

═══════════════════════════════════════════════════════════════════
✅ AGENTE: python-coder | TAREA COMPLETADA
───────────────────────────────────────────────────────────────────
📦 Artefactos generados:
  - Archivo: src/email_validator.py ✅
  - Archivo: src/database.py ✅
  - Tests pasando: 5/5 ✅
═══════════════════════════════════════════════════════════════════

─────────────────────────────────────────────────────────────────

═══════════════════════════════════════════════════════════════════
🤖 AGENTE: git-manager | INVOCACIÓN INICIADA
───────────────────────────────────────────────────────────────────
📋 Tarea recibida: Hacer commit semántico de cambios
⏱️ Timestamp: [hora actual]
═══════════════════════════════════════════════════════════════════

Cambios de Git:
- Rama actual: feature/email-validator
- Cambios detectados: 4 archivos
- Mensaje de commit: feat: add email validator with pydantic and sqlite

═══════════════════════════════════════════════════════════════════
✅ AGENTE: git-manager | TAREA COMPLETADA
───────────────────────────────────────────────────────────────────
📦 Artefactos generados:
  - Commit: abc1234 - feat: add email validator... ✅
═══════════════════════════════════════════════════════════════════

─────────────────────────────────────────────────────────────────

═══════════════════════════════════════════════════════════════════
✅ AGENTE: data-engineer | WORKFLOW COMPLETADO
───────────────────────────────────────────────────────────────────
📦 Artefactos finales generados:
  - src/email_validator.py
  - src/database.py
  - tests/test_email_validator.py
  - Branch: feature/email-validator
  - Commit: feat: add email validator with pydantic and sqlite
⏱️ Duración total: ~3-5 minutos
═══════════════════════════════════════════════════════════════════
```

---

## ✅ Verificación de Resultados

### Verificar Rama Creada

```bash
git branch -a
# Deberías ver:
# * main
#   feature/email-validator
```

### Verificar Archivos Generados

```bash
find src tests -name "*.py" -type f
# Deberías ver:
# src/__init__.py
# src/email_validator.py
# src/database.py
# tests/__init__.py
# tests/test_email_validator.py
```

### Verificar Tests Pasan

```bash
pytest tests/ -v
# Deberías ver:
# test_valid_email_format PASSED
# test_invalid_email_format PASSED
# test_email_min_length PASSED
# test_email_storage PASSED
# test_duplicate_email PASSED
```

### Verificar Commit

```bash
git log --oneline
# Deberías ver:
# abc1234 feat: add email validator with pydantic and sqlite
# def5678 chore: initial project structure for agent orchestration test
```

### Verificar Contenido de Archivos

```bash
# Ver la estructura del validador
cat src/email_validator.py

# Ver los tests
cat tests/test_email_validator.py

# Ver la DB connection
cat src/database.py
```

---

## 📈 Métricas de Éxito

| Métrica | Esperado | Validación |
|---------|----------|-----------|
| **Agentes invocados** | 4 subagentes | ✅ git-manager, tdd-architect, python-coder, sql-specialist |
| **Tests pasando** | 5/5 | ✅ `pytest tests/ -v` |
| **Cobertura** | 100% | ✅ `pytest --cov=src tests/` |
| **Rama creada** | feature/email-validator | ✅ `git branch` |
| **Commit hecho** | feat: add email validator... | ✅ `git log` |
| **Archivos generados** | 3 módulos Python | ✅ src/email_validator.py, src/database.py, tests/test_*.py |

---

## 🔍 Troubleshooting

### Si no ves los logs de agentes:

1. Verifica que OpenCode esté ejecutando los agentes correctamente
2. Revisa la consola de OpenCode para mensajes de error
3. Asegúrate de que los archivos de agentes estén en `./agents/`

### Si los tests fallan:

1. Verifica que python-coder esté implementando las funciones correctamente
2. Revisa el error en la salida de pytest
3. Confirma que tdd-architect haya creado los tests primero

### Si no se crea la rama:

1. Verifica que git-manager tenga permisos correctos en opencode.jsonc
2. Revisa que la rama no exista ya
3. Confirma que estés en un repositorio Git válido

---

## 📝 Notas

- La prueba está diseñada para ser **portable**: funciona en cualquier directorio vacío
- Los **agentes imprimen logs** claramente para rastrear la ejecución
- El **flujo es orchestrado**: data-engineer controla el orden de invocación
- Los **artefactos son reales**: archivos Python, tests, commits Git

---

## 🎯 Próximos Pasos (Opcional)

Después de validar la orquestación, puedes:

1. Modificar el requerimiento y observar cómo cambia el flujo
2. Probar con diferentes tipos de componentes (API, reportes, etc.)
3. Rastrear el uso de subagentes especializados (ej: usar sql-specialist para queries complejas)
4. Extender los agentes con logging personalizado

---

**¡Listo para rastrear la orquestación de agentes!** 🚀
