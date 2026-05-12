# Documentation AgentMemory

AgentMemory est le composant central de la couche mémoire de l'Agentic OS. Il capture, compresse et indexe les interactions des agents.

## Installation et Démarrage

AgentMemory est installé via npm. Pour démarrer le serveur :

```bash
npm run dev
```

Le serveur écoute par défaut sur le port `3111` pour l'API REST et fournit des outils MCP.

## Intégration avec Obsidian Vault

Pour synchroniser la mémoire avec une base de connaissances Obsidian locale :

1. Définissez `CHEMIN_VAULT_OBSIDIAN` dans votre `.env`.
2. Les notes Markdown créées dans Obsidian seront indexées et disponibles pour la recherche sémantique par les agents.
3. Un fichier `CONTEXT_INDEX.md` est généré pour lister les notes disponibles.

## Consolidation et Purge

AgentMemory inclut des mécanismes pour éviter la saturation :
- **Compression automatique** : Les longs historiques de conversation sont résumés.
- **Purge des données obsolètes** : Configurez des règles de rétention pour supprimer les données de plus de X jours.
- **Anonymisation** : Les données sensibles (clés, mots de passe) détectées sont masquées avant stockage.

## Visualisation

AgentMemory inclut un viewer web pour inspecter la mémoire et rejouer les sessions.
Lancez-le via (si configuré) :
```bash
npm run viewer
```
Il permet de vérifier la précision de la récupération (Recall) et l'utilisation des tokens.
