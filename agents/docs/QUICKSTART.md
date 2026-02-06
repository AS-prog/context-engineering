# 🚀 Guía de Inicio Rápido - OpenCode Data Engineers

## ¿Por dónde empiezo?

### Opción 1: Flujo Completo (Recomendado)
Si tienes un **requerimiento de datos** (alto nivel):

```bash
# Invoca directamente al agente principal:
@data-engineer

# Proporciona tu requerimiento:
"Necesito crear un pipeline que lea archivos CSV, 
valide datos, transforme fechas y cargue en PostgreSQL"
```

**data-engineer** se encargará de:
1. ✅ Analizar tu requerimiento
2. ✅ Crear un plan detallado
3. ✅ Invocar git-manager para crear rama
4. ✅ Invocar tdd-architect para tests
5. ✅ Invocar python-coder para implementación
6. ✅ Validar toda la solución
7. ✅ Invocar git-manager para commit
8. ✅ Entregar solución completa

### Opción 2: Tareas Específicas

**Solo necesitas hacer un commit:**
```bash
@git-manager
"Hacer commit de cambios en el validador de datos"
```

**Solo necesitas código Python:**
```bash
@python-coder
"Implementar la función calculate_discount(price, quantity) 
que pase estos tests: ..."
```

**Solo necesitas diseñar tests:**
```bash
@tdd-architect
"Crear tests para un validador de emails que use Pydantic"
```

**Necesitas SQL:**
```bash
@sql-specialist
"Optimizar esta query lenta que tarda 30 segundos"
```

---

## 📋 Estructura de Agentes

```
AGENTES DISPONIBLES
│
├─ 🔴 data-engineer (Primary)
│  └─ Punto de entrada para requerimientos de alto nivel
│     Coordina todos los otros agentes
│
├─ 🟢 git-manager (Subagent)
│  └─ Gestión de ramas y commits
│
├─ 🔵 python-coder (Subagent)
│  └─ Implementación de código Python
│
├─ 🔍 sql-specialist (Subagent)
│  └─ Diseño y optimización de queries SQL
│
└─ 🟣 tdd-architect (Subagent)
   └─ Diseño de test suites TDD
```

---

## 🔄 Flujo Típico de Trabajo

### Paso 1: Requerimiento
```
Usuario: "Necesito validar que CSVs de ventas tengan datos válidos"
```

### Paso 2: data-engineer Analiza
```
Análisis:
  • Requerimiento: Validador de CSV
  • Complejidad: Media (validación + transformación)
  • Agentes: git-manager → tdd-architect → python-coder
  
Plan:
  1. Crear rama feature/csv-sales-validator
  2. Diseñar tests con tdd-architect
  3. Implementar con python-coder
  4. Commit con git-manager
```

### Paso 3: Ejecución
```
data-engineer invoca:
   → @git-manager: crear feature/csv-sales-validator
   → @tdd-architect: tests para validación
   → @python-coder: implementar validador
   → validación técnica
   → @git-manager: commit feat: add csv validator
```

### Paso 4: Entrega
```
✅ Código implementado y documentado
✅ 100% de tests pasando
✅ Cambios commiteados
✅ Listo para merge
```

---

## 💡 Ejemplos Rápidos

### Ejemplo 1: Pipeline de Ingesta
```
@data-engineer
"Crear un pipeline que lea datos de una API REST,
valide el esquema JSON, y cargue en un data warehouse.
Los datos incluyen timestamps que necesito convertir a ISO 8601."
```

### Ejemplo 2: Refactoring de Código
```
@data-engineer
"El pipeline actual tiene bajo rendimiento. 
Necesito refactorizar para mejorar velocidad sin romper tests."
```

### Ejemplo 3: Validador Multi-Fuente
```
@data-engineer
"Crear un validador que acepte datos de API, CSV y DB,
los unifique bajo un esquema común,
y registre errores sin frenar el proceso."
```

### Ejemplo 4: Solo Tests
```
@tdd-architect
"Diseña una suite de tests para un calculador de descuentos.
Debe validar casos: descuento válido, límite inferior,
límite superior, y cantidad mínima."
```

### Ejemplo 5: Solo Git
```
@git-manager
"Crear rama feature/add-logging y preparar un commit
con mensaje 'feat: add structured logging to pipeline'"
```

---## 🛠 Configuración de Herramientas

### data-engineer (Todas las herramientas)
```yaml
tools:
  read: true      # Leer código y documentación
  write: true     # Crear archivos nuevos
  edit: true      # Editar código existente
  bash: true      # Ejecutar comandos
  glob: true      # Buscar archivos
  grep: true      # Buscar en contenido
  webfetch: true  # Obtener info de URLs
  task: true      # Invocar otros agentes
```

