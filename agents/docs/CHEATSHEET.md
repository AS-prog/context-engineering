# ⚡ Referencia Rápida - OpenCode Data Engineers

**Ubicación**: `~/.config/opencode/agents/`  
**Total**: 9 archivos | 56K de documentación

---

## 🚀 Comienza Aquí

```bash
@data-engineer
"Tu requerimiento de datos"
```

**Data-engineer**:
- ✅ Analiza tu requerimiento
- ✅ Coordina git-manager, tdd-architect, python-coder
- ✅ Valida calidad
- ✅ Entrega solución completa

---

## 📚 Documentos Clave

| Documento | Tamaño | Uso |
|-----------|--------|-----|
| **INDEX.md** | 5.2K | Índice central (empieza aquí) |
| **QUICKSTART.md** | 6.7K | Guía de 5 minutos |
| **AGENTS_REFERENCE.md** | 7.8K | Documentación completa |
| **_template.md** | 3.4K | Para crear nuevos agentes |

---

## 🤖 5 Agentes Disponibles

| Agente | Tipo | Modelo | Temp | Usa Para |
|--------|------|--------|------|----------|
| **data-engineer** | Primary | Claude 3.5 | 0.3 | ⭐ Flujo completo |
| **sql-specialist** | Subagent | Claude 3.5 | 0.1 | SQL & queries |
| **git-manager** | Subagent | Gemini 2.0 | 0.1 | Git (ramas, commits) |
| **python-coder** | Subagent | Gemini 2.5 | 0.1 | Código Python (PEP 8) |
| **tdd-architect** | Subagent | Claude 3.5 | 0.0 | Tests TDD |

---

## 💡 Ejemplos Rápidos

### Pipeline CSV
```
@data-engineer
"Crear pipeline que lea CSVs, valide datos, 
transforme fechas a ISO 8601, cargue en PostgreSQL"
```

### Query SQL Compleja
```
@sql-specialist
"Necesito una query que obtenga top 10 clientes por monto gastado
en último trimestre con agregaciones y ranking"
```

### Optimizar Query Lenta
```
@sql-specialist
"Esta query toma 30 segundos:
[SQL aquí]
¿Cómo optimizarla a < 2 segundos?"
```

### Diseño de Esquema
```
@sql-specialist
"Diseña esquema para e-commerce: 
clientes, productos, órdenes, líneas, pagos"
```

### Solo Tests
```
@tdd-architect
"Tests para validador de emails con Pydantic"
```

### Solo Código
```
@python-coder
"Implementar función calculate_discount(price, qty)
que pase los tests: ..."
```

### Solo Git
```
@git-manager
"Crear rama feature/my-feature y hacer commit"
```

---

## 🔄 Flujo Típico

```
@data-engineer
    ↓
  [Análisis]
    ↓
@git-manager (crear rama feature/)
    ↓
@tdd-architect (crear tests RED)
    ↓
@python-coder (implementar código GREEN)
    ↓
[Validación técnica]
    ↓
@git-manager (commit semántico)
    ↓
[Entrega]
```

---

## ✅ Qué Proporcionar

- ✅ Descripción clara del objetivo
- ✅ Contexto del problema
- ✅ Requisitos técnicos
- ✅ Entrada y salida esperada
- ✅ Restricciones (si las hay)
- ✅ Referencias a código existente

---

## 🛠 Herramientas Disponibles

| Herramienta | Descripción |
|-------------|-------------|
| **read** | Leer archivos |
| **write** | Crear archivos nuevos |
| **edit** | Editar archivos existentes |
| **bash** | Ejecutar comandos |
| **glob** | Buscar archivos por patrón |
| **grep** | Buscar en contenido |
| **webfetch** | Obtener contenido de URLs |
| **task** | Invocar otros agentes |

---

## 🎯 Opción por Necesidad

| Necesidad | Usa |
|-----------|-----|
| Requerimiento de datos (completo) | @data-engineer |
| Diseño o query SQL | @sql-specialist |
| Solo código Python | @python-coder |
| Solo tests | @tdd-architect |
| Solo git | @git-manager |

---

## 📖 Estructura de Cada Agente

```yaml
---
description: [Breve descripción]
mode: primary | subagent
model: [Modelo IA]
temperature: [0.0-1.0]
tools:
  read: true
  write: true/false
  edit: true/false
  bash: true/false
  # ...más herramientas
---

## 1. Persona y Rol
## 2. Responsabilidades
## 3. Protocolo de Trabajo
## 4. Formato de Salida
## 5. Límites y Restricciones
## 6. Ejemplos de Uso
```

---

## ⚙️ Configuración

### data-engineer (Principal)
- **Herramientas**: TODAS
- **Temperatura**: 0.3 (balance)
- **Modelo**: Claude Sonnet 3.5
- **Coordina**: todos los otros agentes

### git-manager
- **Herramientas**: read, edit, bash, glob, grep
- **Permisos**: git status/diff allow, push ask
- **Temperatura**: 0.1 (preciso)

### python-coder
- **Herramientas**: read, write, edit, bash, glob, grep
- **Estándares**: PEP 8, Type Hints, docstrings español
- **Temperatura**: 0.1 (preciso)

### tdd-architect
- **Herramientas**: read, write, edit, bash, glob, grep
- **Protocolo**: Docstrings ESCENARIO/COMPORTAMIENTO/PROPÓSITO
- **Temperatura**: 0.0 (exacto)

---

## 🔐 Seguridad

- ✅ Git operations requieren confirmación (ask)
- ✅ Sensibles files no se commitean
- ✅ Validación de esquema obligatoria
- ✅ Type Hints requeridos en Python
- ✅ Tests deben pasar antes de integración

---

## 📚 Documentación Completa

```
INDEX.md
├─ Índice central
├─ Descripción de cada archivo
├─ Flujos de trabajo
└─ Próximos pasos

QUICKSTART.md
├─ Inicio rápido
├─ Ejemplos
├─ Mejores prácticas
└─ Soporte

AGENTS_REFERENCE.md
├─ Detalle de cada agente
├─ Configuración de herramientas
├─ Estándares
└─ Cómo crear nuevos
```

---

## 🆘 Troubleshooting

| Problema | Solución |
|----------|----------|
| "Agente no encontrado" | Verifica que mode sea `primary` o `subagent` |
| "Herramienta no disponible" | Revisa que esté en la sección `tools` |
| "Modelo no válido" | Usa modelos disponibles (Claude, Gemini, etc.) |
| "Temperatura incorrecta" | Debe ser 0.0-1.0 |

---

## 🔗 Enlaces Útiles

- **OpenCode Docs**: https://opencode.ai/docs
- **GitHub Issues**: https://github.com/anomalyco/opencode/issues
- **Archivos**: `~/.config/opencode/agents/`

---

## ✨ Cheat Sheet

```bash
# Ver lista de agentes
ls -1 ~/.config/opencode/agents/

# Ver estructura de un agente
head -20 ~/.config/opencode/agents/data-engineer.md

# Crear nuevo agente
cp ~/.config/opencode/agents/_template.md mi-agente.md
# Edita mi-agente.md

# Ver documentación
cat ~/.config/opencode/agents/QUICKSTART.md
```

---

**¡Comenzar es tan simple como:**
```
@data-engineer
"Mi requerimiento"
```

**Resto lo maneja data-engineer automáticamente.** ✨
