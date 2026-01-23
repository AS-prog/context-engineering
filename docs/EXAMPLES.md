# 📚 Ejemplos de Workflows - Ingeniería de Contexto

**Versión**: 1.0  
**Última actualización**: Jan 23, 2025  
**Propósito**: Ejemplos reales y prácticos de cómo usar el sistema de agentes para resolver problemas comunes.

---

## 📋 Tabla de Contenidos

1. [Ejemplo 1: Email Validator](#ejemplo-1-email-validator)
2. [Ejemplo 2: Data Pipeline CSV→PostgreSQL](#ejemplo-2-data-pipeline-csvpostgresql)
3. [Ejemplo 3: REST API with FastAPI](#ejemplo-3-rest-api-with-fastapi)
4. [Ejemplo 4: Data Transformation](#ejemplo-4-data-transformation)
5. [Ejemplo 5: Database Schema Migration](#ejemplo-5-database-schema-migration)
6. [Ejemplo 6: CLI Tool con Click](#ejemplo-6-cli-tool-con-click)

---

## 🔑 Ejemplo 1: Email Validator

**Caso de Uso**: Crear un validador de emails reutilizable con Pydantic y tests.

**Complejidad**: ⭐⭐ (Básico)  
**Tiempo**: ~1 minuto  
**Agentes Usados**: git-manager, tdd-architect, python-coder

### Estructura Final
```
email-validator/
├── src/
│   ├── __init__.py
│   └── validators.py          # Email validator class
├── tests/
│   ├── __init__.py
│   └── test_validators.py      # Tests con TDD
├── .gitignore
└── README.md
```

### Prompt

```
@data-engineer

"Necesito crear un módulo validador de emails que:

REQUERIMIENTOS FUNCIONALES:
- Validar formato de email (debe tener @)
- Validar dominio válido (ej: ejemplo.com)
- Validar longitud máxima 254 caracteres
- Validar longitud mínima 5 caracteres
- Case-insensitive para emails
- Lanzar ValueError si no es válido

REQUERIMIENTOS TÉCNICOS:
- Usar Pydantic BaseModel con EmailStr
- Type hints en todas las funciones
- Docstrings en Google Style (español)
- PEP 8 compliance
- Tests con pytest cubriendo:
  * Happy path: email válido
  * Edge cases: mínimo/máximo longitud
  * Error cases: formato inválido, sin @

ESTRUCTURA:
- src/validators.py: Clase EmailValidator
- tests/test_validators.py: Suite de tests TDD

Incluir docstrings ESCENARIO/COMPORTAMIENTO/PROPÓSITO en cada test."
```

### Salida Esperada

```
═══════════════════════════════════════════════════════════════════
🤖 AGENTE: data-engineer | INVOCACIÓN INICIADA
📋 Tarea: Crear validador de emails con Pydantic
═══════════════════════════════════════════════════════════════════

[Análisis...]
Plan de ejecución:
1. Crear rama feature/email-validator
2. Diseñar tests (RED phase)
3. Implementar validador (GREEN phase)
4. Hacer commit

═══════════════════════════════════════════════════════════════════
🤖 AGENTE: git-manager | INVOCACIÓN INICIADA
📋 Tarea: Crear rama feature/email-validator
═══════════════════════════════════════════════════════════════════
[Crea rama...]
✅ AGENTE: git-manager | TAREA COMPLETADA
📦 Artefactos:
   - Rama feature/email-validator creada

═══════════════════════════════════════════════════════════════════
🤖 AGENTE: tdd-architect | INVOCACIÓN INICIADA
📋 Tarea: Diseñar tests para validador de emails
═══════════════════════════════════════════════════════════════════
[Crea tests...]
✅ AGENTE: tdd-architect | TAREA COMPLETADA
📦 Artefactos:
   - tests/test_validators.py

═══════════════════════════════════════════════════════════════════
🤖 AGENTE: python-coder | INVOCACIÓN INICIADA
📋 Tarea: Implementar validador de emails
═══════════════════════════════════════════════════════════════════
[Implementa...]
✅ AGENTE: python-coder | TAREA COMPLETADA
📦 Artefactos:
   - src/validators.py

═══════════════════════════════════════════════════════════════════
✅ AGENTE: data-engineer | WORKFLOW COMPLETADO
📦 Artefactos Finales:
   - src/validators.py (EmailValidator class)
   - tests/test_validators.py (5 tests)
   - Rama feature/email-validator
   - Commit feat: crear validador de emails con pydantic
═══════════════════════════════════════════════════════════════════
```

### Verificación

```bash
# Ver rama
git branch -a

# Correr tests
pytest tests/ -v
# Output: 5 passed in 0.50s

# Ver estructura
tree src tests

# Ver commits
git log --oneline -3
```

---

## 📊 Ejemplo 2: Data Pipeline CSV→PostgreSQL

**Caso de Uso**: Crear un pipeline que lee CSV y lo carga en PostgreSQL con validación.

**Complejidad**: ⭐⭐⭐⭐ (Avanzado)  
**Tiempo**: ~3-5 minutos  
**Agentes Usados**: git-manager, sql-specialist, tdd-architect, python-coder

### Estructura Final
```
csv-to-postgres/
├── src/
│   ├── __init__.py
│   ├── database.py            # PostgreSQL connection
│   ├── models.py              # Pydantic models
│   ├── pipeline.py            # ETL pipeline
│   └── config.py              # Configuration
├── tests/
│   ├── __init__.py
│   ├── test_models.py
│   └── test_pipeline.py
├── data/
│   └── sample.csv             # Datos de ejemplo
├── sql/
│   └── schema.sql             # Schema SQL
├── requirements.txt
└── README.md
```

### Prompt

```
@data-engineer

"Necesito crear un ETL pipeline CSV→PostgreSQL que:

REQUERIMIENTOS FUNCIONALES:
1. Leer CSV con estructura:
   - id (integer)
   - name (string)
   - email (string)
   - age (integer)
   - country (string)

2. Validar datos:
   - Email válido (regex o EmailStr)
   - Age entre 18-120
   - Name no vacío
   - Id único

3. Transformar:
   - Normalizar emails (minúsculas)
   - Validar datos con Pydantic
   - Manejo de filas inválidas (log + skip)

4. Cargar en PostgreSQL:
   - Crear tabla users
   - Insertar datos válidos
   - Transacciones
   - Rollback si hay error

REQUERIMIENTOS TÉCNICOS:
- src/database.py: PostgreSQL connection pool
- src/models.py: Pydantic models para validación
- src/pipeline.py: Main ETL logic
- sql/schema.sql: Schema SQL
- Type hints everywhere
- Docstrings Google Style
- PEP 8 compliant
- Tests cubriendo:
  * CSV reading
  * Validación Pydantic
  * Database insertion
  * Error handling

STACK:
- pandas para CSV
- sqlalchemy para DB
- pydantic para validación
- psycopg2 para PostgreSQL
- pytest para tests"
```

### Prompt Alternativo Simplificado

Si quieres dividirlo en pasos:

```
@data-engineer "Paso 1: Crear modelos Pydantic para usuario"
@data-engineer "Paso 2: Crear database.py con SQLAlchemy"
@data-engineer "Paso 3: Crear pipeline.py con lógica ETL"
@data-engineer "Paso 4: Crear tests para todo"
```

### Verificación

```bash
# Ver estructura
tree src sql tests

# Correr tests
pytest tests/ -v

# Probar pipeline con datos reales
python -c "
from src.pipeline import Pipeline
p = Pipeline('postgresql://user:pass@localhost/dbname')
results = p.run('data/sample.csv')
print(f'Loaded {results.success} rows')
"

# Verificar BD
psql -U user -d dbname -c "SELECT * FROM users;"
```

---

## 🌐 Ejemplo 3: REST API with FastAPI

**Caso de Uso**: Crear una REST API con FastAPI para gestionar usuarios.

**Complejidad**: ⭐⭐⭐⭐⭐ (Muy Avanzado)  
**Tiempo**: ~5-8 minutos  
**Agentes Usados**: Todos (git, sql, tdd, python)

### Estructura Final
```
user-api/
├── src/
│   ├── __init__.py
│   ├── main.py                 # FastAPI app
│   ├── models.py               # Pydantic models
│   ├── database.py             # DB config
│   ├── schemas.py              # API schemas
│   ├── api/
│   │   ├── __init__.py
│   │   └── users.py            # User endpoints
│   └── crud/
│       ├── __init__.py
│       └── users.py            # CRUD operations
├── tests/
│   ├── __init__.py
│   ├── conftest.py
│   ├── test_api_users.py
│   └── test_crud_users.py
├── requirements.txt
├── .env.example
└── README.md
```

### Prompt

```
@data-engineer

"Crear API REST con FastAPI para gestionar usuarios:

ENDPOINTS:
POST   /api/users           - Crear usuario
GET    /api/users           - Listar usuarios (con paginación)
GET    /api/users/{id}      - Obtener usuario
PUT    /api/users/{id}      - Actualizar usuario
DELETE /api/users/{id}      - Eliminar usuario

MODELOS:
User:
- id: integer
- email: string (único, valid email)
- name: string (1-100 chars)
- age: integer (18-120)
- is_active: boolean
- created_at: datetime
- updated_at: datetime

VALIDACIÓN:
- Email válido con EmailStr
- Nombre no vacío y min 3 chars
- Age dentro de rango
- Unique constraint en email
- Soft delete (is_active)

DOCUMENTACIÓN:
- OpenAPI/Swagger automático
- Type hints everywhere
- Docstrings detallados
- Response models con ejemplos

TESTS:
- Test cada endpoint
- Test validaciones
- Test edge cases
- Test errores (404, 422, 409)
- Min 85% coverage

STACK:
- FastAPI
- SQLAlchemy ORM
- Pydantic
- PostgreSQL
- pytest + TestClient
- python-dotenv para config"
```

### Verificación

```bash
# Instalar dependencias
pip install -r requirements.txt

# Correr servidor
uvicorn src.main:app --reload

# En otra terminal: correr tests
pytest tests/ -v --cov=src

# Acceder a docs
open http://localhost:8000/docs
```

---

## 🔄 Ejemplo 4: Data Transformation

**Caso de Uso**: Transformar datos de múltiples fuentes a formato estándar.

**Complejidad**: ⭐⭐⭐ (Intermedio)  
**Tiempo**: ~3 minutos  
**Agentes Usados**: git-manager, python-coder, tdd-architect

### Prompt

```
@data-engineer

"Crear module de transformación de datos que:

ENTRADA (3 formatos diferentes):
1. CSV plano: id,name,email,phone
2. JSON anidado: {users: [{id, name, contact: {email, phone}}]}
3. Excel sheets: Users sheet con columnas

SALIDA (Formato estándar):
User:
- user_id (integer)
- full_name (string, title case)
- email (string, lowercase)
- phone (string, formato internacional)
- source (string: csv|json|excel)
- processed_at (datetime)

TRANSFORMACIONES:
- Renombrar columnas (id → user_id, name → full_name)
- Normalizar formatos (emails lowercase, phones int'l format)
- Validar con Pydantic
- Agregar metadata (source, timestamp)
- Manejo de valores nulos
- Logging de errores

ESTRUCTURA:
- src/transformers.py: Clase base + implementations
- src/validators.py: Pydantic models
- tests/test_transformers.py: Tests para cada formato

REQUERIMIENTOS:
- Type hints completos
- Docstrings Google Style
- PEP 8
- 100% test coverage
- Manejar archivos corruptos gracefully"
```

---

## 🗄️ Ejemplo 5: Database Schema Migration

**Caso de Uso**: Diseñar y crear schema de base de datos desde cero.

**Complejidad**: ⭐⭐⭐⭐ (Avanzado)  
**Tiempo**: ~4 minutos  
**Agentes Usados**: sql-specialist, python-coder, tdd-architect

### Prompt

```
@data-engineer

"Diseñar schema SQL para e-commerce que:

ENTIDADES:
1. users:
   - id, email (unique), password, name, created_at, is_active

2. products:
   - id, sku (unique), name, description, price, stock, category_id

3. categories:
   - id, name (unique), description

4. orders:
   - id, user_id, created_at, status (pending|processing|shipped|delivered)

5. order_items:
   - id, order_id, product_id, quantity, price

REQUERIMIENTOS:
- Foreign keys con cascade
- Índices en búsquedas frecuentes
- Constraints de integridad
- Default values sensatos
- Timestamps (created_at, updated_at)
- Soft deletes donde sea apropiado

SALIDA:
1. sql/schema.sql: Schema con comentarios
2. src/database.py: SQLAlchemy models
3. src/migrations.py: Alembic migrations
4. tests/test_schema.py: Tests de integridad

VALIDACIONES A PROBAR:
- Foreign key constraints
- Unique constraints
- Check constraints (price > 0, stock >= 0)
- Indexes existen
- Relationships funcionan"
```

---

## 💻 Ejemplo 6: CLI Tool con Click

**Caso de Uso**: Crear herramienta CLI para procesar datos.

**Complejidad**: ⭐⭐⭐ (Intermedio)  
**Tiempo**: ~2-3 minutos  
**Agentes Usados**: git-manager, python-coder, tdd-architect

### Estructura Final
```
data-cli/
├── src/
│   ├── __init__.py
│   ├── cli.py                 # Click commands
│   ├── processors.py          # Business logic
│   └── utils.py               # Utilities
├── tests/
│   ├── __init__.py
│   ├── test_cli.py
│   └── test_processors.py
├── setup.py                   # Entry point
└── README.md
```

### Prompt

```
@data-engineer

"Crear CLI tool con Click para procesar archivos:

COMANDOS:
1. data validate <file>
   - Valida CSV contra schema
   - Output: ✅ Valid o ❌ Invalid + errores

2. data transform <input> <output>
   - Lee CSV, transforma, escribe CSV normalizado
   - Opciones: --format (json|csv|parquet)

3. data stats <file>
   - Estadísticas del archivo
   - Muestra: rows, columns, tipos, nulos

4. data merge <file1> <file2> <output>
   - Combina 2 archivos
   - Opción: --on <column> para join

REQUISITOS:
- Usar Click framework
- Commands con help text detallado
- Progress bars para archivos grandes
- Manejo de errores user-friendly
- Colores en output (verde=success, rojo=error)
- Logging a archivo opcional (--verbose)

ESTRUCTURA:
- src/cli.py: Click command groups
- src/processors.py: Lógica de procesamiento
- tests/test_cli.py: Tests con CliRunner
- setup.py: Entry point para instalación

INSTALACIÓN:
pip install -e .
data --help

TESTS:
- Cada comando testeable
- Test inputs inválidos
- Mock de archivos
- Verificar output messages"
```

---

## 🎯 Ejemplo 7: API de Recomendaciones (Avanzado)

**Caso de Uso**: Sistema de recomendaciones basado en historial del usuario.

**Complejidad**: ⭐⭐⭐⭐⭐ (Muy Avanzado)  
**Tiempo**: ~8-10 minutos  
**Agentes Usados**: Todos

### Prompt Resumido

```
@data-engineer

"Crear API de recomendaciones que:

1. Almacena interacciones del usuario (view, click, purchase)
2. Calcula similitud entre items (cosine similarity)
3. Genera recomendaciones personalizadas
4. Aprende con feedback (A/B testing)

ENDPOINTS:
- POST /interactions: Registrar interacción
- GET /recommendations/{user_id}: Get recomendaciones
- POST /feedback: Registrar feedback (helped/not-helpful)

MACHINE LEARNING:
- TF-IDF para descripción de items
- Cosine similarity entre vectores
- Collaborative filtering simple

TESTS:
- Test recomendaciones correctas
- Test feedback actualiza modelo
- Test cold-start problem (new user)

STACK:
- FastAPI
- Scikit-learn para ML
- PostgreSQL para datos
- Redis para caching"
```

---

## 📋 Checklist para Cualquier Workflow

**Antes de Invocar**:
- [ ] Especificación clara y detallada
- [ ] Dividir si es muy complejo
- [ ] Listar requisitos funcionales y técnicos
- [ ] Mencionar stack/dependencies

**Después de Completar**:
- [ ] Revisar estructura generada
- [ ] Correr tests localmente
- [ ] Revisar commits creados
- [ ] Revisar code quality (flake8, black, mypy)
- [ ] Revisar documentación generada

---

## 🚀 Tips para Mejores Resultados

1. **Ser Específico**: En lugar de "crear API", mencionar exactamente qué endpoints
2. **Dar Contexto**: "Para e-commerce de ropa" vs solo "crear API"
3. **Listar Requirements**: Funcionales y técnicos separados
4. **Especificar Stack**: "Usar FastAPI, SQLAlchemy, pytest"
5. **Dar Ejemplos**: Estructura deseada, ejemplos de entrada/salida
6. **Dividir si Necesario**: Mejor 3 workflows simples que 1 complejo

---

## 📞 Más Ejemplos?

Para más ejemplos, consulta:
- **[CONTRIBUTING.md](../CONTRIBUTING.md)** - Sección "Flujos de Trabajo"
- **[docs/PRUEBA_ORQUESTACION.md](./PRUEBA_ORQUESTACION.md)** - Email validator en detalle
- **[AGENTS.md](../AGENTS.md)** - Guía general

---

**Última actualización**: Jan 23, 2025  
**Versión**: 1.0
