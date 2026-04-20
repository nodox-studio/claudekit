#!/bin/bash
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  ClaudeKit — Installer
#  By Guille Varela — Nodox Studio
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set -e

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'
DIM='\033[2m'
WHITE='\033[1;37m'

CLAUDE_DIR="$HOME/.claude"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# ── kit (seasonal mascot) ────────────────────
MONTH=$(date +%m)
if [[ "$MONTH" -ge 6 && "$MONTH" -le 8 ]]; then
  # verano — esquilada
  KIT_HEAD=" @>"
  KIT_BODY=" .__"
  KIT_LEGS=" |  |"
else
  # resto del año — con lana
  KIT_HEAD=" @>"
  KIT_BODY=".@@@@"
  KIT_LEGS=" |  |"
fi
KIT_HEAD_OK=" \\@>/"
KIT_BODY_OK="${KIT_BODY}"
KIT_LEGS_OK="${KIT_LEGS}"

# ── Header ────────────────────────────────────
echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${CYAN}  ____ _        _   _   _ ____  _____ _  _____ _____ ${NC}"
echo -e "${CYAN} / ___| |      / \\ | | | |  _ \\| ____| |/ /_ _|_   _|${NC}"
echo -e "${CYAN}| |   | |     / _ \\| | | | | | |  _| | ' / | |  | |  ${NC}  ${WHITE}${KIT_HEAD}${NC}"
echo -e "${CYAN}| |___| |___ / ___ \\ |_| | |_| | |___| . \\ | |  | |  ${NC}  ${WHITE}${KIT_BODY}${NC}"
echo -e "${CYAN} \\____|_____/_/   \\_\\___/|____/|_____|_|\\_\\___| |_|  ${NC}  ${WHITE}${KIT_LEGS}${NC}"
echo ""
echo -e "  ${DIM}Trabaja inteligente, seguro y ahorra tokens${NC}"
echo -e "  ${DIM}por${NC} ${WHITE}Guille Varela${NC} ${DIM}—${NC} ${CYAN}nodox.studio${NC}"
echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# ── Language selector ─────────────────────────
echo -e "  ${WHITE}Language / Idioma${NC}"
echo ""
echo -e "  ${CYAN}1${NC}) \xF0\x9F\x87\xAC\xF0\x9F\x87\xA7 English"
echo -e "  ${CYAN}2${NC}) \xF0\x9F\x87\xAA\xF0\x9F\x87\xB8 Español"
echo ""
read -p "  → " -n 1 -r LANG_CHOICE
echo ""
echo ""

if [[ "$LANG_CHOICE" == "2" ]]; then
  LANG="es"
else
  LANG="en"
