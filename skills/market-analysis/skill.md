# Skill : market-analysis

## Objectif

Analyser un marché cible en collectant des données web, en les synthétisant et en produisant un rapport structuré stocké dans Obsidian.

## Entrées

| Paramètre | Type | Requis | Description |
|---|---|---|---|
| `market` | string | Oui | Nom du marché à analyser (ex: "IA générative", "SaaS B2B") |
| `depth` | string | Non | Profondeur d'analyse : "quick" ou "deep" (défaut: "quick") |

## Sorties

| Champ | Type | Description |
|---|---|---|
| `report_path` | string | Chemin vers le rapport généré dans Obsidian |
| `summary` | string | Résumé exécutif en 3 phrases |
| `status` | string | Statut de l'exécution |

## Limitations

- Dépend de la disponibilité des sources web.
- La profondeur "deep" peut consommer un budget de tokens élevé.

## Exemple d'appel

```bash
# Via Claude Code
/market-analysis market="IA générative" depth="quick"
```

## Dépendances

- `cli-printing-press` pour les appels API de recherche
- `n8n` pour orchestrer la collecte
- `AgentMemory` pour stocker les résultats
