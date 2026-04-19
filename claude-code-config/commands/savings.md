# /savings — Token savings dashboard

Muestra el ahorro de tokens de RTK para el proyecto actual y global, con estimación de coste.

## Instrucciones

1. Ejecuta `rtk gain --project` para obtener datos del proyecto actual
2. Ejecuta `rtk gain --quota` para obtener datos globales y de quota
3. Presenta un resumen compacto y visual con este formato:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  RTK — Token Savings Dashboard
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  📂 Proyecto: [nombre del directorio]
  ─────────────────────────────────
  Comandos:    XXX
  Tokens saved: XXX (XX.X%)
  Ahorro est.: ~$XX.XX
  Efficiency:  ████████████░░░░ XX%

  🌐 Global (todos los proyectos)
  ─────────────────────────────────
  Comandos:    XXX
  Tokens saved: XXX (XX.X%)
  Ahorro est.: ~$XX.XX
  Efficiency:  ████████████░░░░ XX%

  💰 Quota (Max 20x)
  ─────────────────────────────────
  Quota mensual:    XXX
  Quota preservada: XX%

  Top 5 comandos (proyecto):
  1. comando — XXK saved (XX%)
  2. ...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

4. Para el cálculo de ahorro en $, usa: tokens_saved × $30 / 1.000.000 (blended Opus rate: 75% input a $15/M + 25% output a $75/M)
5. Extrae los datos parseando la salida de `rtk gain`. Campos clave:
   - "Tokens saved:" → número + porcentaje
   - "Total commands:" → count
   - La tabla "By Command" → top 5
6. No uses emojis si el usuario no los tiene habilitados en su config. Usa los del formato de arriba como referencia.
