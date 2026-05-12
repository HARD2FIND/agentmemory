# Intégration Obsidian Second Brain / Wiki LLM

AgentMemory transforme Obsidian en un véritable "Wiki LLM" : une base de connaissances navigable par l'humain et interrogeable par les agents IA. Ce document explique comment cette intégration fonctionne.

## Fonctionnement

L'intégration repose sur deux mécanismes natifs d'AgentMemory :

| Mécanisme | Direction | Description |
|---|---|---|
| **Obsidian Export** (`mem::obsidian-export`) | AgentMemory → Obsidian | Exporte les mémoires, leçons, crystals et sessions en fichiers Markdown dans le Vault Obsidian. Génère un fichier `MOC.md` (Map of Content) avec des liens bidirectionnels `[[...]]`. |
| **FS-Watcher** (`@agentmemory/fs-watcher`) | Obsidian → AgentMemory | Surveille le dossier Obsidian et envoie une observation à l'API AgentMemory dès qu'un fichier est modifié, créé ou supprimé. |

## Configuration (automatique via `deploy-agentic-os.sh`)

Si vous avez utilisé le script de déploiement one-command, tout est déjà configuré. Le service `obsidian-watcher` dans `docker-compose.agentic-os.yml` surveille automatiquement le dossier `./memory/storage/obsidian`.

Pour utiliser un Vault Obsidian existant, modifiez la variable `CHEMIN_VAULT_OBSIDIAN` dans votre `.env` pour pointer vers le chemin absolu de votre Vault, puis relancez les services :

```bash
docker compose -f docker-compose.agentic-os.yml up -d obsidian-watcher
```

## Structure générée dans Obsidian

Lors de l'export, AgentMemory génère automatiquement la structure suivante :

```
votre-vault/
├── MOC.md                 # Map of Content (index principal)
├── memories/
│   └── <id>.md            # Souvenirs consolidés (type, force, tags)
├── lessons/
│   └── <id>.md            # Leçons apprises (confiance, contexte)
├── crystals/
│   └── <id>.md            # Narratifs de haut niveau
└── sessions/
    └── <id>.md            # Historique des 50 dernières sessions
```

Le fichier `MOC.md` contient des liens Obsidian (`[[...]]`) vers chaque entité, permettant une navigation fluide dans le graphe de connaissances.

## Utilisation avec les agents

Lorsqu'un agent (Claude Code, Codex, etc.) démarre une session, AgentMemory lui fournit automatiquement le contexte pertinent issu de la mémoire. Si vous ajoutez manuellement des notes dans Obsidian (par exemple, des décisions d'architecture ou des notes de réunion), le FS-Watcher les capture et les rend disponibles pour la recherche sémantique de l'agent.

## Variables d'environnement associées

| Variable | Valeur par défaut | Description |
|---|---|---|
| `OBSIDIAN_AUTO_EXPORT` | `true` | Active l'export automatique vers Obsidian |
| `AGENTMEMORY_EXPORT_ROOT` | `./memory/storage/obsidian` | Chemin du Vault Obsidian |
| `CHEMIN_VAULT_OBSIDIAN` | `./memory/storage/obsidian` | Chemin monté dans le container du watcher |
