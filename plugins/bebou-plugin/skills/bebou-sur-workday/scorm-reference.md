# SCORM Reference — Workday Learning

Référence technique pure. Utilisée par `bebou-sur-workday/SKILL.md`.

## Deux couches — ne pas confondre

1. **Content layer** (`genially.html`) — les slides. PAS d'API SCORM standalone. Naviguer dedans ne donne PAS le crédit.
2. **SCORM player layer** (`ScormEngineInterface/.../player/modern.html`) — ouvert par Workday. Contient `window.API` (SCORM 1.2). C'est ICI que le crédit se set.

## Procédure complète

### 1. Enrollment

**Programme** (`/learning/program/<id>`) :
1. Cliquer `"S'inscrire"` (testid `registerForProgramAction`) → `"Réviser"` → `"Soumettre"`
2. URL gagne `?record=<id>` une fois inscrit

**Élément cours** (si besoin) :
1. Ouvrir cours → `"S'inscrire"` → `"Soumettre"` → `"Démarrer le cours"`

Éléments **"Facultatif"** → ignorer, ne comptent pas pour le 100%.

Header de progression : `"Avancement du programme : N élément(s) obligatoire(s) achevé(s) sur M"` — boucler jusqu'à `M sur M`.

### 2. Types d'éléments

| Type | Procédure |
|------|-----------|
| **Média / SCORM** | Bouton launch → onglet player → SCORM API |
| **Lien externe** | Cliquer `"Afficher le lien externe"` (testid `viewExternalLinkAction`) → visite = terminé |

### 3. Lancer le player SCORM

Page leçon : `.../learning/course/<id>/lesson/<id>?type=...`
Bouton : testid `viewScormAction`, texte `"Lancer le contenu"` / `"Afficher à nouveau"` → nouvel onglet.

Après launch : `browser_tabs list` → sélectionner `ScormEngineInterface/.../player/modern.html`.

### 4. Vérifier l'API (attendre ~3-4s)

```js
() => {
  const api = window.API;
  const g = k => api.LMSGetValue(k);
  return {
    hasLMS: typeof api?.LMSGetValue === 'function',
    version: g('cmi.core._version'),
    status:  g('cmi.core.lesson_status'),
    score:   g('cmi.core.score.raw'),
    mastery: g('cmi.student_data.mastery_score'),
    mode:    g('cmi.core.lesson_mode'),   // "review" = déjà tenté
    credit:  g('cmi.core.credit'),        // doit être "credit"
    entry:   g('cmi.core.entry'),
  };
}
```

### 5. Set + Commit

```js
() => {
  const api = window.API;
  if (!api || typeof api.LMSGetValue !== 'function') return {error: 'API not ready — wait 3-4s and retry'};
  const s = (k,v) => ({k, r: api.LMSSetValue(k,v), err: api.LMSGetLastError()});
  const log = [];
  log.push(s('cmi.core.score.raw','100'));
  log.push(s('cmi.core.score.min','0'));
  log.push(s('cmi.core.score.max','100'));
  log.push(s('cmi.core.lesson_status','passed'));   // PAS "completed" seul → Échec
  log.push(s('cmi.core.session_time','00:18:42'));  // durée plausible non-nulle
  log.push(s('cmi.core.exit',''));                  // '' = sortie normale
  log.push({commit: api.LMSCommit(''), err: api.LMSGetLastError()});
  return log; // chaque err doit être 0
}
```

### 6. Finish (sync final)

```js
() => {
  const api = window.API;
  api.LMSSetValue('cmi.core.score.raw','100');
  api.LMSSetValue('cmi.core.lesson_status','passed');
  api.LMSSetValue('cmi.core.exit','');
  return { commit: api.LMSCommit(''), finish: api.LMSFinish(''), err: api.LMSGetLastError() };
}
```

`LMSFinish` ferme le player et Workday redirige via `RedirectOnExitUrl`.

### 7. Vérification (reload leçon + programme)

```js
() => {
  const txt = document.body.innerText;
  return {
    statuts:  txt.match(/Statut\s*:\s*[^\n]+/g),
    achieved: /vous avez achevé|Leçon achevée|Completed/i.test(txt),
    progress: txt.match(/\d+\s*élément.*sur\s*\d+/gi),
    failed:   /Échec de la leçon|Failed/i.test(txt),  // doit être false
  };
}
```

Succès = leçon "Terminé" + programme "X obligatoire(s) terminé(s) sur X" + `failed: false`.

## Slide-skip Genially (si package gate l'API sur fin des slides)

```js
const btn = document.querySelector('[aria-label*="next page"],[aria-label="Go to the previous page"]');
if (!btn) return 'no nav button found — slide-skip not available for this package';
const key = Object.keys(btn).find(k=>k.startsWith('__reactFiber'));
let f = btn[key], nav;
while (f){ const p=f.memoizedProps; if(p?.navigator) nav=p.navigator; f=f.return; }
const slides = window.dataGeniallyOffline.Slides.filter(s=>!s.Hidden).sort((a,b)=>a.Order-b.Order);
for (const sl of slides){ nav.push('/'+sl.Id); await new Promise(r=>setTimeout(r,250)); }
```

⚠️ Ce bypass ne donne PAS le crédit seul — la procédure SCORM API est obligatoire.

## SCORM 2004 (`window.API_1484_11`)

```js
const api = window.API_1484_11;
api.SetValue('cmi.completion_status','completed');
api.SetValue('cmi.success_status','passed');
api.SetValue('cmi.score.scaled','1');
api.Commit('');
api.Terminate('');
```

## Pièges

| Piège | Fix |
|-------|-----|
| `lesson_status=completed` sans score | Workday affiche "Échec". Toujours `passed` + `score.raw=100`. |
| Contenu re-écrit le score après le set | `Commit` + `Finish` immédiatement, avant que le contenu re-commite. |
| `LMSFinish` oublié | La sync finale peut ne pas se faire. Toujours appeler Finish. |
| Sidebar dit "Échec" même si main panel dit "Terminé" | Les deux doivent être clean. |
| Pas de bouton launch, seulement "S'inscrire" | Enroller d'abord : S'inscrire → Soumettre → Démarrer le cours. |
| API absente juste après launch | Attendre 3-4s. Le player initialise async. |

## Quick reference

| Besoin | Élément SCORM 1.2 | Valeur |
|--------|-------------------|--------|
| Marquer passé | `cmi.core.lesson_status` | `passed` |
| Score | `cmi.core.score.raw/.min/.max` | `100/0/100` |
| Durée | `cmi.core.session_time` | `00:18:42` |
| Persister | `cmi.core.exit` | `''` |
| Sauver | `LMSCommit('')` | `"true"`, err `0` |
| Fermer | `LMSFinish('')` | `"true"` |
| Crédit | `cmi.core.credit` | doit être `credit` |
