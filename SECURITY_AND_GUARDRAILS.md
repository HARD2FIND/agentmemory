# Politiques de Sécurité et Guardrails

Ce document définit les règles strictes de sécurité, de gestion des accès et de validation humaine pour l'Agentic OS.

## 1. Gestion des secrets

Les secrets ne doivent **jamais** être stockés en clair dans le code, la mémoire (AgentMemory) ou les logs.

- **Variables d'environnement** : Tous les tokens (GitHub, OpenAI, etc.) doivent être stockés dans un fichier `.env` non versionné (voir `.env.example`).
- **Secret Manager** : Pour les environnements de production, l'utilisation d'un gestionnaire de secrets (AWS Secrets Manager, HashiCorp Vault) est obligatoire via la variable `[SECRETS_MANAGER]`.

## 2. Politiques d'autorisation

Pour limiter les risques d'exécution de code arbitraire, des listes blanches strictes sont appliquées :

- **`[OUTILS_AUTORISÉS]`** : Liste explicite des outils (MCP, CLI) que les agents peuvent invoquer. Toute tentative d'utilisation d'un outil non listé sera bloquée.
- **`[AGENTS_AUTORISÉS]`** : Seuls les agents listés dans cette variable peuvent interagir avec l'OS (ex: Claude Code, Codex, Antigravity).

## 3. Niveaux d'approbation humaine

La validation humaine est le principal garde-fou contre les actions irréversibles ou coûteuses. Le niveau requis est défini par `[NIVEAU_APPROBATION_HUMAINE]`.

**Actions nécessitant une confirmation explicite (OUI) :**
- `git push` vers la branche principale.
- Fusion de Pull Requests.
- Exécution de transactions financières ou paiements.
- Envoi de courriels en masse ou publications publiques (ex: WordPress, réseaux sociaux).
- Suppression de ressources cloud ou de bases de données.

L'agent mettra son exécution en pause et demandera confirmation via le terminal ou une notification n8n.

## 4. Isolation des environnements

Les agents doivent opérer dans des environnements isolés pour éviter les dommages collatéraux.
- Définir la variable `[ENVIRONNEMENT_CIBLE]` (dev, staging, prod).
- Les agents de développement ne doivent pas avoir accès aux credentials de production.

## 5. Audit et Traçabilité

- **Logs signés** : Toutes les actions (prompts, réponses, appels d'outils) sont enregistrées.
- **Trace ID** : Un identifiant unique est injecté dans chaque requête pour suivre l'exécution de bout en bout.
- L'historique complet des runs (agent, heure, action, sortie) est conservé à des fins d'audit.

## 6. Mécanismes de Rollback

- **Git** : Créer systématiquement une branche temporaire pour chaque modification avant de proposer une PR. Ne jamais travailler directement sur `main`.
- **n8n** : Prévoir des mécanismes de retour arrière dans les workflows en cas d'échec d'une étape.

## 7. Formation et Sensibilisation

Les utilisateurs de l'Agentic OS doivent être formés à :
- Reconnaître les tentatives de phishing ou d'injection de prompt via des sources externes.
- Gérer correctement les permissions et les clés d'API.
- Ne pas approuver aveuglément les actions demandées par les agents.