fi

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Bilingual strings
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
if [[ "$LANG" == "es" ]]; then
  # ── Welcome ──
  STR_WELCOME_1="ClaudeKit es un conjunto de herramientas que mejoran tu"
  STR_WELCOME_2="experiencia con Claude Code. Ahorras tokens, organizas"
  STR_WELCOME_3="tus proyectos y proteges tu configuración."
  STR_WELCOME_LOVE="Hecho con amor por Guille Varela y la ayuda de Claude Code."
  STR_WELCOME_4="Elige qué quieres instalar:"

  # ── Categories ──
  STR_CAT_BRAIN="🧠 CEREBRO — Dale memoria y contexto a Claude"
  STR_CAT_SECURITY="🛡 SEGURIDAD — Protege tu config y tus dependencias"
  STR_CAT_SAVINGS="⚡ AHORRO — Gasta menos tokens, ahorra dinero"
  STR_CAT_TIME="🕐 TIEMPO — Controla cuánto dedicas a cada proyecto"

  # ── Feature names ──
  STR_F_WORKSPACE="/workspace"
  STR_F_GUARD="/guard"
  STR_F_RTK="RTK (Rust Token Killer)"
  STR_F_SAVINGS="/savings"
  STR_F_STATUSLINE="Statusline"
  STR_F_TIMESHEET="/timesheet"

  # ── Feature descriptions (menu) ──
  STR_D_WORKSPACE="Centraliza tu conocimiento en un solo lugar y deja que"
  STR_D_WORKSPACE2="Claude lo use. Conecta tus notas de Obsidian para que"
  STR_D_WORKSPACE3="sepa en qué trabajas antes de que le digas nada."
  STR_D_WORKSPACE4="Requiere: Obsidian (gratis) — obsidian.md"
  STR_D_WORKSPACE5="MCP por @huangyihe — github.com/newtype-01/obsidian-mcp"

  STR_D_GUARD="Revisa la seguridad de tu entorno: dependencias, permisos"
  STR_D_GUARD2="y configuración. Endurece tu .npmrc para que los paquetes"
  STR_D_GUARD3="no ejecuten scripts maliciosos al instalarse."
  STR_D_GUARD4="Incluye /lock-claude y /unlock-claude para proteger tu setup."
  STR_D_GUARD5="No bloquea nada por defecto — tú decides qué activar."

  STR_D_RTK="Cada vez que Claude ejecuta un comando (git, ls...),"
  STR_D_RTK2="la respuesta gasta tokens = dinero. RTK recorta esa"
  STR_D_RTK3="respuesta automáticamente. Ahorro real: 60-90%."
  STR_D_RTK4="Se instala una vez y funciona solo, sin tocar nada."
  STR_D_RTK5="Por rtk-ai — github.com/rtk-ai/rtk"

  STR_D_SAVINGS="Escribe /savings en Claude Code y verás un resumen de"
  STR_D_SAVINGS2="cuántos tokens has ahorrado y cuánto dinero representa."
  STR_D_SAVINGS3="Necesita RTK instalado para funcionar."

  STR_D_STATUSLINE="Una barra al pie de tu terminal que te muestra en"
  STR_D_STATUSLINE2="todo momento: coste de la sesión, modelo activo,"
  STR_D_STATUSLINE3="cuánto contexto queda y ahorro de tokens."

  STR_D_TIMESHEET="Escribe /timesheet y verás cuánto tiempo has dedicado"
  STR_D_TIMESHEET2="a cada proyecto: sesiones, horas activas y estado."
  STR_D_TIMESHEET3="Lee los logs de Claude Code, no necesita nada extra."

  # ── Scaffold ──
  STR_CAT_START="INICIO — Prepara un proyecto nuevo para Claude"
  STR_F_SCAFFOLD="Scaffold"
  STR_D_SCAFFOLD="Crea la estructura de carpetas que Claude Code necesita"
  STR_D_SCAFFOLD2="para trabajar bien en cualquier proyecto. Incluye un"
  STR_D_SCAFFOLD3="CLAUDE.md de plantilla listo para rellenar."
  STR_D_SCAFFOLD4="Solo crea lo esencial (Día 1). Añade el resto cuando"
  STR_D_SCAFFOLD5="lo necesites, no antes."

  STR_SCAFFOLD_ASK="¿En qué carpeta está tu proyecto?"
  STR_SCAFFOLD_PATH="Ruta completa (ej. /Users/tu/proyectos/mi-app): "
  STR_SCAFFOLD_NAME="Nombre del proyecto (ej. mi-app, dashboard, landing): "
  STR_SCAFFOLD_DESC="Describe brevemente el proyecto (1 línea): "
  STR_SCAFFOLD_NOT_FOUND="Esa carpeta no existe. Créala primero."
  STR_SCAFFOLD_CREATING="Creando estructura..."
  STR_SCAFFOLD_DONE="Estructura lista."
  STR_SCAFFOLD_TREE="Esto es lo que se ha creado:"
  STR_SCAFFOLD_NEXT="Abre CLAUDE.md y rellena los datos de tu proyecto."
  STR_SCAFFOLD_EXISTS="ya existe — no se sobreescribe"

  # ── Menu ──
  STR_SELECT="Elige qué instalar (ej. 1,3,5 o 'todo'):"
  STR_ALL="todo"

  # ── Install narration ──
  STR_CHECKING="Comprobando que tengas Claude Code instalado..."
  STR_CLAUDE_NOT_FOUND="Claude Code no encontrado."
  STR_CLAUDE_INSTALL="Instálalo primero:"
  STR_CLAUDE_DETECTED="Claude Code detectado. Perfecto, podemos continuar."
  STR_DIR_READY="Carpeta ~/.claude/commands/ lista."

  STR_NARR_RTK="Instalando RTK — un proxy que intercepta comandos como"
  STR_NARR_RTK2="'git status' y recorta la salida antes de que llegue a Claude."
  STR_NARR_RTK3="Funciona automáticamente mediante hooks, no cambia tu flujo."
  STR_RTK_INSTALLED="RTK ya instalado"
  STR_RTK_VERIFIED="Verificado: Rust Token Killer (RTK correcto)"
  STR_RTK_WRONG="'rtk gain' falló — podrías tener el RTK incorrecto (Rust Type Kit)."
  STR_RTK_NOT_INSTALLED="RTK no está instalado todavía."
  STR_RTK_ASK="¿Instalar RTK ahora? [S/n] "
  STR_RTK_INSTALLING="Descargando e instalando RTK..."
  STR_RTK_SUCCESS="RTK instalado correctamente"
  STR_RTK_HOOKS="Ejecuta 'rtk init -g' para activar los hooks en Claude Code."
  STR_RTK_FAIL="Instalación fallida. Instala manualmente:"
  STR_RTK_SKIP="Omitido. Instala después:"

  STR_NARR_SAVINGS="Instalando /savings — un comando que consulta las estadísticas"
  STR_NARR_SAVINGS2="de RTK y te muestra un resumen de tokens ahorrados y coste."
  STR_NARR_SAVINGS3="Escribe /savings en Claude Code para verlo."

  STR_NARR_STATUSLINE="Instalando statusline — un script que muestra una barra"
  STR_NARR_STATUSLINE2="informativa al pie de tu terminal con el coste de la sesión,"
  STR_NARR_STATUSLINE3="uso de contexto, modelo activo y ahorro RTK en tiempo real."
  STR_SL_EXISTS="statusline.sh ya existe — guardando backup como .bak"
  STR_SL_INSTALLED="statusline.sh instalado"

  STR_NARR_TIMESHEET="Instalando /timesheet — un comando que lee los logs de"
  STR_NARR_TIMESHEET2="Claude Code y te muestra cuánto tiempo has dedicado a"
  STR_NARR_TIMESHEET3="cada proyecto, con sesiones, horas activas y estado."

  STR_NARR_WORKSPACE="Configurando el cerebro — esto conecta tus notas de Obsidian"
  STR_NARR_WORKSPACE2="con Claude Code. Es como darle memoria a Claude: puede leer"
  STR_NARR_WORKSPACE3="tus proyectos, notas y contexto antes de empezar a trabajar."

  STR_OBS_NEED="Vamos a configurar el cerebro de Claude — conectar tus notas."
  STR_OBS_SETUP="¿Configuramos tu cerebro ahora? [S/n] "
  STR_OBS_SKIP="Omitido. Puedes configurarlo después siguiendo el README."
  STR_OBS_STEP1="Paso 1: Obsidian"
  STR_OBS_STEP1_OK="Obsidian detectado."
  STR_OBS_STEP1_NO="Obsidian no detectado. Descárgalo en:"
  STR_OBS_STEP1_URL="https://obsidian.md/download"
  STR_OBS_STEP1_WAIT="Instala Obsidian, crea un vault y vuelve a ejecutar el instalador."
  STR_OBS_STEP2="Paso 2: Plugin Local REST API"
  STR_OBS_STEP2_1="Abre Obsidian → Ajustes → Plugins de comunidad → Buscar"
  STR_OBS_STEP2_2="Busca 'Local REST API' (por Adam Coddington) e instálalo."
  STR_OBS_STEP2_3="Actívalo y copia el token de la API desde los ajustes del plugin."
  STR_OBS_STEP2_ASK="¿Ya tienes el plugin activado y el token copiado? [S/n] "
  STR_OBS_STEP3="Paso 3: Conectar tu vault"
  STR_OBS_STEP3_NAME="Nombre para este vault (ej. mi-proyecto, notas, brain): "
  STR_OBS_STEP3_PATH="Ruta completa al vault (ej. /Users/tu/Documents/mi-vault): "
  STR_OBS_STEP3_TOKEN="Token de la API (lo copiaste del plugin): "
  STR_OBS_STEP3_REG="Registrando el MCP en Claude Code..."
  STR_OBS_STEP3_OK="Cerebro conectado. Claude ahora puede leer tu vault."
  STR_OBS_STEP3_FAIL="Error al registrar. Puedes hacerlo manualmente:"
  STR_OBS_STEP3_TIP="Reinicia Claude Code para que detecte el nuevo MCP."
  STR_OBS_MORE="¿Quieres conectar otro vault? [s/N] "
  STR_OBS_DONE="Cerebro configurado. Claude tiene memoria."
  STR_OBS_YAML_TIP="Para que Claude encuentre tus proyectos, añade esto"
  STR_OBS_YAML_TIP2="al inicio de cada nota de proyecto en Obsidian:"
  STR_OBS_YAML_EX1="---"
  STR_OBS_YAML_EX2="tags: [active]"
  STR_OBS_YAML_EX3="project: mi-proyecto"
  STR_OBS_YAML_EX4="path: /ruta/a/mi/proyecto"
  STR_OBS_YAML_EX5="updated: $(date +%Y-%m-%d)"
  STR_OBS_YAML_EX6="updated_by: tu-nombre"
  STR_OBS_YAML_EX7="---"
  STR_OBS_YAML_TIP3="Claude actualizará 'updated' y 'updated_by' cada vez"
  STR_OBS_YAML_TIP4="que edite una nota, para que sepas quién tocó qué."

  STR_NARR_GUARD="Instalando /guard — un panel de seguridad que revisa tu .npmrc,"
  STR_NARR_GUARD2="la protección de tu config y las dependencias del proyecto."
  STR_NARR_GUARD3="También instala /lock-claude y /unlock-claude."
  STR_GUARD_NPMRC="¿Endurecer .npmrc global? Añade ignore-scripts=true"
  STR_GUARD_NPMRC2="para que los paquetes npm no ejecuten scripts al instalarse."
  STR_GUARD_NPMRC_ASK="¿Activar npmrc hardening? [S/n] "
  STR_GUARD_NPMRC_OK="npmrc endurecido. Los paquetes ya no ejecutan scripts al instalarse."
  STR_GUARD_NPMRC_EXISTS="ignore-scripts=true ya está configurado."
  STR_GUARD_NPMRC_SKIP="Omitido. Puedes activarlo después con /guard."
  STR_GUARD_NPM_TIP="Tu npm es v%s. Para bloquear paquetes recién publicados,"
  STR_GUARD_NPM_TIP2="actualiza a npm >= 11.10.0 y añade min-release-age=7."
  STR_GUARD_LOCK_TIP="Usa /lock-claude para bloquear tu config cuando quieras."
  STR_GUARD_LOCK_TIP2="Usa /unlock-claude para desbloquearla temporalmente."

  STR_ALREADY_EXISTS="ya existe — omitido"
  STR_COPYING="Copiando a ~/.claude/commands/..."
  STR_CLAUKIT="Escribe /claudekit en Claude Code para gestionar tu kit."

  # ── Summary ──
  STR_DONE="¡Listo!"
  STR_INSTALLED_SUMMARY="Esto es lo que se ha instalado:"
  STR_AVAILABLE="Slash commands disponibles:"
  STR_NEXT="Próximos pasos:"
  STR_NEXT_1="1. Abre Claude Code"
  STR_NEXT_2="2. Prueba los comandos que instalaste"
  STR_NEXT_3="3. Instala RTK para ahorro de tokens:"
  STR_CTA_1="Si este kit te ahorró tiempo (o tokens),"
  STR_CTA_2="¿quieres invitarme a un café?"
  STR_CTA_3="Alimenta sesiones nocturnas de prompts."
