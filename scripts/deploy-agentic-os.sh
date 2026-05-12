#!/bin/bash
# Déploiement One-Command pour Agentic OS
# Installe AgentMemory, Obsidian Sync, et n8n sur n'importe quel projet

set -e

echo "==============================================="
echo "🚀 Démarrage du déploiement Agentic OS"
echo "==============================================="

# 1. Vérification de Docker
if ! command -v docker >/dev/null 2>&1; then
    echo "❌ Erreur : Docker n'est pas installé. Veuillez installer Docker et Docker Compose."
    exit 1
fi

# 2. Configuration de l'environnement
if [ ! -f .env ]; then
    echo "📝 Création du fichier .env par défaut..."
    cp .env.example .env
    
    # Générer un secret aléatoire
    SECRET=$(openssl rand -hex 32)
    sed -i "s/AGENTMEMORY_SECRET=.*/AGENTMEMORY_SECRET=$SECRET/" .env
    
    # Créer le dossier Obsidian par défaut
    mkdir -p ./memory/storage/obsidian
    sed -i "s|CHEMIN_VAULT_OBSIDIAN=.*|CHEMIN_VAULT_OBSIDIAN=./memory/storage/obsidian|" .env
    
    echo "✅ Fichier .env configuré avec un secret généré automatiquement."
fi

# 3. Choix du profil (Local vs VPS)
echo ""
echo "Où déployez-vous Agentic OS ?"
echo "1) En local (sur votre machine de développement)"
echo "2) Sur un VPS (exposé sur Internet avec HTTPS via Caddy)"
read -p "Votre choix (1/2) [1]: " choice
choice=${choice:-1}

if [ "$choice" = "2" ]; then
    echo ""
    read -p "Entrez votre nom de domaine principal (ex: mon-domaine.com) : " DOMAIN
    
    # Préparer le Caddyfile
    echo "📝 Configuration du Reverse Proxy Caddy..."
    cp Caddyfile.example Caddyfile
    sed -i "s/votre-domaine.com/$DOMAIN/g" Caddyfile
    
    echo "⚠️  IMPORTANT : Vous devez configurer le mot de passe de la GUI dans Caddyfile."
    echo "Utilisez la commande 'caddy hash-password' pour générer le hash."
    
    echo "🚀 Lancement des services (Profil VPS)..."
    docker compose -f docker-compose.agentic-os.yml --profile vps up -d
else
    echo "🚀 Lancement des services (Profil Local)..."
    docker compose -f docker-compose.agentic-os.yml up -d
fi

echo ""
echo "==============================================="
echo "✅ Déploiement terminé avec succès !"
echo "==============================================="
echo "Services actifs :"
echo "🧠 AgentMemory API : http://localhost:3111"
echo "👁️  AgentMemory GUI : http://localhost:3113"
echo "🤖 n8n Automation  : http://localhost:5678"
echo "📁 Obsidian Vault  : ./memory/storage/obsidian (Synchronisé automatiquement)"
echo "==============================================="
echo "Pour configurer votre agent (Claude Code, Cursor, etc.), ajoutez ceci à sa configuration :"
echo ""
echo "\"mcpServers\": {"
echo "  \"agentmemory\": {"
echo "    \"command\": \"npx\","
echo "    \"args\": [\"-y\", \"@agentmemory/agentmemory\", \"mcp\"],"
echo "    \"env\": {"
echo "      \"AGENTMEMORY_URL\": \"http://localhost:3111\","
echo "      \"AGENTMEMORY_SECRET\": \"$(grep AGENTMEMORY_SECRET .env | cut -d '=' -f2)\""
echo "    }"
echo "  }"
echo "}"
echo "==============================================="
