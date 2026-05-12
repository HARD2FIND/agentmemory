# Index des Skills

Ce document liste les skills disponibles pour les agents de l'Agentic OS.

| Nom du Skill | Description | Arguments Requis | Dépendances | Comment Installer |
|---|---|---|---|---|
| `cli-printing-press` | Génère des CLI et serveurs MCP à partir d'API. | `url` ou `nom_api` | Go >= 1.26 | Pré-installé |
| *Exemple: GitHub* | Gestion des issues et PR | `repo`, `action` | GitHub CLI (`gh`) | `gh skill install github` |
| *Exemple: WebScraper* | Extrait le contenu d'une page web | `url` | n8n ou Python | Placer dans `skills/webscraper/` |

*(Ajoutez ici vos skills personnalisés générés au fur et à mesure)*

## Créer un nouveau skill

1. Créez un dossier dans `skills/<nom_du_skill>/`.
2. Ajoutez un fichier `skill.md` décrivant l'objectif, les entrées et les sorties.
3. Ajoutez le code source dans `skills/<nom_du_skill>/code/`.
4. Mettez à jour ce tableau.