else
  # ── Welcome ──
  STR_WELCOME_1="ClaudeKit is a set of tools that improve your Claude Code"
  STR_WELCOME_2="experience. Save tokens, organize your projects and"
  STR_WELCOME_3="protect your configuration."
  STR_WELCOME_LOVE="Made with love by Guille Varela and the help of Claude Code."
  STR_WELCOME_4="Choose what you want to install:"

  # ── Categories ──
  STR_CAT_BRAIN="🧠 BRAIN — Give Claude memory and context"
  STR_CAT_SECURITY="🛡 SECURITY — Protect your config and dependencies"
  STR_CAT_SAVINGS="⚡ SAVINGS — Spend fewer tokens, save money"
  STR_CAT_TIME="🕐 TIME — Track how much you spend on each project"

  # ── Feature names ──
  STR_F_WORKSPACE="/workspace"
  STR_F_GUARD="/guard"
  STR_F_RTK="RTK (Rust Token Killer)"
  STR_F_SAVINGS="/savings"
  STR_F_STATUSLINE="Statusline"
  STR_F_TIMESHEET="/timesheet"

  # ── Feature descriptions (menu) ──
  STR_D_WORKSPACE="Centralize your knowledge in one place and let Claude"
  STR_D_WORKSPACE2="use it. Connect your Obsidian notes so Claude knows"
  STR_D_WORKSPACE3="what you're working on before you say anything."
  STR_D_WORKSPACE4="Requires: Obsidian (free) — obsidian.md"
  STR_D_WORKSPACE5="MCP by @huangyihe — github.com/newtype-01/obsidian-mcp"

  STR_D_GUARD="Reviews your environment security: dependencies, permissions"
  STR_D_GUARD2="and configuration. Hardens your .npmrc so packages can't"
  STR_D_GUARD3="run malicious scripts during install."
  STR_D_GUARD4="Includes /lock-claude and /unlock-claude to protect your setup."
  STR_D_GUARD5="Nothing is blocked by default — you decide what to activate."

  STR_D_RTK="Every time Claude runs a command (git, ls...), the"
  STR_D_RTK2="response uses tokens = money. RTK trims that output"
  STR_D_RTK3="automatically. Real savings: 60-90%."
  STR_D_RTK4="Install once, works on its own. No config needed."
  STR_D_RTK5="By rtk-ai — github.com/rtk-ai/rtk"

  STR_D_SAVINGS="Type /savings in Claude Code and get a summary of"
  STR_D_SAVINGS2="how many tokens you've saved and how much money"
  STR_D_SAVINGS3="that represents. Requires RTK to work."

  STR_D_STATUSLINE="A bar at the bottom of your terminal that shows"
  STR_D_STATUSLINE2="at all times: session cost, active model, how much"
  STR_D_STATUSLINE3="context is left, and token savings."

  STR_D_TIMESHEET="Type /timesheet to see how much time you've spent"
  STR_D_TIMESHEET2="on each project: sessions, active hours, and status."
  STR_D_TIMESHEET3="Reads Claude Code logs, no extra setup needed."

  # ── Scaffold ──
  STR_CAT_START="START — Set up a new project for Claude"
  STR_F_SCAFFOLD="Scaffold"
  STR_D_SCAFFOLD="Creates the folder structure that Claude Code needs"
  STR_D_SCAFFOLD2="to work well on any project. Includes a CLAUDE.md"
  STR_D_SCAFFOLD3="template ready to fill in."
  STR_D_SCAFFOLD4="Only creates the essentials (Day 1). Add the rest"
  STR_D_SCAFFOLD5="when you need it, not before."

  STR_SCAFFOLD_ASK="Where is your project?"
  STR_SCAFFOLD_PATH="Full path (e.g. /Users/you/projects/my-app): "
  STR_SCAFFOLD_NAME="Project name (e.g. my-app, dashboard, landing): "
  STR_SCAFFOLD_DESC="Briefly describe the project (1 line): "
  STR_SCAFFOLD_NOT_FOUND="That folder doesn't exist. Create it first."
  STR_SCAFFOLD_CREATING="Creating structure..."
  STR_SCAFFOLD_DONE="Structure ready."
  STR_SCAFFOLD_TREE="Here's what was created:"
  STR_SCAFFOLD_NEXT="Open CLAUDE.md and fill in your project details."
  STR_SCAFFOLD_EXISTS="already exists — not overwritten"

  # ── Menu ──
  STR_SELECT="Choose what to install (e.g. 1,3,5 or 'all'):"
  STR_ALL="all"

  # ── Install narration ──
  STR_CHECKING="Checking that Claude Code is installed..."
  STR_CLAUDE_NOT_FOUND="Claude Code not found."
  STR_CLAUDE_INSTALL="Install it first:"
  STR_CLAUDE_DETECTED="Claude Code detected. Great, we can continue."
  STR_DIR_READY="~/.claude/commands/ folder ready."

  STR_NARR_RTK="Installing RTK — a proxy that intercepts commands like"
  STR_NARR_RTK2="'git status' and trims the output before it reaches Claude."
  STR_NARR_RTK3="Works automatically via hooks, no changes to your workflow."
  STR_RTK_INSTALLED="RTK already installed"
  STR_RTK_VERIFIED="Verified: Rust Token Killer (correct RTK)"
  STR_RTK_WRONG="'rtk gain' failed — you might have the wrong RTK (Rust Type Kit)."
  STR_RTK_NOT_INSTALLED="RTK is not installed yet."
  STR_RTK_ASK="Install RTK now? [Y/n] "
  STR_RTK_INSTALLING="Downloading and installing RTK..."
  STR_RTK_SUCCESS="RTK installed successfully"
  STR_RTK_HOOKS="Run 'rtk init -g' to activate hooks in Claude Code."
  STR_RTK_FAIL="Installation failed. Install manually:"
  STR_RTK_SKIP="Skipped. Install later:"

  STR_NARR_SAVINGS="Installing /savings — a command that queries RTK stats"
  STR_NARR_SAVINGS2="and shows you a summary of tokens saved and cost."
  STR_NARR_SAVINGS3="Type /savings in Claude Code to see it."

  STR_NARR_STATUSLINE="Installing statusline — a script that shows an info bar"
  STR_NARR_STATUSLINE2="at the bottom of your terminal with session cost, context"
  STR_NARR_STATUSLINE3="usage, active model and RTK savings in real time."
  STR_SL_EXISTS="statusline.sh already exists — saving backup as .bak"
  STR_SL_INSTALLED="statusline.sh installed"

  STR_NARR_TIMESHEET="Installing /timesheet — a command that reads Claude Code"
  STR_NARR_TIMESHEET2="logs and shows how much time you've spent on each project,"
  STR_NARR_TIMESHEET3="with sessions, active hours, and status."

  STR_NARR_WORKSPACE="Setting up the brain — this connects your Obsidian notes"
  STR_NARR_WORKSPACE2="to Claude Code. It's like giving Claude memory: it can read"
  STR_NARR_WORKSPACE3="your projects, notes and context before starting work."

  STR_OBS_NEED="Let's set up Claude's brain — connect your notes."
  STR_OBS_SETUP="Set up your brain now? [Y/n] "
  STR_OBS_SKIP="Skipped. You can set it up later following the README."
  STR_OBS_STEP1="Step 1: Obsidian"
  STR_OBS_STEP1_OK="Obsidian detected."
  STR_OBS_STEP1_NO="Obsidian not detected. Download it at:"
  STR_OBS_STEP1_URL="https://obsidian.md/download"
  STR_OBS_STEP1_WAIT="Install Obsidian, create a vault and re-run the installer."
  STR_OBS_STEP2="Step 2: Local REST API plugin"
  STR_OBS_STEP2_1="Open Obsidian → Settings → Community plugins → Browse"
  STR_OBS_STEP2_2="Search for 'Local REST API' (by Adam Coddington) and install it."
  STR_OBS_STEP2_3="Enable it and copy the API token from the plugin settings."
  STR_OBS_STEP2_ASK="Is the plugin enabled and the token copied? [Y/n] "
  STR_OBS_STEP3="Step 3: Connect your vault"
  STR_OBS_STEP3_NAME="Name for this vault (e.g. my-project, notes, brain): "
  STR_OBS_STEP3_PATH="Full path to the vault (e.g. /Users/you/Documents/my-vault): "
  STR_OBS_STEP3_TOKEN="API token (you copied it from the plugin): "
  STR_OBS_STEP3_REG="Registering the MCP in Claude Code..."
  STR_OBS_STEP3_OK="Brain connected. Claude can now read your vault."
  STR_OBS_STEP3_FAIL="Registration failed. You can do it manually:"
  STR_OBS_STEP3_TIP="Restart Claude Code so it detects the new MCP."
  STR_OBS_MORE="Want to connect another vault? [y/N] "
  STR_OBS_DONE="Brain configured. Claude has memory."
  STR_OBS_YAML_TIP="For Claude to find your projects, add this to the"
  STR_OBS_YAML_TIP2="top of each project note in Obsidian:"
  STR_OBS_YAML_EX1="---"
  STR_OBS_YAML_EX2="tags: [active]"
  STR_OBS_YAML_EX3="project: my-project"
  STR_OBS_YAML_EX4="path: /path/to/my/project"
  STR_OBS_YAML_EX5="updated: $(date +%Y-%m-%d)"
  STR_OBS_YAML_EX6="updated_by: your-name"
  STR_OBS_YAML_EX7="---"
  STR_OBS_YAML_TIP3="Claude will update 'updated' and 'updated_by' each"
  STR_OBS_YAML_TIP4="time it edits a note, so you know who touched what."

  STR_NARR_GUARD="Installing /guard — a security panel that checks your .npmrc,"
  STR_NARR_GUARD2="config protection and project dependencies."
  STR_NARR_GUARD3="Also installs /lock-claude and /unlock-claude."
  STR_GUARD_NPMRC="Harden global .npmrc? Adds ignore-scripts=true so npm"
  STR_GUARD_NPMRC2="packages can't run scripts during install."
  STR_GUARD_NPMRC_ASK="Enable npmrc hardening? [Y/n] "
  STR_GUARD_NPMRC_OK="npmrc hardened. Packages can no longer run scripts during install."
  STR_GUARD_NPMRC_EXISTS="ignore-scripts=true is already configured."
  STR_GUARD_NPMRC_SKIP="Skipped. You can enable it later with /guard."
  STR_GUARD_NPM_TIP="Your npm is v%s. To block recently published packages,"
  STR_GUARD_NPM_TIP2="upgrade to npm >= 11.10.0 and add min-release-age=7."
  STR_GUARD_LOCK_TIP="Use /lock-claude to protect your config when ready."
  STR_GUARD_LOCK_TIP2="Use /unlock-claude to temporarily allow changes."

  STR_ALREADY_EXISTS="already exists — skipped"
  STR_COPYING="Copying to ~/.claude/commands/..."
  STR_CLAUKIT="Type /claudekit in Claude Code to manage your kit."

  # ── Summary ──
  STR_DONE="Done!"
  STR_INSTALLED_SUMMARY="Here's what was installed:"
  STR_AVAILABLE="Available slash commands:"
  STR_NEXT="Next steps:"
  STR_NEXT_1="1. Open Claude Code"
  STR_NEXT_2="2. Try the commands you installed"
  STR_NEXT_3="3. Install RTK for token savings:"
  STR_CTA_1="If this kit saved you time (or tokens),"
  STR_CTA_2="buy us a coffee."
  STR_CTA_3="It fuels late-night prompt engineering."
