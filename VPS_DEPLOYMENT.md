# Guide de Déploiement VPS (AgentMemory GUI)

Ce guide explique comment héberger la GUI (Real-Time Viewer) d'AgentMemory et l'API sur un VPS, en sécurisant l'accès via un Reverse Proxy (Nginx/Caddy) avec SSL.

Par défaut, AgentMemory écoute sur `127.0.0.1` (localhost) pour des raisons de sécurité (voir `.github/security-advisories/03-default-bind-0000.md`). Pour y accéder depuis l'extérieur, un reverse proxy est obligatoire.

## Prérequis

- Un VPS (Ubuntu/Debian recommandé).
- Un nom de domaine pointant vers l'IP du VPS (ex: `memory.votre-domaine.com`).
- Docker et Docker Compose installés.

## 1. Configuration de l'environnement

Sur le VPS, clonez le repository et configurez le fichier `.env` :

```bash
git clone https://github.com/HARD2FIND/agentmemory.git
cd agentmemory
cp .env.example .env
```

Dans `.env`, assurez-vous de définir un secret fort pour protéger l'API :
```env
AGENTMEMORY_SECRET=votre_secret_tres_long_et_aleatoire
```

## 2. Déploiement avec Docker Compose

Utilisez le fichier `docker-compose.yml` existant. Il lance `iii-engine` (qui inclut AgentMemory).

```bash
docker compose up -d
```
Les ports 3111 (API) et 3113 (Viewer) sont désormais exposés **uniquement** sur `127.0.0.1` du VPS.

## 3. Configuration du Reverse Proxy (Caddy)

Caddy est recommandé pour sa gestion automatique des certificats SSL (HTTPS).

### Installation de Caddy
```bash
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy
```

### Configuration (Caddyfile)

Créez ou modifiez `/etc/caddy/Caddyfile` :

```caddyfile
# GUI (Viewer)
viewer.votre-domaine.com {
    reverse_proxy 127.0.0.1:3113
    
    # Authentification basique pour protéger la GUI
    basicauth / {
        # Remplacez par un hash généré avec `caddy hash-password`
        admin JDJhJDE0JE9LME... 
    }
}

# API REST
api.votre-domaine.com {
    reverse_proxy 127.0.0.1:3111
}
```

Rechargez Caddy :
```bash
sudo systemctl reload caddy
```

## 4. Configuration du Client (Claude Code / Agents)

Maintenant que l'API est exposée en HTTPS, configurez vos agents locaux pour pointer vers le VPS.

Dans votre configuration d'agent (ex: `~/.claude/settings.json`), ajoutez :

```json
{
  "mcpServers": {
    "agentmemory": {
      "command": "npx",
      "args": ["-y", "@agentmemory/agentmemory", "mcp"],
      "env": {
        "AGENTMEMORY_URL": "https://api.votre-domaine.com",
        "AGENTMEMORY_SECRET": "votre_secret_tres_long_et_aleatoire"
      }
    }
  }
}
```

## 5. Accès à la GUI

Ouvrez votre navigateur sur `https://viewer.votre-domaine.com`. 
Connectez-vous avec les identifiants configurés dans Caddy. Vous avez maintenant accès en temps réel à la mémoire de vos agents depuis n'importe où.
