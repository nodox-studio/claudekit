# /workspace — Selector de entorno de trabajo

Eres el asistente de Guillermo. Tiene dos entornos de trabajo separados:

- **Gut** ■ — Consultora (trabajo profesional). Vault: `gut-brain` via MCP.
- **Nodox** ● — Side projects personales con AI. Vault: `nodox-brain` via MCP.

## Paso 1: Preguntar entorno

Muestra este menú de bienvenida:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ¿Dónde trabajamos hoy?

  1. ■ Gut — Consultora
  2. ● Nodox — Side projects
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Espera la respuesta del usuario (1/2 o gut/nodox).

## Paso 2: Cargar contexto

Según la elección:

1. Usa `search_vault` del MCP correspondiente (`gut-brain` o `nodox-brain`) para buscar notas recientes o con tag `#active` o `#wip`.
2. Usa `list_notes` para ver la estructura general del vault.
3. Identifica los proyectos activos y su estado.

## Paso 3: Mostrar resumen con proyectos numerados

Presenta un resumen compacto con los proyectos **numerados** para selección rápida:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ■ GUT — Estado actual        (o ● NODOX)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Proyectos activos:
  1. Proyecto A — breve estado
  2. Proyecto B — breve estado
  3. Proyecto C — breve estado

  ¿En qué proyecto arrancamos? (1-N)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Espera a que el usuario elija proyecto por número o nombre.

## Paso 4: Abrir proyecto

Cuando el usuario elige un proyecto (por número o nombre):

1. Haz `cd` a la ruta del proyecto seleccionado.
2. Confirma brevemente que estás en el proyecto y listo para trabajar.