fi

# ── Welcome message ──────────────────────────
echo -e "  ${STR_WELCOME_1}"
echo -e "  ${STR_WELCOME_2}"
echo -e "  ${STR_WELCOME_3}"
echo -e "  ${DIM}${STR_WELCOME_LOVE}${NC}"
echo ""
echo -e "  ${STR_WELCOME_4}"
echo ""

# ── Feature menu by categories ───────────────
echo -e "  ${CYAN}── ${STR_CAT_BRAIN} ──${NC}"
echo ""
echo -e "  ${WHITE}1${NC}) 🧠 ${WHITE}${STR_F_WORKSPACE}${NC}"
echo -e "     ${DIM}${STR_D_WORKSPACE}${NC}"
echo -e "     ${DIM}${STR_D_WORKSPACE2}${NC}"
echo -e "     ${DIM}${STR_D_WORKSPACE3}${NC}"
echo -e "     ${DIM}${STR_D_WORKSPACE4}${NC}"
echo -e "     ${DIM}${STR_D_WORKSPACE5}${NC}"
echo ""
echo -e "  ${CYAN}── ${STR_CAT_SECURITY} ──${NC}"
echo ""
echo -e "  ${WHITE}2${NC}) 🛡 ${WHITE}${STR_F_GUARD}${NC}"
echo -e "     ${DIM}${STR_D_GUARD}${NC}"
echo -e "     ${DIM}${STR_D_GUARD2}${NC}"
echo -e "     ${DIM}${STR_D_GUARD3}${NC}"
echo -e "     ${DIM}${STR_D_GUARD4}${NC}"
echo -e "     ${DIM}${STR_D_GUARD5}${NC}"
echo ""
echo -e "  ${CYAN}── ${STR_CAT_SAVINGS} ──${NC}"
echo ""
echo -e "  ${WHITE}3${NC}) ⚡ ${WHITE}${STR_F_RTK}${NC}"
echo -e "     ${DIM}${STR_D_RTK}${NC}"
echo -e "     ${DIM}${STR_D_RTK2}${NC}"
echo -e "     ${DIM}${STR_D_RTK3}${NC}"
echo -e "     ${DIM}${STR_D_RTK4}${NC}"
echo -e "     ${DIM}${STR_D_RTK5}${NC}"
echo ""
echo -e "  ${WHITE}4${NC}) 💰 ${WHITE}${STR_F_SAVINGS}${NC}"
echo -e "     ${DIM}${STR_D_SAVINGS}${NC}"
echo -e "     ${DIM}${STR_D_SAVINGS2}${NC}"
echo -e "     ${DIM}${STR_D_SAVINGS3}${NC}"
echo ""
echo -e "  ${WHITE}5${NC}) 📊 ${WHITE}${STR_F_STATUSLINE}${NC}"
echo -e "     ${DIM}${STR_D_STATUSLINE}${NC}"
echo -e "     ${DIM}${STR_D_STATUSLINE2}${NC}"
echo -e "     ${DIM}${STR_D_STATUSLINE3}${NC}"
echo ""
echo -e "  ${CYAN}── ${STR_CAT_TIME} ──${NC}"
echo ""
echo -e "  ${WHITE}6${NC}) 🕐 ${WHITE}${STR_F_TIMESHEET}${NC}"
echo -e "     ${DIM}${STR_D_TIMESHEET}${NC}"
echo -e "     ${DIM}${STR_D_TIMESHEET2}${NC}"
echo -e "     ${DIM}${STR_D_TIMESHEET3}${NC}"
echo ""
echo -e "  ${CYAN}── ${STR_CAT_START} ──${NC}"
echo ""
echo -e "  ${WHITE}7${NC}) 📁 ${WHITE}${STR_F_SCAFFOLD}${NC}"
echo -e "     ${DIM}${STR_D_SCAFFOLD}${NC}"
echo -e "     ${DIM}${STR_D_SCAFFOLD2}${NC}"
echo -e "     ${DIM}${STR_D_SCAFFOLD3}${NC}"
echo -e "     ${DIM}${STR_D_SCAFFOLD4}${NC}"
echo -e "     ${DIM}${STR_D_SCAFFOLD5}${NC}"
echo ""
echo -e "${DIM}  ─────────────────────────────────────────────────────────${NC}"
echo ""
echo -e "  ${WHITE}8${NC}) 🚀 ${WHITE}${STR_ALL^^}${NC} ${DIM}— (1-7)${NC}"
echo ""

