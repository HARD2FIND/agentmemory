# Manuel Opératoire Quotidien

Ce manuel décrit les procédures courantes pour utiliser et maintenir l'Agentic OS.

## 1. Démarrer un nouveau projet

1. Créez un nouveau dossier pour votre projet.
2. Démarrez les services de base :
   ```bash
   cd /chemin/vers/agentmemory
   npm run dev
   ```
3. Lancez Claude Code dans le dossier de votre projet :
   ```bash
   claude-code
   ```

## 2. Ajouter un nouveau skill

1. Utilisez `cli-printing-press` pour générer le skill à partir d'une documentation API.
2. Placez le dossier généré dans `skills/`.
3. Assurez-vous que le fichier `skill.md` est présent et décrit correctement les entrées/sorties.
4. Installez le skill dans Claude Code : `gh skill install skills/<nom_du_skill>`.

## 3. Lancer un workflow n8n

1. Accédez à l'interface web de n8n (`URL_VPS_N8N`).
2. Importez un workflow depuis le dossier `n8n/workflows/`.
3. Configurez les identifiants (Credentials) nécessaires.
4. Activez le workflow ou déclenchez-le manuellement.

## 4. Sauvegarder la mémoire

La mémoire est stockée localement dans `memory/storage/`. Il est recommandé de la sauvegarder régulièrement.
- Un workflow n8n peut être configuré pour zipper ce dossier et l'envoyer sur un stockage cloud sécurisé.

## 5. Runbooks d'incidents

### Service down (AgentMemory ne répond pas)
- Vérifiez les logs avec `npm run logs`.
- Redémarrez le service : `npm run restart`.
- Vérifiez si le port 3111 est utilisé par une autre application.

### Mémoire corrompue
- Restaurez la dernière sauvegarde depuis `memory/storage/backup/`.
- Utilisez l'outil de réparation (si disponible) : `npm run repair-db`.

### Token API dépassé
- Vérifiez le tableau de bord d'observabilité.
- Mettez à jour la clé API dans le fichier `.env` et redémarrez les services.
