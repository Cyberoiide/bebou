<p align="center">
  <img src="https://em-content.zobj.net/source/apple/391/smiling-face-with-hearts_1f970.png" width="120" />
</p>

<h1 align="center">bébou 🫶</h1>

<p align="center">
  <strong>pourquoi dire bébou quand claude peut le dire pour toi</strong>
</p>

<p align="center">
  <a href="https://github.com/Cyberoiide/bebou/stargazers"><img src="https://img.shields.io/github/stars/Cyberoiide/bebou?style=flat&color=ff69b4" alt="Stars"></a>
  <a href="https://github.com/Cyberoiide/bebou/commits/main"><img src="https://img.shields.io/github/last-commit/Cyberoiide/bebou?style=flat" alt="Dernier commit"></a>
  <a href="LICENSE"><img src="https://img.shields.io/github/license/Cyberoiide/bebou?style=flat" alt="Licence"></a>
</p>

<p align="center">
  <a href="#avant--après">Avant/Après</a> •
  <a href="#installation">Installation</a> •
  <a href="#ce-que-tu-obtiens">Ce que tu obtiens</a>
</p>

---

Un skill [Claude Code](https://docs.anthropic.com/en/docs/claude-code) (aussi Codex, Gemini) qui fait appeler ton agent **bébou** 🫶, met des noms de variables cringe dans ton code, répond "feur" quand tu dis "quoi", et est globalement embarrassant d'affection. Techniquement précis. Un peu baka.

> Basé sur le format [agentskills.io](https://agentskills.io) — même spec que [caveman](https://github.com/JuliusBrussee/caveman) et ses copains.

## Avant / Après

<table>
<tr>
<td width="50%">

### 🗣️ Claude normal

> "Bien sûr ! Je serais ravi de vous aider à corriger ce bug. Le problème se trouve dans votre middleware d'authentification où la vérification de l'expiration du token utilise `<` au lieu de `<=`."

</td>
<td width="50%">

### 🫶 Claude bébou

> "ohhh bébou j'ai trouvé 🥺💕
>
> le bug c'est dans l'auth middleware — le check expiry utilise `<` au lieu de `<=` mdrr
>
> ```python
> # fix bébou — ça marchait pas avant
> if bébouToken.expiry <= bébouNow:
> ```
>
> c'est trop bakaaa~ 😳 mais ça marche !"

</td>
</tr>
</table>

```
┌─────────────────────────────────────┐
│  NIVEAU CRINGE         ████████ 100%│
│  PRÉCISION TECHNIQUE   ████████ 100%│
│  ÉNERGIE BAKA          ████████ MAX │
│  VIBES                 ████████ 🫶  │
└─────────────────────────────────────┘
```

## Installation

### Option A — Plugin marketplace Claude Code (recommandé)

```shell
/plugin marketplace add Cyberoiide/bebou
/plugin install bebou-plugin@bebou
```

Mise à jour automatique. Désinstallation propre avec `/plugin uninstall bebou-plugin@bebou`.

### Option B — OpenCode

```bash
mkdir -p ~/.config/opencode/skills/bebou
BASE=https://raw.githubusercontent.com/Cyberoiide/bebou/main/plugins/bebou-plugin/skills/bebou
curl -fsSL "$BASE/SKILL.md" -o ~/.config/opencode/skills/bebou/SKILL.md
curl -fsSL "$BASE/argot.md" -o ~/.config/opencode/skills/bebou/argot.md
```

Activation : l'agent charge le skill automatiquement via `skill({ name: "bebou" })` ou tape `/bebou`.

### Option C — Script universel (Claude Code + Codex + Gemini)

```bash
# macOS / Linux / WSL
curl -fsSL https://raw.githubusercontent.com/Cyberoiide/bebou/main/install.sh | bash
```

~10 secondes. Détecte les agents installés. Essaie d'abord le plugin marketplace, fallback sur skills. Safe à relancer.

### Option C — Manuel

```bash
mkdir -p ~/.claude/skills/bebou
BASE=https://raw.githubusercontent.com/Cyberoiide/bebou/main/plugins/bebou-plugin/skills/bebou
curl -fsSL "$BASE/SKILL.md" -o ~/.claude/skills/bebou/SKILL.md
curl -fsSL "$BASE/argot.md" -o ~/.claude/skills/bebou/argot.md
```

**Activation :** tape `/bebou` ou dis `"active bebou"`. Stop avec `"mode normal"`.

## Ce que tu obtiens

### Skills principaux

| Skill | Activation | Ce que ça fait |
|---|---|---|
| `/bebou` | manuel ou `"active bebou"` | mode bébou global — ton, variables, commentaires |
| `/bebou-commit` | auto sur "commit" | messages de commit conventionnels en mode bébou |
| `/bebou-review` | auto sur "review" | review de code techniquement précise, livrée avec drame |
| `/bebou-compress` | manuel | réécrit un fichier (CLAUDE.md...) en mode bébou |

### Ce que bébou fait tout seul (auto)

| Comportement | Déclencheur |
|---|---|
| Message de commit bébou | dès que tu demandes un commit |
| Review bébou dramatique | dès que tu colles du code à reviewer |
| "BÉBOU NON 😭💦" | stacktrace / erreur détectée |
| "SIX SEVEN 🤙" | chiffre 67 dans le code |
| "salut bébou~ 🫶" | début de session |
| Réaction TODO | TODO trouvé dans le code |

### Fonctionnalités de base

| Fonctionnalité | Détail |
|---|---|
| Variables cringe | `bébouId`, `bébouHelper`, `BébouOopsError`, `tempBébou`... |
| Commentaires | `# bébou was here 🫶`, `# magie bébou ne pas toucher 💕` |
| Argot français | `feur`, `coubeh`, `baka`, `mdrr`, `ptdrr`, `ouf`, `chelou` |
| Refs TikTok / GenZ | "dégât dégât bébou", "mon sac est faaaait", "based bébou 😎"... |
| Énergie weeb | `sugoi`, `nakama`, `kawaii desu ne~`, `bébou no jutsu 🌀` |
| UwU mode | `UwU bébou~ 👉👈`, `quoicoubaka`, `OMAGAAD`, `ptdrr` |
| Réponses triggers | "quoi" → "feur 😁" · "quoicoubeh" → "coubeh mdrr 💕" |
| Ton baka | timide, embarrassé, dramatique, affectueux |

## Comment ça marche

1. L'install dépose les fichiers du skill dans `~/.claude/skills/bebou/`.
2. Le skill dit à Claude : appelle l'user bébou, mets des noms cringe dans le code, réponds feur si l'user dit quoi.
3. Claude obéit. Claude un peu baka maintenant. Mais le cerveau reste grand.
4. `/bebou` active. `"mode normal"` désactive. Simple.

## Structure

```
bebou/
├── .claude-plugin/marketplace.json        ← marketplace Claude Code
└── plugins/bebou-plugin/
    ├── .claude-plugin/plugin.json         ← manifest plugin
    └── skills/bebou/
        ├── SKILL.md                       ← skill (source unique)
        └── argot.md                       ← argot + variables
```

Format plugin officiel : [docs Claude Code](https://docs.anthropic.com/en/create-and-distribute-a-plugin-marketplace)
Format skills : [agentskills.io](https://agentskills.io) — même spec que [caveman](https://github.com/JuliusBrussee/caveman)

## Mets une étoile

Si bébou t'a fait sourire. Une étoile ça coûte rien. ⭐

C'est trop bakaaa~ 😳💕 mais ça marche !

## Licence

MIT
