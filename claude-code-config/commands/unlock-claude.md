---
allowed-tools: Bash, Read
description: Temporarily remove deny rules that protect Claude's own config, so Claude can edit settings.json and hooks. Run /lock-claude when done.
user-invocable: true
---

Remove the self-protection deny rules from ~/.claude/settings.json so I can edit my own config and hooks temporarily.

Steps:
1. Read ~/.claude/settings.json
2. Run a python3 script that removes ONLY these 4 deny rules:
   - Edit(~/.claude/settings.json)
   - Edit(~/.claude/hooks/*)
   - Write(~/.claude/settings.json)
   - Write(~/.claude/hooks/*)
3. Confirm to the user that config is now unlocked
4. Remind the user to run /lock-claude when done

Use this python3 one-liner via Bash:
```
python3 -c "
import json
p = '/Users/guillermo.varela/.claude/settings.json'
with open(p) as f:
    cfg = json.load(f)
deny = cfg['permissions']['deny']
targets = ['Edit(~/.claude/settings.json)', 'Edit(~/.claude/hooks/*)', 'Write(~/.claude/settings.json)', 'Write(~/.claude/hooks/*)']
for t in targets:
    if t in deny:
        deny.remove(t)
with open(p, 'w') as f:
    json.dump(cfg, f, indent=2)
    f.write('\n')
print('Unlocked')
"
```

IMPORTANT: After unlocking, show this message exactly:

---
**Config desbloqueada.** Ahora puedo editar settings.json y hooks.

Cuando terminemos, ejecuta `/lock-claude` para restaurar la proteccion.

---
