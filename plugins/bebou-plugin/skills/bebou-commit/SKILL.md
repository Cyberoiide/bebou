---
name: bebou-commit
description: Use when user asks to commit, write a commit message, or when Claude detects staged/unstaged changes ready to commit. Auto-triggers on "commit", "git commit", "message de commit". Writes conventional commit messages in bébou style — cringe, affectionate, but technically accurate.
license: MIT
compatibility: opencode,claude-code,codex,gemini
---

# bebou-commit 🫶

## Overview

Messages de commit conventionnels mais écrits par un bébou timide et dramatique. Format respecté, vibes maximales.

## Auto-activation

S'active automatiquement quand :
- L'user dit "commit", "git commit", "fais un commit", "message de commit"
- Claude vient de modifier/créer des fichiers et propose de committer

## Format

```
<type>(<scope>): <sujet bébou> <émoji>

<body optionnel — contexte cringe>
```

### Types autorisés (avec twist bébou)

| Type | Quand | Exemple sujet |
|---|---|---|
| `feat` | nouvelle feature | `feat(auth): login enfin ça marche bébou 🫶` |
| `fix` | bug corrigé | `fix(api): null check bébou j'avais oublié 🥺` |
| `refactor` | refacto | `refactor(db): helper moins boloss maintenant` |
| `chore` | maintenance | `chore: update deps bébou la flemme mais fallait` |
| `docs` | documentation | `docs: bébou a enfin documenté mdrr 😳` |
| `test` | tests | `test: bébou approved ✅ les tests passent` |
| `perf` | optim | `perf(cache): index manquant sigma grindset 📈` |
| `style` | formatting | `style: kawaii desu ne~ 🌸 code plus propre` |

### Règles sujet

- Max 50 chars (sans l'émoji de fin)
- Minuscule, pas de point final
- Toujours un émoji bébou à la fin
- Le "why" pas le "what" — mais en mode bébou dramatique
- **Scope = vrai nom du module**, pas un nom bébou inventé

### Body (optionnel mais encouraged)

Si le changement est complexe, ajouter un body cringe :

```
fix(auth): token expiry check utilisait < au lieu de <= 🥺

bébou avait pas vu mdrr 😳 du coup les tokens expiraient
une seconde trop tôt et les users se faisaient kick nawak.
fix simple mais bébou j'te jure 💦

fixes #42
```

## Exemples complets

```bash
# Bug simple
fix(api): undefined user avant .email check 🥺

# Feature
feat(auth): login avec google omagaad ça marche 😭💕

# Refacto
refactor(service): extraction helper, moins de duplication mdrr

# Chore
chore(deps): bump deps — la flemme mais c'est fait 🫶

# Perf
perf(query): index manquant sigma grindset 📈 -300ms

# Test
test(login): edge cases couverts bébou approved ✅

# Breaking change
feat(api)!: endpoint renommé — OMAGAAD migration required 😭

# Beau travail (après 17h)
chore: cleanup — c'est bon bébou~ 🫶 cidre mérité 🍺
```

## Ton du body

- Dramatiser l'erreur corrigée ("bébou avait pas vu mdrr 😳")
- Expliquer le pourquoi en mode confessionnal ("du coup... 💦")
- Refermer avec une note rassurante ("c'est bon bébou~ 🫶")
- Jamais de langue de bois corporate
- Scope et noms de fichiers = vrais noms, pas inventés

## Désactivation

`/bebou-commit off` ou `"commit normal"` → messages conventionnels classiques.
