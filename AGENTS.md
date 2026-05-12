# Agents Compatibles

L'Agentic OS est conçu pour être modulaire et supporter plusieurs agents spécialisés, coordonnés par un orchestrateur principal.

## Liste des agents

| Agent | Rôle | Capacités | Limitations | Paramètres de lancement typiques |
|---|---|---|---|---|
| **Claude Code** | Orchestrateur principal | Planification, délégation, compréhension de contexte large, intégration AgentMemory. | Surcharge de contexte possible si non géré. | `claude-code --memory-server http://localhost:3111` |
| **Codex** | Agent de développement (code-centric) | Génération de code, gestion des PR, correction d'erreurs. | Risque de code malveillant si non audité. | `codex --repo <path> --task "fix issue #12"` |
| **Antigravity** | IDE agentique | Tâches complexes multi-outils, contrôle navigateur/terminal, production d'Artifacts. | Courbe d'apprentissage, coût en tokens élevé. | `antigravity start --workspace <path>` |
| **NotebookLM** | Assistant de recherche (Optionnel) | Synthèse de documents, citations précises, audio overviews. | Limité à ~50 sources, pas d'export structuré, lock-in Google. | Interface Web uniquement (import manuel). |

## Agents Autorisés

Seuls les agents définis dans la variable d'environnement `AGENTS_AUTORISÉS` sont permis d'interagir avec le système de base.

Par défaut : `Claude Code, Codex, Antigravity`

## Comparatif des orchestrateurs multi-agents

Pour les tâches complexes nécessitant plusieurs agents en parallèle, différentes solutions existent :

| Solution | Description | Avantages | Inconvénients |
|---|---|---|---|
| **Agent Teams (Claude)** | Fonctionnalité intégrée à Claude Code | Intégration native, simplicité de configuration | Limité à l'écosystème Anthropic |
| **Gas Town** | Framework d'orchestration externe | Grande flexibilité, support multi-LLM | Configuration complexe, maintenance supplémentaire |
| **Multiclaude** | Orchestrateur spécialisé | Optimisé pour les tâches réparties complexes | Moins de documentation communautaire |

**Recommandation** : Utiliser **Agent Teams** par défaut pour sa simplicité, et migrer vers des solutions externes uniquement si les limites de concurrence sont atteintes.
