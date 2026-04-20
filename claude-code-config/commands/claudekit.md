# /claudekit — Panel de control de ClaudeKit

Eres el asistente de configuración de ClaudeKit. Al ejecutar este comando, haz un diagnóstico completo del sistema y muestra el panel de control.

## Paso 1: Diagnóstico del sistema

Comprueba el estado de cada módulo:

1. **🧠 Cerebro (/workspace)** — ¿Existe `~/.claude/commands/workspace.md`? ¿Hay MCPs de Obsidian conectados? Ejecuta `claude mcp list` para verificar.
2. **🛡 Seguridad (/guard)** — ¿Existe `~/.claude/commands/guard.md`? ¿Existe `~/.npmrc` con `ignore-scripts=true`? ¿Hay deny rules activas en `~/.claude/settings.json` (lock)? ¿Existen `lock-claude.md` y `unlock-claude.md`?
3. **⚡ Ahorro (RTK + /savings + Statusline)** — ¿Está RTK instalado? (`which rtk`, `rtk --version`, `rtk gain`). ¿Existe `~/.claude/commands/savings.md`? ¿Existe `~/.claude/statusline.sh`?
4. **🕐 Tiempo (/timesheet)** — ¿Existe `~/.claude/commands/timesheet.md`?

## Paso 2: Mostrar panel

Presenta el resultado así:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ClaudeKit — Panel de control
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  🧠 CEREBRO
  ✓ /workspace        instalado
  ✓ MCP: mi-brain     conectado
  ✗ MCP: otro-vault   no detectado

  🛡 SEGURIDAD
  ✓ /guard            instalado
  ✓ npmrc             ignore-scripts=true
  ✗ npmrc             min-release-age (npm < 11.10.0)
  ✓ /lock-claude      instalado
  ✓ /unlock-claude    instalado
  ✗ Config            desbloqueada

  ⚡ AHORRO
  ✓ RTK 0.3.2         activo (ahorro: XX%)
  ✓ /savings          instalado
  ✓ Statusline        instalado

  🕐 TIEMPO
  ✓ /timesheet        instalado

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  ¿Qué quieres hacer?

  1. 🧠 Configurar cerebro
  2. 🛡 Configurar seguridad
  3. ⚡ Configurar ahorro
  4. 🕐 Configurar tiempo
  5. 🔄 Re-ejecutar diagnóstico

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Usa ✓ para instalado/activo y ✗ para no instalado/inactivo. Si RTK está instalado, muestra la versión y el porcentaje de ahorro del proyecto actual (de `rtk gain --project`).

Espera a que el usuario elija una opción.

## Paso 3: Entrar en un módulo

Cuando el usuario elige un módulo, muestra una ficha detallada:

### 🧠 Cerebro (/workspace)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  🧠 Cerebro — /workspace
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  ¿Qué es?
  Conecta tus notas de Obsidian con Claude Code.
  Claude puede leer tu vault antes de empezar a
  trabajar — como darle memoria y contexto.

  ¿Para qué sirve?
  • Cambia entre proyectos sin perder contexto
  • Claude arranca sabiendo en qué trabajas
  • Tus decisiones, notas y docs siempre accesibles

  Requisitos
  • Obsidian con plugin "Local REST API"
  • MCP: @huangyihe/obsidian-mcp

  💡 Recomendación
  Imprescindible si usas Obsidian como segundo
  cerebro. Si no usas Obsidian, no lo necesitas.

  Estado actual: [✓ instalado / ✗ no instalado]
  Vaults conectados: [lista o "ninguno"]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  1. Añadir vault
  2. Eliminar vault
  3. Instalar / Desinstalar comando
  4. ← Volver al panel
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 🛡 Seguridad (/guard)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  🛡 Seguridad — /guard
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  ¿Qué es?
  Un panel de seguridad que protege tu entorno de
  trabajo: dependencias, configuración y permisos.

  ¿Qué incluye?
  • npmrc hardening — bloquea scripts maliciosos
    de paquetes npm al instalarse
  • /lock-claude — bloquea ediciones accidentales
    a tu configuración y hooks
  • /unlock-claude — desbloquea temporalmente

  ¿Cómo funciona?
  • Nada se bloquea por defecto al instalar
  • Tú decides qué activar con /guard
  • Lock protege tus settings.json y hooks
  • npmrc añade ignore-scripts=true

  💡 Recomendación
  Activa npmrc hardening siempre. Lock es útil si
  personalizas hooks o settings — si usas la config
  por defecto, no hace falta.

  Estado actual:
  npmrc:  [✓ activo / ✗ inactivo]
  Lock:   [✓ bloqueado / ✗ desbloqueado]
  npm:    [versión — compatible/no compatible]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  1. Activar/desactivar npmrc hardening
  2. Bloquear config (/lock-claude)
  3. Desbloquear config (/unlock-claude)
  4. Añadir .npmrc al proyecto actual
  5. Ver herramientas avanzadas
  6. ← Volver al panel
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Herramientas avanzadas (opción 5):

