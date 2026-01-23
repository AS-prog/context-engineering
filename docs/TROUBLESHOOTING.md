# 🆘 Guía de Troubleshooting - Ingeniería de Contexto

**Versión**: 1.0  
**Última actualización**: Jan 23, 2025  
**Propósito**: Resolver problemas comunes al usar el sistema de agentes.

---

## 📋 Tabla de Contenidos

1. [Problemas de Invocación](#problemas-de-invocación)
2. [Problemas de Ejecución](#problemas-de-ejecución)
3. [Problemas de Código Generado](#problemas-de-código-generado)
4. [Problemas de Git](#problemas-de-git)
5. [Problemas de Tests](#problemas-de-tests)
6. [Problemas de Configuración](#problemas-de-configuración)
7. [Debugging](#debugging)
8. [FAQ](#faq)

---

## 🚨 Problemas de Invocación

### Problema: "Agent not found" al invocar

**Síntoma**:
```
Error: Agent [agent-name] not found
```

**Causas Posibles**:
1. Agent no existe en `agents/` directory
2. Nombre incorrecto
3. Archivo .md está corrupto
4. OpenCode no ve el archivo

**Soluciones**:

```bash
# 1. Verificar que el archivo existe
ls -la agents/

# 2. Verificar el nombre exacto
# Debe coincidir con el nombre en opencode.jsonc
cat agents/[agent-name].md

# 3. Revisar opencode.jsonc
cat opencode.jsonc | grep agent-name

# 4. Si aún no funciona, limpiar caché de OpenCode
# En OpenCode: cmd+k, escribir: clear cache
```

**Ejemplo**: Si quieres invocar `@data-engineer`:
- ✅ El archivo debe ser: `agents/data-engineer.md`
- ✅ Debe estar en opencode.jsonc
- ✅ Debe tener `mode: primary`

---

### Problema: "Permission denied" al invocar subagent

**Síntoma**:
```
Error: Agent [agent-name] cannot invoke [subagent]
Permission denied in opencode.jsonc
```

**Causa**: El agente no tiene permiso en opencode.jsonc

**Solución**:
```jsonc
// En opencode.jsonc, agregar el subagent a can_invoke
"agents": {
  "data-engineer": {
    "can_invoke": [
      "git-manager",
      "new-subagent"  // ← Agregar aquí
    ]
  }
}
```

---

### Problema: No puedo invocar subagent directamente

**Síntoma**:
```
User: @git-manager "crear rama..."
Error: Cannot invoke subagent directly. Only PRIMARY agents can be invoked by user.
```

**Causa**: Solo PRIMARY agents pueden ser invocados por usuarios

**Solución**: Usa el orquestador principal
```
❌ @git-manager "crear rama feature/email-validator"
✅ @data-engineer "Necesito crear rama feature/email-validator"
```

---

## ⚙️ Problemas de Ejecución

### Problema: Agent se queda congelado

**Síntoma**:
- Agent inicia pero no termina
- No hay output después de 5+ minutos

**Causas Posibles**:
1. LLM está procesando algo muy largo
2. Agent entró en loop infinito
3. Esperando input del usuario (no debería)
4. Problema de conexión de red

**Soluciones**:
```bash
# 1. Cancelar la invocación
# En OpenCode: Ctrl+C

# 2. Revisar logs
# En OpenCode: Ver último prompt y respuesta

# 3. Simplificar el requerimiento
# Si es muy complejo, dividir en pasos más pequeños

# 4. Revisar conexión
# ping google.com
```

**Prevención**:
- Especificar requerimientos claros y concisos
- Dividir tareas muy grandes
- No pedir múltiples features a la vez

---

### Problema: Agent genera salida mal formateada

**Síntoma**:
```
🤖 AGENTE: git-manager | INVOCACIÓN INICIADA
[aquí debería haber trabajo pero no hay nada]
✅ AGENTE: git-manager | TAREA COMPLETADA
```

**Causa**: Agent no ejecutó el trabajo correctamente

**Solución**:
```bash
# 1. Revisar el prompt que enviaste
# ¿Fue claro y específico?

# 2. Revisar la salida completa en OpenCode
# A veces hay detalles en la mitad

# 3. Intentar de nuevo con especificación más clara
@data-engineer
"Necesito que hagas EXACTAMENTE esto:
1. [Paso 1 detallado]
2. [Paso 2 detallado]
3. [Paso 3 detallado]"
```

---

### Problema: Error de LLM durante ejecución

**Síntoma**:
```
LLMError: Rate limit exceeded
LLMError: Model overloaded
LLMError: Token limit exceeded
```

**Causas Posibles**:
1. Rate limiting de API
2. Servidor del LLM caído
3. Request muy largo (muchos tokens)
4. Demasiadas invocaciones simultáneas

**Soluciones**:
```bash
# 1. Esperar y reintentar
# Rate limiting: esperar 30-60 segundos

# 2. Simplificar el requerimiento
# Menos archivos, menos contexto

# 3. Verificar estado del servicio
# Revisar status del LLM provider

# 4. Dividir en múltiples invocaciones
# En lugar de 1 grande, hacer 3 más pequeñas
```

---

## 💻 Problemas de Código Generado

### Problema: Código no compila/funciona

**Síntoma**:
```bash
$ python src/validators.py
SyntaxError: invalid syntax at line 42
```

**Causa**: Agent generó código inválido

**Soluciones**:
```bash
# 1. Revisar la salida del agent
# ¿Hay error messages en los logs?

# 2. Ejecutar tests
pytest tests/ -v
# Los tests mostrarán dónde está el problema

# 3. Revisar el código generado
cat src/validators.py

# 4. Si es error PEP 8, limpiar
black src/

# 5. Si es error de tipo, revisar
mypy src/
```

**Cómo evitar**:
- Ser muy específico en el requerimiento
- Incluir ejemplos de uso esperado
- Mencionar restricciones (PEP 8, type hints, etc)

---

### Problema: Tests fallan después de generar

**Síntoma**:
```bash
$ pytest tests/
FAILED tests/test_validators.py::test_email_valid - AssertionError
```

**Causa**: Implementación no coincide con tests

**Soluciones**:
```bash
# 1. Ver cuál test falló
pytest tests/ -v

# 2. Revisar el test
cat tests/test_validators.py | grep -A 10 "def test_email_valid"

# 3. Revisar la implementación
cat src/validators.py

# 4. Identificar la diferencia
# Usualmente es algo en la lógica

# 5. Opción A: Pedir al agent que lo arregle
@python-coder
"Revisar src/validators.py
El test tests/test_validators.py::test_email_valid falla con:
[pegar el error específico]"

# Opción B: Arreglarlo manualmente y continuar
edit src/validators.py
git add . && git commit -m "fix: corregir validador de emails"
```

---

### Problema: Import errors en código generado

**Síntoma**:
```
ImportError: cannot import name 'validate_email' from 'src.validators'
ModuleNotFoundError: No module named 'pydantic'
```

**Causas**:
1. Función no existe o está mal nombrada
2. Dependencia no instalada
3. Ruta de import incorrecta

**Soluciones**:
```bash
# 1. Para ModuleNotFoundError
pip install pydantic pandas pytest

# 2. Para ImportError de tu código
# Revisar que la función existe
grep "def validate_email" src/validators.py

# 3. Revisar imports en el código
head -20 src/validators.py

# 4. Si falta archivo, pedir al agent que lo cree
@python-coder "Crear archivo src/validators.py con función validate_email"

# 5. Si falta __init__.py
touch src/__init__.py
touch tests/__init__.py
```

---

## 🔀 Problemas de Git

### Problema: "fatal: not a git repository"

**Síntoma**:
```
fatal: not a git repository (or any of the parent directories): .git
```

**Causa**: Agent no está en un directorio git

**Solución**:
```bash
# 1. Verificar que estás en repo
ls -la .git

# 2. Si no existe, crear repo
git init
git config user.email "you@example.com"
git config user.name "Your Name"

# 3. Hacer commit inicial
git add . && git commit -m "initial commit"

# 4. Intentar de nuevo
@data-engineer "..."
```

---

### Problema: "branch already exists"

**Síntoma**:
```
fatal: A branch named 'feature/email-validator' already exists.
```

**Causa**: Rama ya existe de una ejecución anterior

**Soluciones**:
```bash
# Opción 1: Usar rama existente
git checkout feature/email-validator

# Opción 2: Eliminar rama
git branch -D feature/email-validator
# Luego invocar agent de nuevo

# Opción 3: Usar nombre diferente
@data-engineer "... crear rama feature/email-validator-v2"
```

---

### Problema: "Permission denied" en git push

**Síntoma**:
```
Permission denied (publickey).
fatal: Could not read from remote repository.
```

**Causa**: SSH keys no configuradas

**Solución**:
```bash
# Este error solo ocurre si tries hacer push remoto
# Por defecto, agents no hacen push sin pedir

# Si necesitas push:
1. Configurar SSH keys
   ssh-keygen -t ed25519
   # Agregar public key a GitHub

2. Verificar conexión
   ssh -T git@github.com

3. Intentar de nuevo
```

---

### Problema: Unstaged changes bloquean operaciones

**Síntoma**:
```
error: Your local changes would be overwritten by merge
```

**Causa**: Cambios sin commitear cuando agent quiere cambiar rama

**Soluciones**:
```bash
# 1. Ver cambios
git status

# 2. Opción A: Stash (guardar temporalmente)
git stash
# Agent continúa
# Luego recuperar: git stash pop

# 3. Opción B: Commitear
git add .
git commit -m "wip: cambios temporales"
# Agent continúa

# 4. Opción C: Descartar (¡PELIGRO!)
git checkout -- .
```

---

## 🧪 Problemas de Tests

### Problema: "No tests found"

**Síntoma**:
```bash
$ pytest
ERROR: file not found: tests/
no tests ran
```

**Causa**: Directorio tests no existe

**Soluciones**:
```bash
# 1. Crear estructura
mkdir -p tests
touch tests/__init__.py

# 2. Verificar que agent creó los tests
ls -la tests/

# 3. Si nada, pedir al agent
@tdd-architect "Crear tests para validador de emails"

# 4. Verificar nombre de archivos
# Deben empezar con "test_"
ls tests/test_*.py
```

---

### Problema: Tests fallan por imports

**Síntoma**:
```
ModuleNotFoundError: No module named 'src'
ImportError: cannot import from src.validators
```

**Causa**: Python path incorrecta

**Soluciones**:
```bash
# 1. Verificar estructura
tree src tests

# 2. Asegurarse que __init__.py existe
touch src/__init__.py
touch tests/__init__.py

# 3. Correr desde raíz del proyecto
cd /ruta/al/proyecto
pytest

# 4. Si aún falla, agregar PYTHONPATH
export PYTHONPATH="${PYTHONPATH}:/ruta/al/proyecto"
pytest

# 5. O en el test mismo
import sys
sys.path.insert(0, '/ruta/al/proyecto')
```

---

### Problema: Test passes localmente pero falla en CI

**Síntoma**:
```
✅ Funciona: pytest en mi máquina
❌ Falla: pytest en GitHub Actions
```

**Causa**: Diferencias entre ambientes

**Soluciones**:
```bash
# 1. Revisar versiones
python --version
pytest --version

# 2. Usar requirements.txt
pip freeze > requirements.txt

# 3. Asegurarse que CI usa mismo env
cat .github/workflows/test.yml

# 4. Revisar diferencias en paths
# Usar rutas relativas, no absolutas

# 5. Ejecutar tests como lo hace CI
python -m pytest tests/
```

---

## ⚙️ Problemas de Configuración

### Problema: opencode.jsonc no se reconoce

**Síntoma**:
```
Error: Invalid opencode configuration
jsonc: unexpected token at line X
```

**Causa**: Sintaxis JSON inválida

**Soluciones**:
```bash
# 1. Validar JSON
python -m json.tool opencode.jsonc

# 2. Revisar sintaxis común
# ✅ Comas entre elementos
# ✅ Comillas alrededor de strings
# ✅ Brackets correctos
# ❌ Comentarios con // (JSONC style, pero algunos parsers no los soportan)

# 3. Ejemplos de errores comunes
❌ "agent": "git-manager",  // último elemento tiene coma
✅ "agent": "git-manager"   // último elemento sin coma

❌ 'agent': 'git-manager'   // comillas simples
✅ "agent": "git-manager"   // comillas dobles

# 4. Usar online validator
# Copiar contenido a: https://jsonlint.com/
```

---

### Problema: Agent no ve cambios en opencode.jsonc

**Síntoma**:
```
Error: Agent not found in configuration
(Pero ya agregué el agent)
```

**Causa**: OpenCode cachea la config

**Soluciones**:
```bash
# 1. Recargar OpenCode
# Ctrl+Shift+P > Reload Window

# 2. Limpiar caché
rm -rf ~/.opencode/cache/

# 3. Verificar que el archivo está guardado
cat opencode.jsonc | grep "agent-name"

# 4. Reiniciar OpenCode completamente
# Cerrar y abrir la aplicación
```

---

## 🔧 Debugging

### Técnica 1: Usar OpenCode Console

```
Ctrl+Shift+P → Open Console
O: cmd+K para ir a console
Ver último output completo
```

### Técnica 2: Revisar Agent Definition

```bash
# Ver exactamente qué dice el agent
cat agents/data-engineer.md | head -50

# Ver qué puede invocar
grep "can_invoke" opencode.jsonc
```

### Técnica 3: Simplificar el Requerimiento

**En lugar de**:
```
@data-engineer "Crear una aplicación web completa con auth, 
  validación de emails, almacenamiento en BD, API REST, 
  tests, documentación, y CI/CD"
```

**Haz**:
```
@data-engineer "Crear un validador de emails con tests"
```

Luego agrega complejidad paso a paso.

### Técnica 4: Usar Print Debugging

```bash
# En git-manager:
echo "🔍 Debugging: Rama actual"
git branch -v

# En python-coder:
print("DEBUG: type hints", type_hints)

# En sql-specialist:
EXPLAIN PLAN SELECT ...
```

### Técnica 5: Revisar Git History

```bash
# Ver qué cambios hizo
git log --oneline -10

# Ver diff específico
git diff HEAD~1

# Ver cambios por archivo
git diff HEAD -- src/
```

---

## ❓ FAQ

### P: ¿Cómo reinicio un workflow incompleto?

R: Los workflows son independientes. Puedes invocar de nuevo:
```
@data-engineer "Requerimiento..."
# Generará nuevas ramas, código, etc.
```

---

### P: ¿Puedo editar un agente mientras se ejecuta?

R: No es recomendado. Espera a que termine:
```
✅ Espera a que aparezca "TAREA COMPLETADA"
Luego puedes editar agents/[agent].md
```

---

### P: ¿Qué pasa si hay un error a mitad del workflow?

R: El agent detiene la ejecución. Opciones:
1. Arreglar el error manualmente
2. Pedir al agent que corrija específicamente esa parte
3. Comenzar de nuevo con requerimiento más específico

---

### P: ¿Por qué mi test no pasa pero se ve correcto?

R: Causas comunes:
- **Off-by-one**: Comparación de números
- **String case**: "Email" vs "email"
- **Float precision**: 0.1 + 0.2 != 0.3
- **DateTime**: Zonas horarias, microsegundos
- **Type mismatch**: int vs str

Usa `pytest -v` para ver detalles exactos.

---

### P: ¿Cómo reporto un bug?

R: En GitHub Issues:
```markdown
## Descripción
[Qué pasó]

## Pasos para Reproducir
1. Hice esto
2. Luego esto
3. Error apareció

## Error Exacto
[Copiar salida completa]

## Entorno
- OpenCode versión: X.X
- OS: macOS/Linux/Windows
- Python: 3.9+
```

---

### P: ¿Se puede paralelizar agentes?

R: Actualmente no. El flujo es secuencial por diseño.
- Pro: Predecible, controlable
- Con: Menos velocidad

Esto puede cambiar en arquitecturas futuras.

---

### P: ¿Cómo contribuyo un nuevo agent?

R: Ver [CONTRIBUTING.md](../CONTRIBUTING.md) sección "Agregar un Nuevo Subagent"

En resumen:
1. Crear `agents/new-agent.md`
2. Actualizar `opencode.jsonc`
3. Actualizar documentación
4. Crear PR

---

### P: ¿Hay logging de auditoría?

R: Sí, pero en git:
```bash
# Ver quién hizo qué
git log -p

# Ver cambios específicos
git show [commit-hash]

# Ver por agente
git log --grep="feat:"
```

---

## 📞 No Encontraste tu Problema?

1. **Revisa AGENTS.md**: Guía general
2. **Revisa docs/ARCHITECTURE.md**: Cómo funciona el sistema
3. **Revisa CONTRIBUTING.md**: Cómo usar el sistema
4. **Abre un GitHub Issue**: Con detalles exactos
5. **Revisa el último log**: Mucho info está ahí

---

**Editado**: Jan 23, 2025  
**Mantenedor**: Equipo de Ingeniería de Contexto