if [[ "$LANG" == "es" ]]; then
  STR_HINT="pulsa un número y Enter para continuar"
else
  STR_HINT="press a number and Enter to continue"
fi
echo -e "  ${DIM}${STR_HINT}${NC}"
echo ""
read -p "  ${STR_SELECT} " SELECTION
echo ""

# ── Parse selection ──────────────────────────
INSTALL_WORKSPACE=false
INSTALL_GUARD=false
INSTALL_RTK=false
INSTALL_SAVINGS=false
INSTALL_STATUSLINE=false
INSTALL_TIMESHEET=false
INSTALL_SCAFFOLD=false

if [[ "$SELECTION" == "8" ]] || [[ "${SELECTION,,}" == "${STR_ALL,,}" ]] || [[ "${SELECTION,,}" == "todo" ]] || [[ "${SELECTION,,}" == "all" ]]; then
  INSTALL_WORKSPACE=true
  INSTALL_GUARD=true
  INSTALL_RTK=true
  INSTALL_SAVINGS=true
  INSTALL_STATUSLINE=true
  INSTALL_TIMESHEET=true
  INSTALL_SCAFFOLD=true
else
  IFS=',' read -ra CHOICES <<< "$SELECTION"
  for choice in "${CHOICES[@]}"; do
    choice=$(echo "$choice" | tr -d ' ')
    case "$choice" in
      1) INSTALL_WORKSPACE=true ;;
      2) INSTALL_GUARD=true ;;
      3) INSTALL_RTK=true ;;
      4) INSTALL_SAVINGS=true ;;
      5) INSTALL_STATUSLINE=true ;;
      6) INSTALL_TIMESHEET=true ;;
      7) INSTALL_SCAFFOLD=true ;;
    esac
  done
fi

# ── Count selected modules ───────────────────
TOTAL=0
[[ "$INSTALL_WORKSPACE" == true ]] && TOTAL=$((TOTAL + 1))
[[ "$INSTALL_GUARD" == true ]] && TOTAL=$((TOTAL + 1))
[[ "$INSTALL_RTK" == true ]] && TOTAL=$((TOTAL + 1))
[[ "$INSTALL_SAVINGS" == true ]] && TOTAL=$((TOTAL + 1))
[[ "$INSTALL_STATUSLINE" == true ]] && TOTAL=$((TOTAL + 1))
[[ "$INSTALL_TIMESHEET" == true ]] && TOTAL=$((TOTAL + 1))
[[ "$INSTALL_SCAFFOLD" == true ]] && TOTAL=$((TOTAL + 1))
CURRENT=0

# ── Progress helper ───────────────────────────
show_progress() {
  local step=$1
  local total=$2
  local label="$3"
  echo ""
  echo -e "  ${DIM}[${step}/${total}]${NC} ${WHITE}${label}${NC}"
  echo ""
}

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# ── Check Claude Code ────────────────────────
echo -e "  ${DIM}${STR_CHECKING}${NC}"
if ! command -v claude &> /dev/null; then
  echo -e "  ${RED}✗ ${STR_CLAUDE_NOT_FOUND}${NC}"
  echo "    ${STR_CLAUDE_INSTALL} https://docs.anthropic.com/en/docs/claude-code"
  exit 1
fi
echo -e "  ${GREEN}✓${NC} ${STR_CLAUDE_DETECTED}"
echo ""

mkdir -p "$CLAUDE_DIR/commands"
echo -e "  ${GREEN}✓${NC} ${STR_DIR_READY}"
echo ""

# ── /claudekit (siempre se instala) ─────────────
install_base() {
  local src="$SCRIPT_DIR/commands/claudekit.md"
  local dst="$CLAUDE_DIR/commands/claudekit.md"
  if [ -f "$src" ]; then
    cp "$src" "$dst"
    echo -e "  ${GREEN}+${NC} /claudekit ${DIM}— panel de control (siempre incluido)${NC}"
  fi
}
install_base
echo ""

# ── Helper: install command file ─────────────
install_command() {
  local cmd_name="$1"
  local src="$SCRIPT_DIR/commands/${cmd_name}.md"
  local dst="$CLAUDE_DIR/commands/${cmd_name}.md"
  if [ ! -f "$src" ]; then
    return
  fi
  echo -e "  ${DIM}${STR_COPYING}${NC}"
  if [ -f "$dst" ]; then
    echo -e "  ${YELLOW}⟳${NC} ${cmd_name}.md ${STR_ALREADY_EXISTS}"
  else
    cp "$src" "$dst"
    echo -e "  ${GREEN}+${NC} ${cmd_name}.md"
  fi
}

