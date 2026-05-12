# Guide de Déploiement VPS (Agentic OS)

Ce guide explique comment héberger l'ensemble de l'Agentic OS (AgentMemory GUI + API + n8n) sur un VPS distant, accessible en HTTPS avec authentification.

## Prérequis

| Composant | Version minimum | Vérification |
|---|---|---|
| VPS (Ubuntu/Debian) | 22.04+ | `lsb_release -a` |
| Docker | 24+ | `docker --version` |
| Docker Compose | v2+ | `docker compose version` |
| Nom de domaine | - | DNS A record pointant vers l'IP du VPS |

## Déploiement en une commande

```bash
git clone https://github.com/HARD2FIND/agentmemory.git
cd agentmemory
./scripts/deploy-agentic-os.sh
```

Le script vous demandera de choisir "VPS" et votre nom de domaine. Il configurera automatiquement le reverse proxy Caddy avec SSL.

## Architecture réseau sur le VPS

```
Internet
   │
   ├── :443 (HTTPS) → Caddy
   │       ├── viewer.domaine.com → iii-engine:3113 (GUI)
   │       ├── api.domaine.com    → iii-engine:3111 (API REST)
   │       └── n8n.domaine.com    → n8n:5678 (Automatisation)
   │
   └── :80 (HTTP redirect → HTTPS) → Caddy
```

Tous les services internes (AgentMemory, n8n) écoutent uniquement sur `127.0.0.1`. Caddy est le seul point d'entrée exposé sur Internet et gère automatiquement les certificats SSL via Let's Encrypt.

## Configuration DNS

Créez trois enregistrements A dans votre gestionnaire DNS :

| Sous-domaine | Type | Valeur |
|---|---|---|
| `viewer.votre-domaine.com` | A | IP du VPS |
| `api.votre-domaine.com` | A | IP du VPS |
| `n8n.votre-domaine.com` | A | IP du VPS |

## Sécurisation de la GUI

La GUI est protégée par une authentification basique (HTTP Basic Auth) configurée dans le `Caddyfile`. Pour générer un mot de passe :

```bash
docker run --rm caddy:2-alpine caddy hash-password --plaintext "VotreMotDePasse"
```

Copiez le hash généré dans le `Caddyfile` à la place de `$2a$14$REMPLACER_PAR_HASH_GENERE`.

## Connexion des agents distants

Une fois le VPS déployé, configurez vos agents locaux pour pointer vers l'API distante :

```json
{
  "mcpServers": {
    "agentmemory": {
      "command": "npx",
      "args": ["-y", "@agentmemory/agentmemory", "mcp"],
      "env": {
        "AGENTMEMORY_URL": "https://api.votre-domaine.com",
        "AGENTMEMORY_SECRET": "votre_secret_du_fichier_env"
      }
    }
  }
}
```

## Maintenance

| Commande | Description |
|---|---|
| `docker compose -f docker-compose.agentic-os.yml logs -f` | Voir les logs en temps réel |
| `docker compose -f docker-compose.agentic-os.yml restart` | Redémarrer tous les services |
| `docker compose -f docker-compose.agentic-os.yml down` | Arrêter tous les services |
| `docker compose -f docker-compose.agentic-os.yml pull && docker compose -f docker-compose.agentic-os.yml up -d` | Mettre à jour les images |
