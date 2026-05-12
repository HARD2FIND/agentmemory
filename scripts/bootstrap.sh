#!/bin/bash
# Script de bootstrap pour Agentic OS

set -e

echo "Démarrage de l'installation d'Agentic OS..."

# 1. Vérification des dépendances système
echo "Vérification des dépendances système (Node.js, npm, git, gh)..."
command -v node >/dev/null 2>&1 || { echo >&2 "Node.js est requis mais n'est pas installé. Aborting."; exit 1; }
command -v npm >/dev/null 2>&1 || { echo >&2 "npm est requis mais n'est pas installé. Aborting."; exit 1; }
command -v git >/dev/null 2>&1 || { echo >&2 "git est requis mais n'est pas installé. Aborting."; exit 1; }
command -v gh >/dev/null 2>&1 || { echo >&2 "GitHub CLI (gh) est requis mais n'est pas installé. Aborting."; exit 1; }

# 2. Configuration de l'environnement
if [ ! -f .env ]; then
    echo "Création du fichier .env à partir de .env.example..."
    cp .env.example .env
    echo "Veuillez configurer vos clés API et chemins dans le fichier .env"
fi

# 3. Installation d'AgentMemory
echo "Installation des dépendances d'AgentMemory..."
npm install

# 4. Installation de cli-printing-press (simulé)
echo "Configuration de cli-printing-press..."
# Dans un environnement réel, cela téléchargerait le binaire Go
echo "cli-printing-press prêt (placeholder)."

# 5. Configuration de n8n
echo "Préparation des dossiers pour n8n..."
mkdir -p n8n/workflows n8n/docs

# 6. Création des dossiers de base
echo "Création de la structure de dossiers..."
mkdir -p skills docs/diagrams docs/runbooks docs/templates memory/storage memory/viewer

echo "Bootstrap terminé avec succès !"
echo "Pour démarrer les services, utilisez 'npm run dev' ou consultez le README.md"