# ── 1. 🧠 /workspace (Brain) ─────────────────
if [[ "$INSTALL_WORKSPACE" == true ]]; then
  CURRENT=$((CURRENT + 1))
  show_progress $CURRENT $TOTAL "🧠 ${STR_F_WORKSPACE}"
  echo -e "  ${DIM}${STR_NARR_WORKSPACE}${NC}"
  echo -e "  ${DIM}${STR_NARR_WORKSPACE2}${NC}"
  echo -e "  ${DIM}${STR_NARR_WORKSPACE3}${NC}"
  echo ""
  install_command "workspace"
  echo ""
  echo -e "  ${YELLOW}⚠${NC} ${STR_OBS_NEED}"
  echo ""
  read -p "  ${STR_OBS_SETUP}" -n 1 -r
  echo ""
  echo ""

  if [[ $REPLY =~ ^[YySs]$ ]] || [[ -z $REPLY ]]; then

    # ── Step 1: Check Obsidian ──
    echo -e "  ${WHITE}${STR_OBS_STEP1}${NC}"
    if [ -d "/Applications/Obsidian.app" ] || command -v obsidian &> /dev/null; then
      echo -e "  ${GREEN}✓${NC} ${STR_OBS_STEP1_OK}"
    else
      echo -e "  ${RED}✗${NC} ${STR_OBS_STEP1_NO}"
      echo -e "    ${CYAN}${STR_OBS_STEP1_URL}${NC}"
      echo ""
      echo -e "  ${DIM}${STR_OBS_STEP1_WAIT}${NC}"
      echo ""
    fi

    # ── Step 2: Local REST API plugin ──
    echo ""
    echo -e "  ${WHITE}${STR_OBS_STEP2}${NC}"
    echo -e "  ${DIM}${STR_OBS_STEP2_1}${NC}"
    echo -e "  ${DIM}${STR_OBS_STEP2_2}${NC}"
    echo -e "  ${DIM}${STR_OBS_STEP2_3}${NC}"
    echo ""
    read -p "  ${STR_OBS_STEP2_ASK}" -n 1 -r
    echo ""
    echo ""

    if [[ $REPLY =~ ^[YySs]$ ]] || [[ -z $REPLY ]]; then

      # ── Step 3: Connect vault(s) ──
      ADDING_VAULTS=true
      while [[ "$ADDING_VAULTS" == true ]]; do
        echo -e "  ${WHITE}${STR_OBS_STEP3}${NC}"
        echo ""
        read -p "  ${STR_OBS_STEP3_NAME}" VAULT_NAME
        read -p "  ${STR_OBS_STEP3_PATH}" VAULT_PATH
        read -p "  ${STR_OBS_STEP3_TOKEN}" VAULT_TOKEN
        echo ""

        if [[ -n "$VAULT_NAME" ]] && [[ -n "$VAULT_PATH" ]] && [[ -n "$VAULT_TOKEN" ]]; then
          echo -e "  ${DIM}${STR_OBS_STEP3_REG}${NC}"
          if claude mcp add "$VAULT_NAME" \
            --env "OBSIDIAN_VAULT_PATH=$VAULT_PATH" \
            --env "OBSIDIAN_API_TOKEN=$VAULT_TOKEN" \
            --env "OBSIDIAN_API_PORT=27123" \
            -- npx -y @huangyihe/obsidian-mcp 2>/dev/null; then
            echo -e "  ${GREEN}✓${NC} ${STR_OBS_STEP3_OK}"
          else
            echo -e "  ${RED}✗${NC} ${STR_OBS_STEP3_FAIL}"
            echo ""
            echo -e "  ${DIM}claude mcp add $VAULT_NAME \\${NC}"
            echo -e "  ${DIM}  --env OBSIDIAN_VAULT_PATH=$VAULT_PATH \\${NC}"
            echo -e "  ${DIM}  --env OBSIDIAN_API_TOKEN=<token> \\${NC}"
            echo -e "  ${DIM}  --env OBSIDIAN_API_PORT=27123 \\${NC}"
            echo -e "  ${DIM}  -- npx -y @huangyihe/obsidian-mcp${NC}"
          fi
          echo ""
        fi

        read -p "  ${STR_OBS_MORE}" -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[YySs]$ ]]; then
          ADDING_VAULTS=false
        fi
        echo ""
      done

      echo -e "  ${GREEN}✓${NC} ${STR_OBS_DONE}"
      echo ""
      echo -e "  ${YELLOW}💡${NC} ${STR_OBS_YAML_TIP}"
      echo -e "     ${STR_OBS_YAML_TIP2}"
      echo ""
      echo -e "     ${DIM}${STR_OBS_YAML_EX1}${NC}"
      echo -e "     ${DIM}${STR_OBS_YAML_EX2}${NC}"
      echo -e "     ${DIM}${STR_OBS_YAML_EX3}${NC}"
      echo -e "     ${DIM}${STR_OBS_YAML_EX4}${NC}"
      echo -e "     ${DIM}${STR_OBS_YAML_EX5}${NC}"
      echo -e "     ${DIM}${STR_OBS_YAML_EX6}${NC}"
      echo -e "     ${DIM}${STR_OBS_YAML_EX7}${NC}"
      echo ""
      echo -e "  ${DIM}${STR_OBS_YAML_TIP3}${NC}"
      echo -e "  ${DIM}${STR_OBS_YAML_TIP4}${NC}"
      echo ""
      echo -e "  ${DIM}${STR_OBS_STEP3_TIP}${NC}"

    else
      echo -e "  ${DIM}${STR_OBS_SKIP}${NC}"
    fi

  else
    echo -e "  ${DIM}${STR_OBS_SKIP}${NC}"
  fi
  echo ""
fi

# ── 2. 🛡 /guard (Security) ──────────────────
if [[ "$INSTALL_GUARD" == true ]]; then
  CURRENT=$((CURRENT + 1))
  show_progress $CURRENT $TOTAL "🛡 ${STR_F_GUARD}"
  echo -e "  ${DIM}${STR_NARR_GUARD}${NC}"
  echo -e "  ${DIM}${STR_NARR_GUARD2}${NC}"
  echo -e "  ${DIM}${STR_NARR_GUARD3}${NC}"
  echo ""
  install_command "guard"
  install_command "lock-claude"
  install_command "unlock-claude"
  echo ""

  # ── npmrc hardening ──
  echo -e "  ${YELLOW}⚠${NC} ${STR_GUARD_NPMRC}"
  echo -e "  ${DIM}${STR_GUARD_NPMRC2}${NC}"
  echo ""

  NPMRC_FILE="$HOME/.npmrc"
  if [ -f "$NPMRC_FILE" ] && grep -q "ignore-scripts=true" "$NPMRC_FILE" 2>/dev/null; then
    echo -e "  ${GREEN}✓${NC} ${STR_GUARD_NPMRC_EXISTS}"
  else
    read -p "  ${STR_GUARD_NPMRC_ASK}" -n 1 -r
    echo ""
    echo ""
    if [[ $REPLY =~ ^[YySs]$ ]] || [[ -z $REPLY ]]; then
      if [ -f "$NPMRC_FILE" ]; then
        echo "ignore-scripts=true" >> "$NPMRC_FILE"
      else
        echo "ignore-scripts=true" > "$NPMRC_FILE"
      fi
      echo -e "  ${GREEN}✓${NC} ${STR_GUARD_NPMRC_OK}"
    else
      echo -e "  ${DIM}${STR_GUARD_NPMRC_SKIP}${NC}"
    fi
  fi
  echo ""

  # ── npm version tip ──
  NPM_VER=$(npm --version 2>/dev/null || echo "0.0.0")
  NPM_MAJOR=$(echo "$NPM_VER" | cut -d. -f1)
  NPM_MINOR=$(echo "$NPM_VER" | cut -d. -f2)
  if [[ "$NPM_MAJOR" -lt 11 ]] || [[ "$NPM_MAJOR" -eq 11 && "$NPM_MINOR" -lt 10 ]]; then
    echo -e "  ${DIM}$(printf "$STR_GUARD_NPM_TIP" "$NPM_VER")${NC}"
    echo -e "  ${DIM}${STR_GUARD_NPM_TIP2}${NC}"
    echo ""
  fi

  # ── lock/unlock tip ──
  echo -e "  ${DIM}${STR_GUARD_LOCK_TIP}${NC}"
  echo -e "  ${DIM}${STR_GUARD_LOCK_TIP2}${NC}"
  echo ""
