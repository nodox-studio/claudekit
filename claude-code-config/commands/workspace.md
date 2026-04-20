# /workspace — Project selector

Switch between your workspaces and load context from your Obsidian vaults via MCP.

## Step 1: List available vaults

Check which MCP servers are connected. Look for servers with Obsidian tools (list_notes, search_vault, read_note).

Show a welcome menu with detected workspaces:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Where are we working today?

  1. ■ Vault-Name-1
  2. ● Vault-Name-2
  ...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Wait for the user to pick (1/2/... or by name).

## Step 2: Load context

Based on the choice:

1. Use `search_vault` from the selected MCP to find notes tagged `#active` or `#wip`.
2. Use `list_notes` to see the vault structure.
3. Read the YAML frontmatter of each matching note to extract: `project`, `path`, `updated`, `updated_by`.
4. Identify active projects, their status, and when they were last touched.

## Step 3: Show project summary

Present a compact summary with **numbered** projects for quick selection:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ■ VAULT NAME — Current status
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Active projects:
  1. Project A — brief status     Apr 20 · you
  2. Project B — brief status     Apr 19 · claude
  3. Project C — brief status     Apr 18 · you

  Which project? (1-N)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Wait for the user to pick by number or name.

## Step 4: Open project

When the user picks a project:

1. `cd` to the project directory.
2. Briefly confirm you're in the project and ready to work.

## Recommended note structure

For `/workspace` to find your projects automatically, use this YAML frontmatter in your Obsidian notes:

```yaml
---
tags: [active]
project: my-project
path: /Users/you/code/my-project
updated: 2026-04-20
updated_by: claude-session-abc123
---
```

### Properties explained

| Property | What it does |
|----------|-------------|
| `tags` | Use `active` for current projects, `wip` for work in progress, remove tag when done |
| `project` | Short name for the project (used to identify it in the menu) |
| `path` | Full path to the project directory — Claude uses this to `cd` into it |
| `updated` | Date of last edit (YYYY-MM-DD). Claude updates this when it modifies the note |
| `updated_by` | Who last edited: your name or `claude-session-XXXXX` (the session ID) |

### How Claude should update notes

When Claude modifies a project note via MCP, it must update the frontmatter:

1. Set `updated` to today's date
2. Set `updated_by` to `claude-session-` followed by the current session ID (or `claude` if the session ID is not available)

This way you always know when a note was last touched and whether it was you or Claude who edited it.

### Minimum example

```markdown
---
tags: [active]
project: my-app
path: /Users/me/projects/my-app
updated: 2026-04-20
updated_by: guille
---

# My App

Current focus: redesigning the dashboard.
Next: connect the new API endpoints.
```

## No MCP connected?

If no Obsidian MCP is detected, tell the user:

```
No Obsidian vaults connected. To set one up:

1. Install Obsidian → https://obsidian.md
2. Enable the "Local REST API" plugin in Obsidian
3. Register the MCP:

   claude mcp add my-vault \
     --env OBSIDIAN_VAULT_PATH=/path/to/vault \
     --env OBSIDIAN_API_TOKEN=your-token \
     --env OBSIDIAN_API_PORT=27123 \
     -- npx -y @huangyihe/obsidian-mcp

4. Restart Claude Code
```
