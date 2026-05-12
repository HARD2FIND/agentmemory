# Guide d'Automatisation avec n8n

n8n est utilisé comme moteur de workflow pour automatiser les tâches répétitives de l'Agentic OS.

## 1. Déploiement

Il est recommandé de déployer n8n via Docker sur un VPS dédié.

Exemple de `docker-compose.yml` pour n8n :
```yaml
version: '3.8'
services:
  n8n:
    image: docker.n8n.io/n8nio/n8n
    restart: always
    ports:
      - "5678:5678"
    environment:
      - N8N_HOST=${SUBDOMAIN}.${DOMAIN_NAME}
      - N8N_PORT=5678
      - N8N_PROTOCOL=https
      - NODE_ENV=production
      - WEBHOOK_URL=https://${SUBDOMAIN}.${DOMAIN_NAME}/
      - GENERIC_TIMEZONE=${GENERIC_TIMEZONE}
    volumes:
      - n8n_data:/home/node/.n8n

volumes:
  n8n_data:
```

## 2. Workflows Prioritaires

Les workflows suivants sont recommandés et doivent être stockés dans `n8n/workflows/` :

1. **Synchronisation de la mémoire** : Se déclenche via un Cron quotidien pour sauvegarder la base AgentMemory et mettre à jour `CONTEXT_INDEX.md`.
2. **Publication d'articles** : Reçoit le contenu de Claude Code/Codex, le formate et le publie via l'API WordPress, puis commite les changements via GitHub CLI.
3. **Scraping et Analyse** : Orchestre la collecte de données, l'analyse via des agents et le stockage des résultats dans Obsidian.
4. **Notification d'alertes** : Écoute les webhooks d'erreur et envoie des notifications sur Slack/Discord.

## 3. Gestion des Versions

Exportez toujours vos workflows n8n au format JSON et commitez-les dans le dossier `n8n/workflows/` pour assurer la reproductibilité et le versioning.