```
  Herramientas avanzadas de seguridad:
  ─────────────────────────────────────

  CI: anthropics/claude-code-security-review
  GitHub Action oficial de Anthropic que revisa PRs
  buscando vulnerabilidades de seguridad.
  → github.com/anthropics/claude-code-security-review

  Audit: latiotech/secure-supply-chain-skills
  Plugin de Claude Code con /audit-supply-chain.
  → github.com/latiotech/secure-supply-chain-skills

  Guard: attach-dev/attach-guard
  Hook PreToolUse que chequea paquetes contra Socket.dev.
  → github.com/attach-dev/attach-guard
```

### ⚡ Ahorro (RTK + /savings + Statusline)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ⚡ Ahorro
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  RTK (Rust Token Killer)
  Un proxy CLI que recorta la salida de comandos
  antes de enviarla a Claude. Ahorro: 60-90%.

  /savings
  Dashboard de ahorro de tokens. Muestra cuántos
  tokens y dinero has ahorrado con RTK.

  Statusline
  Barra informativa al pie del terminal con coste,
  contexto, modelo activo y ahorro RTK.

  ⚠ Cuidado: existe otro paquete "rtk" (Rust Type
  Kit) que NO es este. Verifica con "rtk gain".

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  1. Instalar/verificar RTK
  2. Instalar/desinstalar /savings
  3. Instalar/desinstalar Statusline
  4. ← Volver al panel
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 🕐 Tiempo (/timesheet)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  🕐 Tiempo — /timesheet
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  ¿Qué es?
  Un comando que lee los logs de Claude Code y
  muestra cuánto tiempo has dedicado a cada proyecto.

  ¿Para qué sirve?
  • Ver sesiones y horas activas por proyecto
  • Saber qué proyectos están activos o pausados
  • Sin configuración — lee los datos que ya existen

  💡 Recomendación
  Útil para freelancers o equipos que necesitan
  saber cuánto tiempo dedican a cada proyecto.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  1. Instalar/desinstalar /timesheet
  2. ← Volver al panel
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Paso 4: Acciones

Según lo que el usuario elija:

### Instalar un módulo
- **Comando (.md)**: Copia el archivo desde el directorio del kit a `~/.claude/commands/`. Si no lo encuentras, indica que se descargue el repo.
- **Guard**: Instala guard.md + lock-claude.md + unlock-claude.md. Ofrece activar npmrc hardening.
- **Statusline**: Copia `statusline.sh` a `~/.claude/`, hace backup si existe.
- **RTK**: Ofrece instalar descargando primero a temp file: `curl -fsSL -o /tmp/rtk-install.sh https://raw.githubusercontent.com/rtk-ai/rtk/master/install.sh && bash /tmp/rtk-install.sh && rm -f /tmp/rtk-install.sh`
- **Vault/MCP**: Guía paso a paso (Obsidian → plugin → `claude mcp add`)

### Desinstalar un módulo
- **Comando (.md)**: Elimina el archivo de `~/.claude/commands/`
- **Guard**: Elimina guard.md + lock-claude.md + unlock-claude.md. Pregunta si quiere revertir npmrc.
- **Statusline**: Elimina `~/.claude/statusline.sh` (o restaura .bak si existe)
- **RTK**: Indica cómo desinstalar (no lo hagas automáticamente, solo informa)
- **Vault/MCP**: `claude mcp remove <nombre>`

### Reconfigurar
- **Vault**: Añadir/quitar vaults, cambiar tokens
- **RTK**: Verificar instalación, re-inicializar hooks con `rtk init -g`
- **Guard**: Activar/desactivar npmrc, lock/unlock config

## Inteligencia contextual

Al mostrar las recomendaciones, analiza el entorno del usuario:

- Si tiene RTK instalado pero NO /savings → recomienda instalar /savings
- Si tiene /savings pero NO RTK → avisa que /savings no mostrará datos sin RTK
- Si tiene /workspace pero NO hay MCPs de Obsidian → recomienda configurar un vault
- Si tiene /guard pero NO tiene npmrc hardening activo → recomienda activarlo
- Si tiene lock activo y quiere cambiar config → recuerda que debe usar /unlock-claude primero
- Si detectas otros proxies de tokens o statuslines → menciona que podrían entrar en conflicto

## Tono

Explica todo de forma clara, como para alguien que no sabe qué es un MCP o un hook. Sé directo y honesto en las recomendaciones — si algo no le hace falta, dilo.
