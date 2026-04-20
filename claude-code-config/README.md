# ClaudeKit — Save tokens, work smarter with Claude Code

A toolkit that improves your Claude Code experience. Save tokens, organize your projects, and protect your configuration.

**By Guille Varela -- [Nodox Studio](https://nodox.studio)**

---

## What's included

- **`commands/`** -- Custom slash commands for Claude Code (`/workspace`, `/savings`, `/lock-claude`, `/unlock-claude`, `/tuning`)
- **`statusline.sh`** -- Custom status line script showing project info, session timer, model, context usage, token counts, cost, and RTK savings

## Slash Commands

| Command | Description |
|---------|-------------|
| `/workspace` | Project selector -- switch between workspaces (e.g. consultancy vs side projects) |
| `/savings` | RTK token savings dashboard with cost estimation |
| `/lock-claude` | Restore deny rules that prevent Claude from editing its own config and hooks |
| `/unlock-claude` | Temporarily remove config protection so Claude can edit settings |
| `/tuning` | Game tuning parameters viewer (project-specific example for game dev) |

## Status Line

The custom `statusline.sh` displays a compact, color-coded status bar at the bottom of your Claude Code session:

- **Project name** -- from session name or current directory
- **Session timer** -- tracks how long you've been working (HH:MM:SS)
- **Model** -- which Claude model is active
- **Context %** -- color-coded (green < 70%, yellow < 90%, red >= 90%)
- **Token counts** -- input and output tokens (formatted as K/M)
- **Cost** -- running session cost in USD
- **RTK savings** -- percentage saved and estimated dollar savings

It also updates the tmux status bar if you're running inside tmux.

## RTK Integration

[RTK (Rust Token Killer)](https://github.com/rtk-ai/rtk) is a CLI proxy that intercepts and filters verbose tool outputs before they reach Claude, saving **60-90% of tokens** on common dev operations like `git status`, `git diff`, `ls`, etc.

The status line and `/savings` command are built to read RTK analytics and display savings in real time. RTK works transparently via Claude Code hooks -- no changes to your workflow needed.

## Installation

### Quick install (recommended)

```bash
git clone https://github.com/nodox-studio/claukit.git
cd claukit/claude-code-config
bash install.sh
```

The installer will:
- Copy slash commands to `~/.claude/commands/`
- Install the status line script (backs up your existing one)
- Detect or offer to install [RTK](https://github.com/rtk-ai/rtk)
- Skip files that already exist (safe to re-run)

### Manual install

1. Copy commands and status line:
   ```bash
   cp -r commands/ ~/.claude/commands/
   cp statusline.sh ~/.claude/statusline.sh
   chmod +x ~/.claude/statusline.sh
   ```

2. Install RTK (optional but recommended):
   ```bash
   curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/master/install.sh | bash
   rtk init -g
   ```

## Obsidian MCP (optional -- for `/workspace`)

The `/workspace` command connects to your Obsidian vaults via MCP to load project context. To use it, you need:

1. [Obsidian](https://obsidian.md/) with the **Local REST API** plugin enabled
2. The [Obsidian MCP server](https://github.com/newtype-01/obsidian-mcp) (`@huangyihe/obsidian-mcp`)

Setup:

```bash
claude mcp add my-vault \
  --env OBSIDIAN_VAULT_PATH=/path/to/your/vault \
  --env OBSIDIAN_API_TOKEN=your-token \
  --env OBSIDIAN_API_PORT=27123 \
  -- npx -y @huangyihe/obsidian-mcp
```

> **Note:** Obsidian must be open with the vault loaded for the MCP to work. Without it, `/workspace` still works but won't pull context from your notes.

## Stack

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) -- Anthropic's CLI for Claude
- [RTK](https://github.com/rtk-ai/rtk) -- Rust Token Killer, token-optimized CLI proxy
- [Obsidian MCP](https://github.com/newtype-01/obsidian-mcp) -- Connect your Obsidian vaults to Claude Code (optional)
- Works with any terminal (optimized for [Ghostty](https://ghostty.org/) + tmux)

---

Part of my journey from Product Designer to Design Engineer -- building with AI agents, not just designing for them.

A free product by [Nodox Studio](https://nodox.studio), made with heart by Guille Varela.

### Nodox Studio
- Web: [nodox.studio](https://nodox.studio)
- Email: somos@nodox.studio

### Guille Varela
- LinkedIn: [linkedin.com/in/guillevarela](https://www.linkedin.com/in/guillevarela/)
- Ko-fi: [ko-fi.com/guillevarela](https://ko-fi.com/guillevarela) ☕

---

# Español

## ClaudeKit — Ahorra tokens, trabaja mejor con Claude Code

Un toolkit que mejora tu experiencia con Claude Code. Ahorra tokens, organiza tus proyectos y protege tu configuración.

**Por Guille Varela — [Nodox Studio](https://nodox.studio)**

## Qué incluye

- **`commands/`** — Slash commands personalizados para Claude Code (`/workspace`, `/savings`, `/lock-claude`, `/unlock-claude`, `/tuning`)
- **`statusline.sh`** — Status line personalizado con info del proyecto, timer de sesión, modelo, uso de contexto, tokens, coste y ahorro RTK

## Slash Commands

| Comando | Descripción |
|---------|-------------|
| `/workspace` | Selector de proyecto — cambia entre entornos de trabajo (ej. consultora vs side projects) |
| `/savings` | Dashboard de ahorro de tokens RTK con estimación de coste |
| `/lock-claude` | Restaura reglas que impiden que Claude edite su propia configuración y hooks |
| `/unlock-claude` | Elimina temporalmente la protección para que Claude pueda editar settings |
| `/tuning` | Visor de parámetros de tuning (ejemplo específico para game dev) |

## Status Line

El script `statusline.sh` muestra una barra de estado compacta y con colores al pie de tu sesión de Claude Code:

- **Nombre del proyecto** — del nombre de sesión o directorio actual
- **Timer de sesión** — tiempo trabajando (HH:MM:SS)
- **Modelo** — qué modelo de Claude está activo
- **Contexto %** — con color (verde < 70%, amarillo < 90%, rojo >= 90%)
- **Tokens** — input y output (formateado como K/M)
- **Coste** — coste de la sesión en USD
- **Ahorro RTK** — porcentaje ahorrado y estimación en dólares

También actualiza la barra de tmux si estás dentro de una sesión tmux.

## Integración con RTK

[RTK (Rust Token Killer)](https://github.com/rtk-ai/rtk) es un proxy CLI que intercepta y filtra las salidas verbosas de herramientas antes de que lleguen a Claude, ahorrando **60-90% de tokens** en operaciones habituales como `git status`, `git diff`, `ls`, etc.

El status line y el comando `/savings` leen las analíticas de RTK y muestran el ahorro en tiempo real. RTK funciona de forma transparente mediante hooks de Claude Code — sin cambios en tu flujo de trabajo.

## Instalación

### Instalación rápida (recomendada)

```bash
git clone https://github.com/nodox-studio/claukit.git
cd claukit/claude-code-config
bash install.sh
```

El instalador:
- Copia los slash commands a `~/.claude/commands/`
- Instala el status line (hace backup del existente)
- Detecta u ofrece instalar [RTK](https://github.com/rtk-ai/rtk)
- No sobreescribe archivos existentes (seguro para re-ejecutar)

### Instalación manual

1. Copia commands y status line:
   ```bash
   cp -r commands/ ~/.claude/commands/
   cp statusline.sh ~/.claude/statusline.sh
   chmod +x ~/.claude/statusline.sh
   ```

2. Instala RTK (opcional pero recomendado):
   ```bash
   curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/master/install.sh | bash
   rtk init -g
   ```

## Obsidian MCP (opcional — para `/workspace`)

El comando `/workspace` se conecta a tus vaults de Obsidian via MCP para cargar contexto de proyecto. Necesitas:

1. [Obsidian](https://obsidian.md/) con el plugin **Local REST API** habilitado
2. El [servidor MCP de Obsidian](https://github.com/newtype-01/obsidian-mcp) (`@huangyihe/obsidian-mcp`)

Configuración:

```bash
claude mcp add mi-vault \
  --env OBSIDIAN_VAULT_PATH=/ruta/a/tu/vault \
  --env OBSIDIAN_API_TOKEN=tu-token \
  --env OBSIDIAN_API_PORT=27123 \
  -- npx -y @huangyihe/obsidian-mcp
```

> **Nota:** Obsidian debe estar abierto con el vault cargado para que el MCP funcione. Sin él, `/workspace` sigue funcionando pero no cargará contexto de tus notas.

## Stack

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) — CLI oficial de Anthropic para Claude
- [RTK](https://github.com/rtk-ai/rtk) — Rust Token Killer, proxy CLI optimizado para tokens
- [Obsidian MCP](https://github.com/newtype-01/obsidian-mcp) — Conecta tus vaults de Obsidian a Claude Code (opcional)
- Funciona con cualquier terminal (optimizado para [Ghostty](https://ghostty.org/) + tmux)

---

De mi viaje de Product Designer a Design Engineer — construyendo con agentes AI, no solo diseñando para ellos.

Un producto de uso libre de [Nodox Studio](https://nodox.studio), creado con corazón por Guille Varela.

### Nodox Studio
- Web: [nodox.studio](https://nodox.studio)
- Email: somos@nodox.studio

### Guille Varela
- LinkedIn: [linkedin.com/in/guillevarela](https://www.linkedin.com/in/guillevarela/)
- Ko-fi: [ko-fi.com/guillevarela](https://ko-fi.com/guillevarela) ☕
