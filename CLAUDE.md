# Guide d'utilisation de Claude Code (Orchestrateur)

Claude Code agit comme l'orchestrateur principal de l'Agentic OS. Ce guide décrit comment l'utiliser, charger des skills et gérer les sous-agents.

## Démarrer une session

Pour initier une session avec Claude Code en tant qu'orchestrateur :

```bash
claude-code
```

## Charger des skills

Les skills étendent les capacités de Claude Code. Pour installer un skill généré par `cli-printing-press` ou un skill personnalisé :

```bash
gh skill install <nom_du_skill>
```

Ou via l'interface de Claude Code si configurée. Assurez-vous que le skill est bien documenté dans `skills/<nom_du_skill>/skill.md`.

## Activer le mode Agent Teams

Le mode Agent Teams permet à Claude Code de déléguer des tâches à des sous-agents travaillant en parallèle.

1. Ouvrez (ou créez) le fichier `settings.json` de Claude Code.
2. Ajoutez ou modifiez la configuration suivante :

```json
{
  "agentTeams": {
    "enabled": true,
    "maxConcurrentAgents": 3
  }
}
```

## Récupérer la mémoire via AgentMemory

Claude Code interagit automatiquement avec AgentMemory si le serveur est en cours d'exécution. Pour interroger explicitement la mémoire passée :

```text
> Recherche dans la mémoire toutes les décisions d'architecture concernant n8n du mois dernier.
```

AgentMemory fournira le contexte pertinent compressé à Claude Code.

## Politiques de validation humaine

Conformément aux directives de sécurité (voir `SECURITY_AND_GUARDRAILS.md`), Claude Code est configuré pour demander une approbation humaine avant d'exécuter des actions critiques :

- **Push Git vers la branche principale**
- **Exécution de scripts de paiement**
- **Suppression de ressources cloud**
- **Envoi d'emails en masse**

Lorsqu'une de ces actions est requise, Claude Code mettra en pause l'exécution et affichera une invite de confirmation dans le terminal. Ne contournez pas ces validations.
