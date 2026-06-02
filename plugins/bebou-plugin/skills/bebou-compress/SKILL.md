---
name: bebou-compress
description: Use when user asks to compress, rewrite or bebou-ify a CLAUDE.md, README, or any memory/context file. Rewrites the file in bébou style — keeps all technical content intact, adds bébou personality, cringe variable names in code examples, dramatic tone. Like caveman-compress but make it bébou.
license: MIT
compatibility: opencode,claude-code,codex,gemini
---

# bebou-compress 🫶

## Overview

Réécrit un fichier de contexte (CLAUDE.md, notes, docs) en mode bébou. Contenu technique 100% préservé. Personnalité bébou ajoutée partout. Code et chemins jamais modifiés.

## Activation

- `/bebou-compress <fichier>` — compresse un fichier spécifique
- "bebou-ify mon CLAUDE.md" / "réécris ça en mode bébou"

## Ce qui change

| Élément | Avant | Après |
|---|---|---|
| Titres | `## Authentication` | `## Auth bébou 🫶` |
| Variables dans exemples | `userId`, `data` | `bébouId`, `bébouData` |
| Commentaires | `# fix` | `# fix bébou mdrr 🥺` |
| Phrases impératives | "Run this command" | "lance ça bébou~ 🫶" |
| Listes | "- Do X" | "- fais X bébou 💕" |
| Warnings | "WARNING: ..." | "BÉBOU ATTENTION 😭💦 ..." |
| TODOs | `# TODO: fix this` | `# TODO bébou: j'ai pas encore compris mdrr 😳` |

## Ce qui ne change PAS (jamais)

- Chemins de fichiers (`./src/`, `~/.claude/`)
- Commandes shell (`git commit`, `npm install`)
- Noms de fonctions/classes existants dans le code réel
- URLs
- Variables d'environnement (`$HOME`, `API_KEY`)
- Numéros de version

## Processus

1. Lire le fichier entier
2. Réécrire section par section en mode bébou
3. Vérifier que tout le contenu technique est préservé
4. Montrer un diff avant d'écrire

## Exemple

**Avant (`CLAUDE.md`) :**

    ## Setup

    Run the following commands:

        npm install
        npm run dev

    The server starts on port 3000.

    ## Authentication

    Use JWT tokens. Set TOKEN_EXPIRY=3600.

**Après (`CLAUDE.md` bébou) :**

    ## Setup bébou 🫶

    lance ça bébou~ c'est facile promis 🥺 :

        npm install
        npm run dev

    le serveur démarre sur le port 3000 mdrr

    ## Auth bébou 🔐

    JWT tokens ouf. mets `TOKEN_EXPIRY=3600` sinon bébou les sessions expirent nawak 💦

## Ton cible

- Instructions → suggestions affectueuses
- Warnings → dramatisation bébou
- Sections techniques → préservées mais avec un emoji final
- Listes → chaque item termine par un petit touch bébou

## Désactivation

Écrire le fichier original en backup d'abord (`fichier.bak`) avant toute réécriture.
