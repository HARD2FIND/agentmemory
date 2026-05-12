# Guide des Workflows n8n

Ce dossier contient les workflows n8n exportés au format JSON.

## Workflows disponibles

| Fichier | Description | Déclencheur |
|---|---|---|
| `memory_sync_template.json` | Synchronise la mémoire AgentMemory vers Obsidian | Cron quotidien |

## Importer un workflow

1. Accédez à votre instance n8n.
2. Cliquez sur "Add workflow" > "Import from file".
3. Sélectionnez le fichier JSON correspondant.
4. Configurez les credentials nécessaires.
5. Activez le workflow.

## Exporter un workflow

Pour versionner un workflow après modification :
1. Dans n8n, ouvrez le workflow.
2. Cliquez sur les trois points > "Download".
3. Remplacez le fichier JSON dans ce dossier.
4. Commitez le changement sur GitHub.
