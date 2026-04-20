# /guard — Security dashboard

Review and configure security settings for your Claude Code environment.

## Allowed tools
- Bash
- Read

## What to check

### 1. npmrc hardening

Check if `~/.npmrc` exists and contains security settings.

Run: `cat ~/.npmrc 2>/dev/null`
Also check project-level: `cat .npmrc 2>/dev/null`

Look for:
- `ignore-scripts=true` — prevents npm packages from running arbitrary scripts during install
- `min-release-age=7` — blocks packages published less than 7 days ago (requires npm >= 11.10.0)

### 2. Config protection (lock status)

Check if deny rules are active in `~/.claude/settings.json`. Look for deny entries matching:
- `Edit(~/.claude/settings.json)`
- `Write(~/.claude/settings.json)`
- `Edit(~/.claude/hooks/*)`
- `Write(~/.claude/hooks/*)`

Run: `cat ~/.claude/settings.json` and parse the deny array.

### 3. npm version

Check if npm supports `min-release-age`:
Run: `npm --version`
- If >= 11.10.0: compatible
- If < 11.10.0: show upgrade tip (`npm install -g npm@latest`)

### 4. Lock files

Check if the current project has lock files:
- `package-lock.json`, `yarn.lock`, `pnpm-lock.yaml`, `bun.lockb`

If no lock file exists, warn the user.

## Display format

Present a compact dashboard:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  /guard — Security Status
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  npmrc (global)
  ─────────────────────────────────────
  ✓ ignore-scripts      active
  ✗ min-release-age     not set (needs npm >= 11.10.0)

  Config protection
  ─────────────────────────────────────
  ✓ Locked              4 deny rules active

  Project: my-project
  ─────────────────────────────────────
  ✓ Lock file           package-lock.json
  ✗ .npmrc              not found

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Actions:
  1. Toggle npmrc hardening (global)
  2. Toggle config protection (/lock or /unlock)
  3. Add .npmrc to current project
  4. Show advanced tools
  5. ← Back

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Use ✓ for active/present and ✗ for missing/inactive.

## Actions

### 1. Toggle npmrc hardening (global)

If `ignore-scripts=true` is NOT in `~/.npmrc`:
- Append `ignore-scripts=true` to `~/.npmrc` (create file if needed)
- Confirm: "npmrc hardened. Packages can no longer run scripts during install."

If it IS already set:
- Ask user if they want to remove it
- Warn: "This allows packages to run arbitrary scripts during install. Are you sure?"

### 2. Toggle config protection

- If locked → explain current protection, offer to unlock (same logic as /unlock-claude)
- If unlocked → explain risk, offer to lock (same logic as /lock-claude)
- After toggling, remind user of the opposite command

### 3. Add .npmrc to current project

Create `.npmrc` in the current project directory with:
```
ignore-scripts=true
```

If the file already exists, show its current content and offer to add the missing line.

### 4. Show advanced tools

Display recommendations for users who want deeper security:

```
  Advanced security tools:
  ─────────────────────────────────────

  CI: anthropics/claude-code-security-review
  GitHub Action that reviews PRs for vulnerabilities.
  → github.com/anthropics/claude-code-security-review

  Audit: latiotech/secure-supply-chain-skills
  Claude Code plugin with /audit-supply-chain command.
  → github.com/latiotech/secure-supply-chain-skills

  Guard: attach-dev/attach-guard
  PreToolUse hook that checks packages against Socket.dev.
  → github.com/attach-dev/attach-guard
```

## How lock/unlock interacts with security

Lock protects `~/.claude/settings.json` and `~/.claude/hooks/*` from being edited by Claude. This means:
- Security hooks already in place KEEP working (hooks run before permission checks)
- Claude CANNOT remove or weaken security settings while locked
- To change security settings, the user must unlock first, then re-lock

This is the correct behavior. Lock = immutable security. Explain this to the user if they ask.

## Bilingual

If the user's system or conversation is in Spanish:
- "Security Status" → "Estado de Seguridad"
- "active" → "activo"
- "not set" → "no configurado"
- "not found" → "no encontrado"
- "Config protection" → "Protección de config"
- "Locked" → "Bloqueado"
- "Unlocked" → "Desbloqueado"
- "deny rules active" → "reglas deny activas"
- "Lock file" → "Archivo de bloqueo"
- "Actions" → "Acciones"
- "Toggle npmrc hardening" → "Activar/desactivar npmrc"
- "Toggle config protection" → "Activar/desactivar protección"
- "Add .npmrc to current project" → "Añadir .npmrc al proyecto"
- "Show advanced tools" → "Ver herramientas avanzadas"
- "Back" → "Volver"
- "Advanced security tools" → "Herramientas avanzadas de seguridad"
