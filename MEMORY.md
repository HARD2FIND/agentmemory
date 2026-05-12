# Documentation AgentMemory et Intégration Obsidian

AgentMemory est le composant central de la couche mémoire de l'Agentic OS. Il capture, compresse et indexe les interactions des agents.

## Installation et Démarrage

AgentMemory est installé via npm. Pour démarrer le serveur :

```bash
npm run dev
```

Le serveur écoute par défaut sur le port `3111` pour l'API REST et fournit des outils MCP.

## Intégration Obsidian (Second Brain / Wiki LLM)

L'Agentic OS utilise Obsidian comme interface utilisateur ("Second Brain") pour visualiser, éditer et organiser la mémoire persistante générée par les agents IA. Cette intégration transforme Obsidian en un véritable "Wiki LLM".

### 1. Configuration de l'export automatique

AgentMemory intègre une fonction d'export natif vers Obsidian.
Dans votre fichier `.env`, configurez :

```env
OBSIDIAN_AUTO_EXPORT=true
AGENTMEMORY_EXPORT_ROOT=/chemin/vers/votre/obsidian/vault
CHEMIN_VAULT_OBSIDIAN=/chemin/vers/votre/obsidian/vault
```

### 2. Structure générée dans Obsidian

Lors de l'export, AgentMemory génère automatiquement la structure suivante dans votre Vault Obsidian :

- `/memories/` : Souvenirs consolidés avec leur force et type.
- `/lessons/` : Leçons apprises par l'agent avec score de confiance.
- `/crystals/` : Narratifs de haut niveau et résumés de contexte.
- `/sessions/` : Historique des sessions avec statut du projet.
- `MOC.md` : (Map of Content) Fichier d'index principal généré automatiquement, listant toutes les entités avec des liens bidirectionnels Obsidian (`[[lien]]`).

### 3. Synchronisation bidirectionnelle avec fs-watcher

Pour que les modifications manuelles faites dans Obsidian soient immédiatement prises en compte par les agents, utilisez le connecteur `fs-watcher` :

```bash
# Lancer le watcher sur le dossier Obsidian
export AGENTMEMORY_FS_WATCH_DIRS=/chemin/vers/votre/obsidian/vault
export AGENTMEMORY_URL=http://localhost:3111
npx @agentmemory/fs-watcher
```

Ce connecteur surveille le Vault et envoie des observations (`file_change`) à AgentMemory dès qu'une note est modifiée.

## Consolidation et Purge

AgentMemory inclut des mécanismes pour éviter la saturation :
- **Compression automatique** : Les longs historiques de conversation sont résumés.
- **Purge des données obsolètes** : Configurez des règles de rétention pour supprimer les données de plus de X jours.
- **Anonymisation** : Les données sensibles (clés, mots de passe) détectées sont masquées avant stockage.

## Visualisation (GUI)

AgentMemory inclut un viewer web pour inspecter la mémoire et rejouer les sessions.
Lancez-le via :
```bash
npm run viewer
```
Il permet de vérifier la précision de la récupération (Recall) et l'utilisation des tokens. (Voir `VPS_DEPLOYMENT.md` pour l'hébergement).
