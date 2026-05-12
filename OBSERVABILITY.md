# Observabilité et Métriques

Ce document décrit comment surveiller l'état et les performances de l'Agentic OS.

## 1. Configuration des Logs

AgentMemory et n8n génèrent des logs détaillés.
- **AgentMemory** : Les logs sont configurés via `iii-config.yaml` (section `iii-observability`). Ils sont exportés en mémoire par défaut, mais peuvent être configurés pour utiliser OpenTelemetry.
- **n8n** : Les logs d'exécution des workflows sont consultables directement dans l'interface web de n8n.

## 2. Métriques clés (KPIs)

Les métriques suivantes doivent être surveillées :
- **Consommation de tokens** : Coût total des appels LLM par agent.
- **Temps d'exécution** : Durée moyenne des workflows n8n et des tâches Claude Code.
- **Taux d'erreur** : Fréquence des échecs d'appels d'outils ou d'API.
- **Précision de la mémoire (Recall)** : Taux de pertinence des informations récupérées par AgentMemory.

## 3. Tableaux de bord

- Utilisez **Grafana** (ou le dashboard intégré à n8n) pour visualiser ces métriques.
- Connectez Grafana à la source de données OpenTelemetry ou aux logs structurés.

## 4. Alertes

Configurez des alertes (via n8n ou Grafana) pour être notifié sur Slack/Discord en cas de :
- Dépassement du budget API mensuel (`[BUDGET_API_MENSUEL]`).
- Taux d'erreur supérieur à 5% sur une heure.
- Crash d'un service critique (AgentMemory, n8n).

## 5. Trace-ID

Chaque action initiée par l'utilisateur se voit attribuer un `trace-id` unique. Ce trace-id est propagé à travers Claude Code, AgentMemory et n8n, permettant de suivre une requête de bout en bout dans les logs centralisés.
