#!/bin/bash
# Script pour démarrer la synchronisation bidirectionnelle Obsidian <-> AgentMemory

set -e

# Charger les variables d'environnement
if [ -f .env ]; then
  export $(cat .env | grep -v '^#' | xargs)
fi

if [ -z "$CHEMIN_VAULT_OBSIDIAN" ]; then
  echo "Erreur : CHEMIN_VAULT_OBSIDIAN n'est pas défini dans .env"
  exit 1
fi

echo "Démarrage du fs-watcher sur le dossier Obsidian : $CHEMIN_VAULT_OBSIDIAN"
echo "Les modifications dans Obsidian seront envoyées à AgentMemory (http://localhost:3111)"

export AGENTMEMORY_FS_WATCH_DIRS="$CHEMIN_VAULT_OBSIDIAN"
export AGENTMEMORY_URL="http://localhost:3111"

# Lancer le watcher en tâche de fond ou directement
npx @agentmemory/fs-watcher
