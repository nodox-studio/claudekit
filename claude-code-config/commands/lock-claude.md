---
allowed-tools: Bash, Read
description: Restore deny rules that prevent Claude from editing its own config and hooks. Use after /unlock-claude.
user-invocable: true
---

Re-add the self-protection deny rules to ~/.claude/settings.json.

Steps:
1. Read ~/.claude/settings.json
2. Run a python3 script that adds these 4 deny rules (if not already present):
   - Edit(~/.claude/settings.json)
   - Edit(~/.claude/hooks/*)
   - Write(~/.claude/settings.json)
   - Write(~/.claude/hooks/*)
3. Confirm to the user that config is now locked

Use this python3 one-liner via Bash:
```
python3 -c "
import json
import os
p = os.path.join(os.path.expanduser('~'), '.claude', 'settings.json')
with open(p) as f:
    cfg = json.load(f)
deny = cfg['permissions']['deny']
targets = ['Edit(~/.claude/settings.json)', 'Edit(~/.claude/hooks/*)', 'Write(~/.claude/settings.json)', 'Write(~/.claude/hooks/*)']
for t in targets:
    if t not in deny:
        deny.append(t)
with open(p, 'w') as f:
    json.dump(cfg, f, indent=2)
    f.write('\n')
print('Locked')
"
```

IMPORTANT: After locking, show this message exactly:

---
**Config bloqueada.** Ya no puedo editar mis propios settings ni hooks.

Si necesitas desbloquearme de nuevo, ejecuta `/unlock-claude`.

---