fi

# ── 3. ⚡ RTK ────────────────────────────────
if [[ "$INSTALL_RTK" == true ]]; then
  CURRENT=$((CURRENT + 1))
  show_progress $CURRENT $TOTAL "⚡ ${STR_F_RTK}"
  echo -e "  ${DIM}${STR_NARR_RTK}${NC}"
  echo -e "  ${DIM}${STR_NARR_RTK2}${NC}"
  echo -e "  ${DIM}${STR_NARR_RTK3}${NC}"
  echo ""
  if command -v rtk &> /dev/null; then
    RTK_VER=$(rtk --version 2>/dev/null || echo "unknown")
    echo -e "  ${GREEN}✓${NC} ${STR_RTK_INSTALLED} ($RTK_VER)"
    if rtk gain &> /dev/null; then
      echo -e "  ${GREEN}✓${NC} ${STR_RTK_VERIFIED}"
    else
      echo -e "  ${YELLOW}⚠${NC} ${STR_RTK_WRONG}"
      echo "    https://github.com/rtk-ai/rtk#installation"
    fi
  else
    echo -e "  ${YELLOW}⚠${NC} ${STR_RTK_NOT_INSTALLED}"
    echo ""
    read -p "  ${STR_RTK_ASK}" -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[YySs]$ ]] || [[ -z $REPLY ]]; then
      echo -e "  ${DIM}${STR_RTK_INSTALLING}${NC}"
      curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/master/install.sh | bash
      if command -v rtk &> /dev/null; then
        echo -e "  ${GREEN}✓${NC} ${STR_RTK_SUCCESS}"
        echo -e "  ${DIM}${STR_RTK_HOOKS}${NC}"
      else
        echo -e "  ${RED}✗${NC} ${STR_RTK_FAIL}"
        echo "    https://github.com/rtk-ai/rtk"
      fi
    else
      echo -e "  ${STR_RTK_SKIP} ${CYAN}https://github.com/rtk-ai/rtk${NC}"
    fi
  fi
  echo ""
fi

# ── 4. 💰 /savings ──────────────────────────
if [[ "$INSTALL_SAVINGS" == true ]]; then
  CURRENT=$((CURRENT + 1))
  show_progress $CURRENT $TOTAL "💰 ${STR_F_SAVINGS}"
  echo -e "  ${DIM}${STR_NARR_SAVINGS}${NC}"
  echo -e "  ${DIM}${STR_NARR_SAVINGS2}${NC}"
  echo -e "  ${DIM}${STR_NARR_SAVINGS3}${NC}"
  echo ""
  install_command "savings"
  echo ""
fi

# ── 5. 📊 Statusline ────────────────────────
if [[ "$INSTALL_STATUSLINE" == true ]]; then
  CURRENT=$((CURRENT + 1))
  show_progress $CURRENT $TOTAL "📊 ${STR_F_STATUSLINE}"
  echo -e "  ${DIM}${STR_NARR_STATUSLINE}${NC}"
  echo -e "  ${DIM}${STR_NARR_STATUSLINE2}${NC}"
  echo -e "  ${DIM}${STR_NARR_STATUSLINE3}${NC}"
  echo ""
  if [ -f "$SCRIPT_DIR/statusline.sh" ]; then
    if [ -f "$CLAUDE_DIR/statusline.sh" ]; then
      echo -e "  ${YELLOW}⟳${NC} ${STR_SL_EXISTS}"
      cp "$CLAUDE_DIR/statusline.sh" "$CLAUDE_DIR/statusline.sh.bak"
    fi
    cp "$SCRIPT_DIR/statusline.sh" "$CLAUDE_DIR/statusline.sh"
    chmod +x "$CLAUDE_DIR/statusline.sh"
    echo -e "  ${GREEN}✓${NC} ${STR_SL_INSTALLED}"
  fi
  echo ""
fi

# ── 6. 🕐 /timesheet ───────────────────────
if [[ "$INSTALL_TIMESHEET" == true ]]; then
  CURRENT=$((CURRENT + 1))
  show_progress $CURRENT $TOTAL "🕐 ${STR_F_TIMESHEET}"
  echo -e "  ${DIM}${STR_NARR_TIMESHEET}${NC}"
  echo -e "  ${DIM}${STR_NARR_TIMESHEET2}${NC}"
  echo -e "  ${DIM}${STR_NARR_TIMESHEET3}${NC}"
  echo ""
  install_command "timesheet"
  echo ""
fi

# ── 7. 📁 Scaffold ──────────────────────────
if [[ "$INSTALL_SCAFFOLD" == true ]]; then
  CURRENT=$((CURRENT + 1))
  show_progress $CURRENT $TOTAL "📁 ${STR_F_SCAFFOLD}"
  echo ""
  echo -e "  ${WHITE}${STR_SCAFFOLD_ASK}${NC}"
  echo ""
  read -p "  ${STR_SCAFFOLD_PATH}" SCAFFOLD_PATH
  echo ""

  if [ ! -d "$SCAFFOLD_PATH" ]; then
    echo -e "  ${RED}✗${NC} ${STR_SCAFFOLD_NOT_FOUND}"
    echo ""
  else
    read -p "  ${STR_SCAFFOLD_NAME}" SCAFFOLD_NAME
    read -p "  ${STR_SCAFFOLD_DESC}" SCAFFOLD_DESC
    echo ""
    echo -e "  ${DIM}${STR_SCAFFOLD_CREATING}${NC}"
    echo ""

    # Day 1 structure (essential only)
    mkdir -p "$SCAFFOLD_PATH/.claude/commands"
    mkdir -p "$SCAFFOLD_PATH/.claude/rules"
    mkdir -p "$SCAFFOLD_PATH/inputs"
    mkdir -p "$SCAFFOLD_PATH/docs"

    # CLAUDE.md template
    CLAUDE_FILE="$SCAFFOLD_PATH/CLAUDE.md"
    if [ -f "$CLAUDE_FILE" ]; then
      echo -e "  ${YELLOW}⟳${NC} CLAUDE.md ${STR_SCAFFOLD_EXISTS}"
    else
      cat > "$CLAUDE_FILE" << CLAUDEEOF
