# /timesheet — Time tracking dashboard

Analyze Claude Code session logs and show a per-project time report.

## How to get the data

1. List all project directories inside `~/.claude/projects/`. Each directory name is an encoded project path (dashes replace slashes, e.g. `-Users-guillermo-varela-Documents-myproject`).

2. For each project directory, list all `.jsonl` files (each file = one session).

3. For each session JSONL file, read the **first line** and the **last line** to extract timestamps. Calculate:
   - **Total time** = last timestamp - first timestamp
   - **Active time** = sum of intervals between consecutive messages where the gap is < 5 minutes. Gaps longer than 5 minutes count as standby (user was away).
   - To calculate active time accurately, read all lines and extract the `timestamp` field from each record that has one. Sum only the intervals between consecutive timestamps where `(next - previous) < 5 minutes`.

4. Decode the project name from the directory name: strip the leading dash, replace remaining dashes with slashes to reconstruct the path, then take the last 1-2 meaningful directory names as the display name (e.g. `/Users/me/projects/claudekit/dev` → `claudekit/dev`).

5. Determine **status** based on the most recent session's last timestamp:
   - `active` — last session today
   - `recent` — last session within 7 days
   - `paused` — last session within 30 days
   - `inactive` — more than 30 days ago

## How to display

Present a compact table sorted by most recent activity first:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  /timesheet — Time Report
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Project              Sessions   Active     Last session    Status
  ─────────────────────────────────────────────────────────────
  claudekit/dev        12         4h 32m     today           active
  skiller/dev          28         12h 05m    3 days ago      recent
  rocha-blast          8          2h 15m     2 weeks ago     paused
  sinestesia           3          45m        3 weeks ago     inactive
  ─────────────────────────────────────────────────────────────
  TOTAL                51         19h 37m

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Status indicators

Use these labels (no emojis):
- `active` — green if terminal supports it
- `recent` — default color
- `paused` — dim/yellow
- `inactive` — dim/gray

## Formatting rules

- Sort by last session date, most recent first.
- Times under 1 hour: show as `XXm` (e.g. `45m`).
- Times over 1 hour: show as `Xh XXm` (e.g. `4h 32m`).
- "Last session" shows relative time: `today`, `yesterday`, `3 days ago`, `2 weeks ago`, `1 month ago`.
- TOTAL row at the bottom sums sessions and active time across all projects.
- Skip projects with only 1 session shorter than 1 minute (noise from accidental opens).

## Performance

Session JSONL files can be large (up to 5MB+). To avoid reading entire files:
- For total time: read only the first and last lines.
- For active time: if the file is larger than 100KB, sample the timestamps (read first 20 lines, last 20 lines, and estimate). For files under 100KB, read all lines.
- Cache nothing — always read fresh data so the report is current.

## Bilingual

If the user's system or conversation is in Spanish, show labels in Spanish:
- "Time Report" → "Reporte de Tiempo"
- "Sessions" → "Sesiones"
- "Active" → "Activo"
- "Last session" → "Ultima sesion"
- "Status" → "Estado"
- "today" → "hoy"
- "yesterday" → "ayer"
- "X days ago" → "hace X dias"
- "X weeks ago" → "hace X sem"
- "active" → "activo"
- "recent" → "reciente"
- "paused" → "pausado"
- "inactive" → "inactivo"
