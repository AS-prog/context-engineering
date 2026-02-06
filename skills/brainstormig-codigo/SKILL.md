---
name: brainstorming-codigo
description: "DEBE usarse antes de cualquier trabajo creativo: creación de funciones, construcción de componentes, adición de funcionalidades o modificación de comportamientos. Explora la intención del usuario, los requisitos y el diseño antes de la implementación."
---

# Brainstorming de Código

## ⚙️ Configuración

Este skill requiere la variable de entorno `OBSIDIAN_VAULT_PATH` para escribir los diseños en tu vault de Obsidian de manera agnóstica.

### Configuración por Sistema Operativo:

**Linux/Mac:**
```bash
# Agregar a ~/.bashrc, ~/.zshrc, o ~/.bash_profile:
export OBSIDIAN_VAULT_PATH="/home/tu-usuario/obsidian-vault"

# Para aplicar cambios:
source ~/.bashrc  # o ~/.zshrc
```

**Windows (PowerShell):**
```powershell
# Agregar a tu perfil de PowerShell ($PROFILE):
[Environment]::SetEnvironmentVariable("OBSIDIAN_VAULT_PATH", "C:\Users\tu-usuario\obsidian-vault", "User")

# O temporalmente en la sesión actual:
$env:OBSIDIAN_VAULT_PATH = "C:\Users\tu-usuario\obsidian-vault"
```

**Windows (CMD):**
```cmd
setx OBSIDIAN_VAULT_PATH "C:\Users\tu-usuario\obsidian-vault"
```

> **Nota:** Si la variable no está definida, el diseño se guardará en `./docs/plans/` (fallback local).

## 📖 Resumen
Ayuda a transformar ideas técnicas en diseños y especificaciones completas a través de un diálogo colaborativo natural.

## 🛠️ El Proceso

### Fase 1: Entender la Idea
- **Contexto actual:** Revisar primero el estado del proyecto (archivos, documentación, commits recientes).
- **Iteración atómica:** Hacer preguntas de una en una para refinar la idea.
- **Preferencias:** Priorizar preguntas de opción múltiple para agilizar la toma de decisiones.
- **Foco:** Comprender el propósito, las restricciones y los criterios de éxito.

### Fase 2: Explorar Enfoques
- **Propuestas:** Presentar 2-3 enfoques técnicos diferentes con sus pros y contras.
- **Recomendación:** Liderar con la opción recomendada y explicar el razonamiento técnico.

### Fase 3: Presentación del Diseño
- **Entrega fragmentada:** Presentar el diseño en secciones de 200-300 palabras.
- **Validación incremental:** Preguntar si el diseño es correcto después de cada sección.
- **Cobertura:** Incluir arquitectura, componentes, flujo de datos, manejo de errores y pruebas.

## 📜 Principios Clave
- **Una pregunta a la vez:** No abrumar con múltiples interrogantes.
- **YAGNI (No lo vas a necesitar):** Eliminar rigurosamente características innecesarias de todos los diseños.
- **Validación constante:** Estar listo para retroceder y aclarar si algo no tiene sentido.

## 🏁 Post-Diseño
- **Documentación:** Escribir el diseño validado en la ruta determinada por la variable de entorno `OBSIDIAN_VAULT_PATH`:
  - **Ruta completa:** `$OBSIDIAN_VAULT_PATH/plans/YYYY-MM-DD-<topic>-design.md`
  - **Fallback:** Si `OBSIDIAN_VAULT_PATH` no está definida, usar `./docs/plans/YYYY-MM-DD-<topic>-design.md`
- Usa la plantilla ubicada en `./brainstorming-code-template.md` (o el nombre exacto que le hayas dado).
- **Implementación:** Preguntar "¿Listo para configurar la implementación?" antes de proceder.
- Asegúrate de crear el directorio `plans/` dentro del vault si no existe.