### git-manager (Git + análisis)
```yaml
tools:
  read: true      # Leer archivos
  edit: true      # Editar cambios
  bash: true      # Ejecutar git (ask para push)
  glob: true
  grep: true
```

### python-coder (Desarrollo)
```yaml
tools:
  read: true
  write: true     # Crear archivos Python
  edit: true      # Editar código
  bash: true      # Ejecutar tests
  glob: true
  grep: true
```

### tdd-architect (Testing)
```yaml
tools:
  read: true
  write: true     # Crear archivos de test
  edit: true
  bash: true      # Ejecutar tests
  glob: true
  grep: true
```

---

## ✅ Checklist: Qué Proporcionar

Cuando invoques un agente, incluye:

- [ ] **Descripción clara del objetivo**
- [ ] **Contexto del problema** (qué, por qué)
- [ ] **Requisitos técnicos** (tecnología, estándares)
- [ ] **Entrada esperada** (tipos, formatos)
- [ ] **Salida esperada** (resultados deseados)
- [ ] **Restricciones** (si las hay)
- [ ] **Referencias** (código existente, docs)

**Ejemplo completo:**
```
@data-engineer

OBJETIVO: Crear validador de usuario

CONTEXTO: 
Necesitamos validar datos de usuario antes de persistencia
Fuente: API REST y CSV imports

REQUISITOS:
- Use Pydantic para tipado
- Español en docstrings, inglés en código
- PEP 8 compliance
- Tests con docstrings (ESCENARIO/COMPORTAMIENTO/PROPÓSITO)

ENTRADA: 
dict con {name, email, age}

SALIDA ESPERADA:
Usuario validado o ValidationError detallado

RESTRICCIONES:
- Email debe ser válido
- Edad mínima 18

REFERENCIAS:
- Repo: /path/to/repo
- Modelo existente: models.py:42
```

---

## 🧠 Skills de Brainstorming

Además de los agentes, el sistema incluye **skills especializados** para desarrollar ideas antes de la implementación.

### ¿Qué son?

Skills son módulos de contexto que facilitan un diálogo colaborativo para refinar ideas y explorar alternativas antes de ejecutar código.

### Skills Disponibles

**1. brainstorming-agnostico**
- **Uso**: Ideas abstractas, proyectos o conceptos
- **Proceso**: Diálogo iterativo → 2-3 enfoques → Diseño estructurado
- **Salida**: `$OBSIDIAN_VAULT_PATH/plans/YYYY-MM-DD-<topic>-design.md`

**2. brainstorming-codigo**  
- **Uso**: Diseño técnico antes de implementar
- **Proceso**: Contexto → Enfoques técnicos → Diseño validado
- **Salida**: `$OBSIDIAN_VAULT_PATH/plans/YYYY-MM-DD-<topic>-design.md`

### Configuración de OBSIDIAN_VAULT_PATH

Los skills escriben diseños en tu vault de Obsidian. Configura la variable de entorno:

**Linux/Mac:**
```bash
export OBSIDIAN_VAULT_PATH="/home/tu-usuario/obsidian-vault"
```

**Windows (PowerShell):**
```powershell
$env:OBSIDIAN_VAULT_PATH = "C:\Users\tu-usuario\obsidian-vault"
```

**Windows (CMD):**
```cmd
setx OBSIDIAN_VAULT_PATH "C:\Users\tu-usuario\obsidian-vault"
```

> **Fallback**: Si no está definida, guarda en `./docs/plans/`

---

## 🎯 Mejores Prácticas

### ✅ Haz
- Proporciona contexto completo
- Especifica claramente qué necesitas
- Incluye ejemplos si es posible
- Menciona estándares del proyecto
- Valida que el output cumple requisitos

### ❌ No Hagas
- Saltar pasos del protocolo
- Usar agentes sin especificación clara
- Permitir código sin tests
- Ignorar validaciones de esquema
- Commitear sin revisión técnica

---

## 📚 Documentación Completa

Para más detalles, consulta:
- `AGENTS_REFERENCE.md` - Documentación de todos los agentes
- `_template.md` - Plantilla para crear nuevos agentes
- Archivos individuales: `data-engineer.md`, `git-manager.md`, etc.

---

## 🆘 Soporte

**¿Preguntas sobre OpenCode?**
- Documentación: https://opencode.ai/docs
- Issues: https://github.com/anomalyco/opencode/issues

**¿Problemas con los agentes?**
- Verifica que el agente sea `primary` o `subagent` (no otro tipo)
- Comprueba que todas las herramientas necesarias estén habilitadas
- Revisa que el modelo especificado sea válido
- Consulta AGENTS_REFERENCE.md para ejemplos

