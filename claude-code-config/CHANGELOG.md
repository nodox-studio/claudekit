# Changelog

All notable changes to ClaudeKit will be documented in this file.

## [Unreleased]

### Security
- **Hardened RTK install** — Replaced `curl|bash` with download-then-execute pattern (temp file + cleanup)
- **Removed hardcoded user path** — `lock-claude.md` and `unlock-claude.md` now use `os.path.expanduser('~')` instead of `/Users/guillermo.varela/`
- **Session timer moved from `/tmp/`** — Now uses `~/.claude/.session-timers/` to prevent symlink attacks
- **Obsidian token input hidden** — `read -s` hides API token while typing
- **Pinned `@huangyihe/obsidian-mcp@1.6.0`** — Prevents supply chain risk from unpinned `npx -y`
- **Scaffold path validation** — Resolves with `realpath` to prevent path traversal
- **`$LANG` → `$CK_LANG`** — No longer overwrites system locale variable

### Added
- **`/guard` — Security dashboard** — Reviews environment security (npmrc, config protection, dependencies). Installs `/lock-claude` and `/unlock-claude` as a single security package. Includes npmrc hardening (`ignore-scripts=true`), npm version check for `min-release-age`, and project-level `.npmrc` support.
- **Advanced security recommendations** — `/guard` links to `anthropics/claude-code-security-review` (GitHub Action), `latiotech/secure-supply-chain-skills` (supply chain audit), and `attach-dev/attach-guard` (Socket.dev hook).
- **Scaffold includes `.npmrc`** — New projects created with scaffold now include `.npmrc` with `ignore-scripts=true` for security by default.
- **`/timesheet`** — Time tracking command that reads Claude Code session logs and shows per-project time reports with sessions, active hours, and status.
- **Scaffold** — Creates Day 1 project structure for any Claude Code project: `CLAUDE.md` template, `.claude/` folder with settings, commands, and rules, `docs/decisions-log.md`, `inputs/`, and `.npmrc`.
- **YAML frontmatter guide** — `/workspace` now documents the recommended frontmatter for Obsidian notes (`tags`, `project`, `path`, `updated`, `updated_by`). Claude updates `updated` and `updated_by` automatically when editing notes.
- **`/claudekit` slash command** — Control panel with 4 sections: Cerebro, Seguridad, Ahorro, Tiempo. Diagnoses installed modules, shows status, and lets you install/uninstall/configure features.
- **Bilingual installer** (EN/ES) with interactive feature selector and guided Obsidian MCP setup.
- **Beginner-friendly descriptions** — All tool descriptions rewritten for users new to Claude Code.
- **Kit the sheep** — Seasonal ASCII mascot. Woolly in winter (`@>` + `.@@@@`), sheared in summer (`@>` + `.__`).

### Changed
- **Renamed** from ClauKit to **ClaudeKit** across all files, commands, and branding.
- **Renamed** repo from `nodox-open` to `claudekit`.
- **Menu restructured** into 5 categories: Cerebro (1), Seguridad (2), Ahorro (3-5), Tiempo (6), Inicio (7). Option 8 installs all.
- **Lock/unlock merged into /guard** — No longer separate menu items. Installed together as part of the security package.
- **Progress indicator** simplified to minimal `[1/7]` counter format.
- `/workspace` description: "Centraliza tu conocimiento en un solo lugar y deja que Claude lo use."

## [0.1.0] — 2026-04-19

### Added
- Initial release as "Claude Code Config".
- Slash commands: `/workspace`, `/savings`, `/lock-claude`, `/unlock-claude`, `/tuning`.
- `statusline.sh` — Status bar with cost, context, model, and RTK savings.
- `install.sh` — Basic installer script.
- RTK integration for token savings.