# ${SCAFFOLD_NAME}

## What is this project
${SCAFFOLD_DESC}

**Stack:** <!-- e.g. Next.js 14 + TypeScript + Tailwind CSS -->
**Deploy:** <!-- e.g. Vercel, AWS, local -->

## Your role
<!-- What should Claude do in this project? e.g. "You are the frontend developer" -->

## Project structure
\`\`\`
${SCAFFOLD_NAME}/
├── CLAUDE.md              ← you are here
├── .claude/
│   ├── settings.json      ← permissions and tools
│   ├── commands/          ← slash commands (/review, /audit...)
│   └── rules/             ← auto-activated rules by path
├── docs/                  ← product vision, decisions, references
├── inputs/                ← client materials (read-only)
└── ...                    ← your source code
\`\`\`

## Key files
- \`docs/\` — project references and decisions
- \`inputs/\` — client materials, briefings, brand assets (read-only)

## Conventions
<!-- Naming, coding style, design principles, restrictions -->

## What NOT to do
<!-- Things Claude should avoid in this project -->
CLAUDEEOF
      echo -e "  ${GREEN}+${NC} CLAUDE.md"
    fi

    # .claude/settings.json (only if missing)
    SETTINGS_FILE="$SCAFFOLD_PATH/.claude/settings.json"
    if [ -f "$SETTINGS_FILE" ]; then
      echo -e "  ${YELLOW}⟳${NC} .claude/settings.json ${STR_SCAFFOLD_EXISTS}"
    else
      cat > "$SETTINGS_FILE" << 'SETTINGSEOF'
{
  "permissions": {},
  "hooks": {}
}
SETTINGSEOF
      echo -e "  ${GREEN}+${NC} .claude/settings.json"
    fi

    # docs/decisions-log.md
    DECISIONS_FILE="$SCAFFOLD_PATH/docs/decisions-log.md"
    if [ -f "$DECISIONS_FILE" ]; then
      echo -e "  ${YELLOW}⟳${NC} docs/decisions-log.md ${STR_SCAFFOLD_EXISTS}"
    else
      SCAFFOLD_DATE=$(date +%Y-%m-%d)
      cat > "$DECISIONS_FILE" << DECISIONSEOF
# Decisions Log

| Date | Decision | Why | Who |
|------|----------|-----|-----|
| ${SCAFFOLD_DATE} | Project created with ClaudeKit scaffold | Starting point | $(whoami) |
DECISIONSEOF
      echo -e "  ${GREEN}+${NC} docs/decisions-log.md"
    fi

    # .npmrc (security hardening)
    NPMRC_FILE="$SCAFFOLD_PATH/.npmrc"
    if [ -f "$NPMRC_FILE" ]; then
      echo -e "  ${YELLOW}⟳${NC} .npmrc ${STR_SCAFFOLD_EXISTS}"
    else
      echo "ignore-scripts=true" > "$NPMRC_FILE"
      echo -e "  ${GREEN}+${NC} .npmrc"
    fi

    echo -e "  ${GREEN}+${NC} .claude/commands/"
    echo -e "  ${GREEN}+${NC} .claude/rules/"
    echo -e "  ${GREEN}+${NC} inputs/"
    echo ""
    echo -e "  ${GREEN}✓${NC} ${STR_SCAFFOLD_DONE}"
    echo ""
    echo -e "  ${STR_SCAFFOLD_TREE}"
    echo ""
    echo -e "  ${DIM}  ${SCAFFOLD_NAME}/${NC}"
    echo -e "  ${DIM}  ├── CLAUDE.md${NC}"
    echo -e "  ${DIM}  ├── .npmrc${NC}"
    echo -e "  ${DIM}  ├── .claude/${NC}"
    echo -e "  ${DIM}  │   ├── settings.json${NC}"
    echo -e "  ${DIM}  │   ├── commands/${NC}"
    echo -e "  ${DIM}  │   └── rules/${NC}"
    echo -e "  ${DIM}  ├── docs/${NC}"
    echo -e "  ${DIM}  │   └── decisions-log.md${NC}"
    echo -e "  ${DIM}  └── inputs/${NC}"
    echo ""
    echo -e "  ${YELLOW}💡${NC} ${STR_SCAFFOLD_NEXT}"
    echo ""
  fi
fi

# ── Summary ──────────────────────────────────
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  ${KIT_HEAD_OK}  ${STR_DONE}${NC}"
echo -e "${GREEN}  ${KIT_BODY_OK}${NC}"
echo -e "${GREEN}  ${KIT_LEGS_OK}${NC}"
echo ""
echo "  ${STR_INSTALLED_SUMMARY}"
echo ""
echo -e "    🛠  /claudekit"
[[ "$INSTALL_WORKSPACE" == true ]] && echo -e "    🧠 ${STR_F_WORKSPACE}"
[[ "$INSTALL_GUARD" == true ]] && echo -e "    🛡 ${STR_F_GUARD} (+ /lock-claude + /unlock-claude)"
[[ "$INSTALL_RTK" == true ]] && echo -e "    ⚡ ${STR_F_RTK}"
[[ "$INSTALL_SAVINGS" == true ]] && echo -e "    💰 ${STR_F_SAVINGS}"
[[ "$INSTALL_STATUSLINE" == true ]] && echo -e "    📊 ${STR_F_STATUSLINE}"
[[ "$INSTALL_TIMESHEET" == true ]] && echo -e "    🕐 ${STR_F_TIMESHEET}"
[[ "$INSTALL_SCAFFOLD" == true ]] && echo -e "    📁 ${STR_F_SCAFFOLD}"
echo ""
echo "  ${STR_NEXT}"
echo "    ${STR_NEXT_1}"
echo "    ${STR_NEXT_2}"
if [[ "$INSTALL_RTK" == true ]] && ! command -v rtk &> /dev/null; then
  echo "    ${STR_NEXT_3} https://github.com/rtk-ai/rtk"
fi
echo ""
echo -e "  ${DIM}${STR_CLAUKIT}${NC}"
echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${DIM}───${NC} ☕️❤️  ${DIM}───────────────────────────────────────────${NC}"
echo ""
echo -e "  ${STR_CTA_1} ${STR_CTA_2}"
echo -e "  ${DIM}   ${STR_CTA_3}${NC}"
echo ""
echo -e "  ${YELLOW}→${NC} ${CYAN}https://bit.ly/guille-kofi${NC}"
echo ""
echo -e "${DIM}  ─────────────────────────────────────────────────────────${NC}"
echo ""
echo -e "  ${DIM}by${NC} ${WHITE}Guille Varela${NC} ${DIM}— UX/UI & Design Engineer${NC}"
echo -e "  ${DIM}LinkedIn:${NC} ${CYAN}linkedin.com/in/guillevarela${NC}"
echo -e "  ${DIM}Web:${NC} ${CYAN}nodox.studio${NC}  ${DIM}|${NC}  ${DIM}Contact:${NC} somos@nodox.studio  ${DIM}|${NC}  ${DIM}Terms:${NC} ${CYAN}github.com/nodox-studio/claudekit/.../TERMS.md${NC}"
echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
