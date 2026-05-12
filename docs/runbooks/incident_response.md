# Runbook : Réponse aux Incidents

## Incident 1 : AgentMemory ne répond pas

**Symptômes** : Les agents ne peuvent pas récupérer de contexte. Les appels MCP échouent.

**Diagnostic** :
1. Vérifiez l'état du service : `scripts/healthcheck.sh`
2. Consultez les logs : `npm run logs`

**Résolution** :
1. Redémarrez le service : `npm run restart`
2. Si le problème persiste, vérifiez si le port 3111 est bloqué.
3. Restaurez la base de données depuis la dernière sauvegarde si nécessaire.

---

## Incident 2 : Workflow n8n en échec

**Symptômes** : Un workflow n8n s'est arrêté avec une erreur.

**Diagnostic** :
1. Accédez à l'interface n8n et consultez l'historique d'exécution.
2. Identifiez le nœud en échec et lisez le message d'erreur.

**Résolution** :
1. Corrigez la configuration du nœud (credentials, URL, etc.).
2. Utilisez la fonction "Retry" de n8n pour relancer depuis le nœud en échec.
3. Si l'erreur est liée à une API externe, vérifiez le statut de l'API.

---

## Incident 3 : Budget API dépassé

**Symptômes** : Les appels à l'API LLM échouent avec une erreur de quota.

**Résolution** :
1. Vérifiez la consommation dans le tableau de bord de l'observabilité.
2. Identifiez les agents ou workflows consommant le plus de tokens.
3. Optimisez les prompts ou réduisez la fréquence des appels.
4. Augmentez le budget si nécessaire dans les paramètres de l'API.
