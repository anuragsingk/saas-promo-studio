---
name: saas-promo-studio
description: Autonomously builds a complete AI SaaS promo video production system inside the current repository using Remotion, Playwright, FFmpeg, Piper TTS, ElevenLabs, OpenAI, and LTX Video. Use when the user wants to generate cinematic launch videos, onboarding demos, TikTok ads, or startup-style promos from their existing SaaS app — triggered by phrases like "build promo studio", "set up video pipeline", "create promo video system", or invoking /saas-promo-studio.
---

# AI SaaS Promo Video Studio

You are an elite AI systems engineer, motion designer, and SaaS launch filmmaker.

Build a **complete, autonomous "AI SaaS Promo Video Studio"** inside the current repository. Generate every file from scratch — production-ready, no TODOs in critical paths.

---

## Phase 0: Environment Validation + API Key Detection

**Do this BEFORE writing any files.** Fast-fail with clear error messages.

Run these checks and print a clear status table:

```
╔══════════════════════════════════════════════════════════════╗
║         SaaS Promo Studio — Environment Check                ║
╠══════════════════════════════════════════════════════════════╣
║  Node.js 18+        ✓ v20.11.0                               ║
║  FFmpeg             ✓ found (winget path)                    ║
║  Python 3.10+       ✓ v3.11.2  (optional)                   ║
║  Playwright         ✓ installed                              ║
╠══════════════════════════════════════════════════════════════╣
║  TTS Engine         → ElevenLabs (ELEVENLABS_API_KEY found)  ║
║  Video Gen          → Runway ML (RUNWAY_API_KEY found)       ║
║  Background Music   → Mubert (MUBERT_API_KEY found)         ║
║  Brand Scan         → Brandfetch (BRANDFETCH_API_KEY found)  ║
║  Stock Footage      → Pexels (PEXELS_API_KEY found)         ║
║  Whisper            ✗ not found — placeholder subs           ║
╚══════════════════════════════════════════════════════════════╝
```

Check each:
1. **Node.js** — `node --version`, must be 18+. EXIT if missing or too old.
2. **FFmpeg** — try `ffmpeg -version` + winget path search. Not fatal — placeholder video fallback.
3. **Python 3.10+** — optional. Note if missing.
4. **Playwright** — check `node_modules/@playwright/test`. Not fatal.
5. **API keys** — check `.env` (or `promo/.env`) for each key listed below. Print which engines are active.

**API keys to detect** (all optional, all have free tiers):
```
ELEVENLABS_API_KEY     → tier-1 TTS (free: 10k chars/month)
OPENAI_API_KEY         → tier-2 TTS + GPT analysis (free credits for new accounts)
GOOGLE_TTS_API_KEY     → tier-3 TTS (free: 4M chars/month standard)
RUNWAY_API_KEY         → AI video generation (free: 125 credits/month)
FAL_API_KEY            → AI video/image (freemium, cheap per-use)
PEXELS_API_KEY         → stock footage/photos (free, unlimited)
MUBERT_API_KEY         → AI background music (freemium)
BRANDFETCH_API_KEY     → brand color/logo auto-fetch (free: 10k req/month)
STABILITY_API_KEY      → AI image generation (free: 25 credits)
```

Print a one-line summary of which TTS engine will be used and which video sources are available.
Only EXIT if Node.js is missing or too old — everything else degrades gracefully.

---

## Phase 1: Repository Analysis + Brand Auto-Scan

Read these files before writing anything:
- `package.json`, `composer.json`, `README.md`, any config files
- Route files to understand URL structure and user flows
- `.env.example` for app URL / port hints

### Brand Auto-Scan (run ALL — best source wins)

**Priority 1 — Brandfetch API** (if `BRANDFETCH_API_KEY` is set):
```
GET https://api.brandfetch.io/v2/brands/{domain}
Headers: Authorization: Bearer {BRANDFETCH_API_KEY}
→ Extract: colors[].hex, logos[].formats[].src
→ This gives you the official brand colors instantly
```

**Priority 2 — Tailwind Config:**
```
Look for: tailwind.config.js / tailwind.config.ts
  → extract theme.extend.colors or theme.colors
  → find primary/accent/brand keys → grab hex values
```

**Priority 3 — CSS Variables:**
```
Look for: *.css, *.scss — scan for --primary, --accent, --brand, --color-*
Look for: variables.css, tokens.css, design-tokens.ts
Look for: resources/css/ (Laravel), styles/ (Next.js), src/styles/
```

**Logo Detection:**
```
Check in order:
  public/logo.svg, public/logo.png, public/favicon.svg
  resources/images/logo.svg, assets/logo.png, src/assets/logo.*
→ Copy found logo to remotion/public/logo.svg (or .png)
→ UICapture will overlay it on browser chrome frame
```

**Product Name + Tagline:**
```
1. README.md — first H1 = product name, first paragraph = tagline
2. package.json → "name" + "description"
3. .env.example → APP_NAME=...
4. config/app.php (Laravel) → 'name' => '...'
```

**Feature Detection:**
```
Scan route files: routes/web.php, pages/, app/, views.py
  → "DashboardController" → "Dashboard"
  → "InvoiceController" → "Invoicing"
```

Write ALL findings to `promo/ANALYSIS.md` before generating any other files.

---

## Phase 1b: Narrative Story Engine

Before writing any Remotion code, **choose the best narrative structure** for the product.

### The 7 Named Structures

**THE RAGE HOOK** (best for: tools fixing painful manual workflows)
```
Scene 1 [0–3s]:  FRUSTRATION — chaotic dashboard, red errors
Scene 2 [3–5s]:  SILENCE — black screen, single word: "Enough."
Scene 3 [5–9s]:  WHISPER — product name fades in softly
Scene 4 [9–25s]: REVEAL — smooth demo of the solution
Scene 5 [25–30s]: CTA — "Start free. No credit card."
Tone: Dark → relief → aspirational. Pacing: slow-fast-slow.
```

**THE TRANSFORMATION** (best for: before/after, productivity apps)
```
Scene 1 [0–5s]:  BEFORE — show the old painful way
Scene 2 [5–8s]:  PIVOT — wipe + "With [Product]:"
Scene 3 [8–22s]: AFTER — split screen: greyed old vs vivid new
Scene 4 [22–27s]: PROOF — counter-up: "3.2x faster."
Scene 5 [27–30s]: CTA — "Switch today."
```

**THE SOCIAL PROOF STORM** (best for: apps with users/reviews)
```
Scene 1 [0–4s]:  HOOK — "[X] teams switched this month"
Scene 2 [4–12s]: STORM — rapid-cut 6 testimonial quotes (2s each)
Scene 3 [12–20s]: DEMO — key feature, no voiceover — let it breathe
Scene 4 [20–26s]: NUMBERS — counter-up: users, reviews, countries
Scene 5 [26–30s]: CTA — "Join them."
```

**THE WHISPER REVEAL** (best for: AI tools, automation, "magic")
```
Scene 1 [0–6s]:  QUESTION — "What if your [problem] just... solved itself?"
Scene 2 [6–12s]: MAGIC — slow zoom into UI, feature activates with glow
Scene 3 [12–22s]: PROOF — output materialises on screen
Scene 4 [22–27s]: SIMPLICITY — "One click. Done."
Scene 5 [27–30s]: CTA — "See the magic."
```

**THE PROBLEM AGITATOR** (best for: compliance, security, ops)
```
Scene 1 [0–4s]:  STAT — scary industry statistic in huge type
Scene 2 [4–8s]:  AGITATE — "Most teams don't find out until it's too late."
Scene 3 [8–18s]: SOLUTION — product dashboard protecting them in real-time
Scene 4 [18–25s]: REASSURANCE — "Always watching. So you don't have to."
Scene 5 [25–30s]: CTA — "Get protected. Free trial."
```

**THE FOUNDER STORY** (best for: indie SaaS, personal brand)
```
Scene 1 [0–5s]:  ORIGIN — "I built this because I was tired of [pain]."
Scene 2 [5–15s]: BUILD — montage: code editor → first user → growth chart
Scene 3 [15–22s]: COMMUNITY — "Now [X] people use it every day."
Scene 4 [22–28s]: INVITE — "It's your turn."
Scene 5 [28–30s]: CTA — "Try it free."
```

**THE SPEED RUN** (best for: complex tools proving simplicity)
```
Scene 1 [0–2s]:  CLAIM — "From zero to [result] in 60 seconds."
Scene 2 [2–25s]: LIVE RUN — uncut real workflow, timer overlay
Scene 3 [25–28s]: RESULT — the output on screen
Scene 4 [28–30s]: CTA — "You just watched it. Now try it."
```

Record the chosen structure name in `promo/ANALYSIS.md`.

---

## Phase 2: Folder Structure

```
promo/
├── ANALYSIS.md
├── package.json
├── tsconfig.json
├── install.sh
├── install.ps1
├── .env
├── scripts/
│   ├── analyze.ts
│   ├── capture.ts            ← saves screenshots to remotion/public/captures/
│   ├── voiceover.ts          ← 6-tier TTS: ElevenLabs → OpenAI → Google → Piper → SAPI/say → silent
│   ├── subtitles.ts
│   ├── ffmpeg-pipeline.ts
│   ├── music.ts              ← AI background music: Mubert → Pixabay → silent
│   ├── render.ts             ← passes captures.json as props to Remotion
│   ├── social.ts
│   ├── stock.ts              ← Pexels/Coverr/Pixabay stock footage fetcher
│   ├── ltx-generate.ts
│   └── promo.ts
├── remotion/
│   ├── package.json
│   ├── tsconfig.json
│   ├── remotion.config.ts
│   └── src/
│       ├── index.ts          ← ENTRY POINT: registerRoot() only
│       ├── Root.tsx          ← Pure component — NO registerRoot
│       ├── compositions/
│       │   ├── LaunchVideo.tsx
│       │   ├── TikTokAd.tsx
│       │   ├── OnboardingDemo.tsx
│       │   ├── FeatureReveal.tsx
│       │   └── StartupPromo.tsx
│       ├── scenes/
│       │   ├── Hero.tsx
│       │   ├── FeatureShowcase.tsx
│       │   ├── UICapture.tsx    ← uses staticFile() + Img for real screenshots
│       │   ├── KineticText.tsx
│       │   ├── CTA.tsx
│       │   └── Transition.tsx
│       └── motion/
│           ├── cinematicSpring.ts
│           ├── gradients.ts
│           ├── cursorHighlight.tsx
│           ├── focusZoom.tsx
│           └── particles.tsx
├── remotion/public/
│   ├── captures/             ← Playwright PNGs here (used via staticFile())
│   │   └── captures.json     ← manifest: [{name, path, description}]
│   ├── audio/                ← TTS MP3s
│   ├── music/                ← background music tracks
│   └── stock/                ← downloaded stock footage clips
├── templates/
├── prompts/
└── output/
    ├── renders/
    └── social/
```

---

## Phase 3: Root Files

### promo/.env (FULL template with all API keys)

```env
# ── Required ─────────────────────────────────────────────
PROMO_APP_URL=http://localhost:8000
PROMO_EMAIL=admin@yourorg.test
PROMO_PASSWORD=yourpassword

# ── TTS / Voice (free tiers — add key to unlock) ─────────
# ElevenLabs: free 10k chars/month — https://elevenlabs.io
# ELEVENLABS_API_KEY=
# ELEVENLABS_VOICE_ID=EXAVITQu4vr4xnSDxMaL   # Sarah (free voice)

# OpenAI TTS + GPT copy: free credits for new accounts — https://platform.openai.com
# OPENAI_API_KEY=

# Google Cloud TTS: free 4M chars/month — https://cloud.google.com/text-to-speech
# GOOGLE_TTS_API_KEY=

# ── AI Video Generation (free tiers) ─────────────────────
# Runway ML Gen-3 Alpha: free 125 credits/month — https://runwayml.com
# RUNWAY_API_KEY=

# FAL.ai: freemium, cheap per-use — https://fal.ai
# FAL_API_KEY=

# Stability AI: free 25 credits — https://platform.stability.ai
# STABILITY_API_KEY=

# ── Stock Assets (free) ───────────────────────────────────
# Pexels: free unlimited — https://www.pexels.com/api
# PEXELS_API_KEY=

# ── Background Music (freemium) ───────────────────────────
# Mubert: freemium — https://mubert.com/render/pricing
# MUBERT_API_KEY=

# ── Brand Auto-Detect (free 10k req/month) ────────────────
# Brandfetch: https://developers.brandfetch.com
# BRANDFETCH_API_KEY=
```

### promo/package.json

```json
{
  "name": "saas-promo-studio",
  "version": "1.0.0",
  "scripts": {
    "promo":           "npx ts-node scripts/promo.ts",
    "capture":         "npx ts-node scripts/capture.ts",
    "render":          "npx ts-node scripts/render.ts",
    "social":          "npx ts-node scripts/social.ts",
    "launch-video":    "npx ts-node scripts/promo.ts --template=launch",
    "tiktok":          "npx ts-node scripts/promo.ts --template=tiktok",
    "onboarding":      "npx ts-node scripts/promo.ts --template=onboarding",
    "feature":         "npx ts-node scripts/promo.ts --template=feature",
    "startup":         "npx ts-node scripts/promo.ts --template=startup",
    "voiceover":       "npx ts-node scripts/voiceover.ts",
    "subtitles":       "npx ts-node scripts/subtitles.ts",
    "music":           "npx ts-node scripts/music.ts",
    "stock":           "npx ts-node scripts/stock.ts",
    "remotion:studio": "cd remotion && npx remotion studio",
    "remotion:render": "cd remotion && npx remotion render",
    "analyze":         "npx ts-node scripts/analyze.ts",
    "install:all":     "node -e \"require('child_process').execSync(process.platform==='win32'?'powershell -ExecutionPolicy Bypass -File install.ps1':'bash install.sh',{stdio:'inherit'})\""
  },
  "dependencies": {
    "remotion": "^4.0.0",
    "@remotion/player": "^4.0.0",
    "@remotion/cli": "^4.0.0",
    "@playwright/test": "^1.44.0",
    "playwright": "^1.44.0",
    "fluent-ffmpeg": "^2.1.3",
    "@types/fluent-ffmpeg": "^2.1.24",
    "ts-node": "^10.9.2",
    "typescript": "^5.4.0",
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "@types/react": "^18.2.0",
    "@types/react-dom": "^18.2.0",
    "minimist": "^1.2.8",
    "@types/minimist": "^1.2.5",
    "dotenv": "^16.4.5",
    "node-fetch": "^3.3.2"
  },
  "devDependencies": {
    "@types/node": "^20.14.0"
  }
}
```

### remotion/package.json

```json
{
  "name": "saas-promo-remotion",
  "version": "1.0.0",
  "scripts": {
    "start": "remotion studio",
    "render": "remotion render"
  },
  "dependencies": {
    "remotion": "^4.0.0",
    "@remotion/cli": "^4.0.0",
    "react": "^18.2.0",
    "react-dom": "^18.2.0"
  },
  "devDependencies": {
    "@types/react": "^18.2.0",
    "typescript": "^5.4.0"
  }
}
```

### remotion/tsconfig.json

```json
{
  "compilerOptions": {
    "lib": ["dom", "esnext"],
    "jsx": "react",
    "strict": false,
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "target": "esnext",
    "module": "commonjs",
    "moduleResolution": "node",
    "skipLibCheck": true
  }
}
```

### promo/tsconfig.json

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "lib": ["ES2020", "DOM"],
    "jsx": "react",
    "strict": true,
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "moduleResolution": "node",
    "resolveJsonModule": true,
    "outDir": "./dist",
    "rootDir": ".",
    "skipLibCheck": true
  },
  "include": ["scripts/**/*"],
  "exclude": ["node_modules", "dist"]
}
```

### remotion/remotion.config.ts

```typescript
import { Config } from '@remotion/cli/config';
Config.setVideoImageFormat('jpeg');
Config.setOverwriteOutput(true);
```

---

## Phase 4: Install Scripts

### install.sh (Unix) — same as before, add `node-fetch` note

```bash
#!/usr/bin/env bash
set -e
RESET='\033[0m'; BOLD='\033[1m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'; YELLOW='\033[1;33m'
log() { echo -e "${CYAN}[promo]${RESET} $1"; }
ok()  { echo -e "${GREEN}✓${RESET} $1"; }
warn(){ echo -e "${YELLOW}⚠${RESET}  $1"; }
echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${BOLD}  SaaS Promo Studio — Installer${RESET}"
echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
# FFmpeg
if command -v ffmpeg &>/dev/null; then ok "FFmpeg already installed"
else
  log "Installing FFmpeg..."
  if command -v brew &>/dev/null; then brew install ffmpeg
  elif command -v apt-get &>/dev/null; then sudo apt-get install -y ffmpeg
  elif command -v dnf &>/dev/null; then sudo dnf install -y ffmpeg
  else warn "Install FFmpeg manually: https://ffmpeg.org/download.html"; fi
fi
# Piper TTS (optional)
pip3 install piper-tts 2>/dev/null || warn "Piper TTS optional — ElevenLabs/SAPI/say fallback available"
# Whisper (optional)
pip3 install openai-whisper 2>/dev/null || warn "Whisper optional — placeholder subtitles will be used"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"
log "Installing Node dependencies..."; npm install; ok "Node deps done"
if [ ! -d "remotion/node_modules" ]; then
  log "Installing Remotion deps..."; cd remotion && npm install && cd ..; ok "Remotion deps done"
fi
npx playwright install chromium 2>/dev/null || warn "Run: npx playwright install chromium"
echo -e "\n${BOLD}${GREEN}Setup complete!${RESET}\n"
echo -e "  Add API keys to promo/.env to unlock premium features"
echo -e "  ${BOLD}npm run promo${RESET}  → Full pipeline"
```

### install.ps1 (Windows)

Same as before — write the full `.ps1` with:
- `-WithTTS` flag for Piper
- `-WithWhisper` flag for Whisper
- FFmpeg via winget
- No-BOM UTF-8 file writes using `[System.IO.File]::WriteAllText`
- Print API key hint at end

---

## Phase 5: Scripts

---

### CRITICAL: Screenshot Pipeline (How Real UI Gets Into Videos)

This is the most common failure point. Read this carefully before writing ANY script.

**The complete data flow:**

```
capture.ts
  → Playwright takes screenshots
  → saves PNG to: remotion/public/captures/01-dashboard.png
  → writes manifest: remotion/public/captures/captures.json
       [{ "name": "01-dashboard", "path": "captures/01-dashboard.png", "description": "..." }]
       ↑ NOTE: path is RELATIVE to remotion/public/ — this is how staticFile() finds it

promo.ts (after capture step)
  → reads remotion/public/captures/captures.json
  → extracts array of { name, path, description }
  → passes as props: { captures: [...], productName, tagline, features, colors }
  → calls renderComposition({ template, props: { captures, ... } })

render.ts
  → receives props (including captures array)
  → writes ALL props to tmpdir JSON file (avoids Windows shell quote issues)
  → calls: remotion render index.ts CompositionId output.mp4 --props="tmpfile.json"

Remotion composition (e.g. LaunchVideo.tsx)
  → receives { captures } as prop
  → routes screenshots to correct scenes:
      dashboard screenshot → UICapture scene showing the app
      feature screenshot   → FeatureShowcase scene
  → example:
      const dashboardShot = captures.find(c => c.name.includes('dashboard'))?.path;
      <Sequence from={210}><UICapture screenshotPath={dashboardShot} /></Sequence>

UICapture.tsx
  → uses Remotion's staticFile() + Img component:
      import { Img, staticFile } from 'remotion';
      {screenshotPath
        ? <Img src={staticFile(screenshotPath)} style={{ width: '100%', height: '100%', objectFit: 'cover' }} />
        : <MockUI />  ← only shown if no screenshot captured
      }
```

**Why `staticFile()` instead of a plain string path?**
Remotion bundles assets from the `remotion/public/` folder. `staticFile('captures/01-dashboard.png')` resolves correctly in both the Studio preview and the final render. A plain absolute path will break rendering.

**If the app was offline during capture**, `writePlaceholderManifest()` creates a `captures.json` with empty paths. Compositions check: `if (!screenshotPath) → render MockUI`. The video still renders — just with placeholder UI.

---

### scripts/capture.ts

Key implementation rules:
- Load `.env` via `dotenv.config({ path: path.join(__dirname, '..', '.env') })`
- `APP_URL = process.env.PROMO_APP_URL || 'http://localhost:8000'`
- **App reachability check**: try `page.goto(APP_URL, { timeout: 8000 })` — on failure call `writePlaceholderManifest()` and return. Do NOT throw.
- Screenshots saved to: `path.join(__dirname, '..', 'remotion', 'public', 'captures', `${step.name}.png`)`
- **CRITICAL: manifest paths must be relative to `remotion/public/`**:
  ```typescript
  const manifest = steps.map(step => ({
    name: step.name,
    path: `captures/${step.name}.png`,  // relative path for staticFile()
    description: step.description,
  }));
  fs.writeFileSync(
    path.join(CAPTURES_DIR, 'captures.json'),
    JSON.stringify(manifest, null, 2)
  );
  ```
- Each step: 1500ms breathing room between requests
- `highlight` selector: `page.evaluate(sel => { document.querySelector(sel)?.style.setProperty('outline', '3px solid #6B41F8') }, step.highlight)`
- `writePlaceholderManifest()`: writes manifest with same structure but empty `path: ''` values

---

### scripts/voiceover.ts

**6-tier TTS fallback chain** — tries in order, stops at first success:

```typescript
export type VoiceEmotion = 'calm' | 'energetic' | 'urgent' | 'warm' | 'whisper' | 'confident';

async function generateVoiceover(text: string, outputPath: string, emotion: VoiceEmotion = 'calm'): Promise<void> {
  if (await tryElevenLabs(text, outputPath, emotion))  return;
  if (await tryOpenAI(text, outputPath, emotion))      return;
  if (await tryGoogleTTS(text, outputPath, emotion))   return;
  if (await tryPiper(text, outputPath, emotion))       return;
  if (await trySAPI(text, outputPath, emotion))        return;
  await silentPlaceholder(outputPath);
}
```

**Tier 1 — ElevenLabs** (free: 10k chars/month, best quality + emotion):
```typescript
async function tryElevenLabs(text: string, outputPath: string, emotion: VoiceEmotion): Promise<boolean> {
  const apiKey = process.env.ELEVENLABS_API_KEY;
  if (!apiKey) return false;

  const VOICE_ID = process.env.ELEVENLABS_VOICE_ID || 'EXAVITQu4vr4xnSDxMaL'; // Sarah — free voice

  // Map emotion to ElevenLabs voice_settings
  const settings: Record<VoiceEmotion, { stability: number; similarity_boost: number; style: number; use_speaker_boost: boolean }> = {
    calm:       { stability: 0.75, similarity_boost: 0.75, style: 0.0,  use_speaker_boost: true  },
    energetic:  { stability: 0.45, similarity_boost: 0.80, style: 0.65, use_speaker_boost: true  },
    urgent:     { stability: 0.35, similarity_boost: 0.85, style: 0.85, use_speaker_boost: true  },
    warm:       { stability: 0.80, similarity_boost: 0.70, style: 0.20, use_speaker_boost: true  },
    whisper:    { stability: 0.90, similarity_boost: 0.65, style: 0.05, use_speaker_boost: false },
    confident:  { stability: 0.55, similarity_boost: 0.80, style: 0.40, use_speaker_boost: true  },
  };

  try {
    const res = await fetch(`https://api.elevenlabs.io/v1/text-to-speech/${VOICE_ID}`, {
      method: 'POST',
      headers: { 'xi-api-key': apiKey, 'Content-Type': 'application/json' },
      body: JSON.stringify({
        text,
        model_id: 'eleven_multilingual_v2',
        voice_settings: settings[emotion],
      }),
    });
    if (!res.ok) { console.warn(`  ElevenLabs: ${res.status} ${await res.text()}`); return false; }
    const mp3Path = outputPath.endsWith('.mp3') ? outputPath : outputPath + '.mp3';
    fs.writeFileSync(mp3Path, Buffer.from(await res.arrayBuffer()));
    console.log(`  ✓ ElevenLabs TTS [${emotion}]: ${mp3Path}`);
    return true;
  } catch (e) { console.warn(`  ElevenLabs failed: ${e}`); return false; }
}
```

**Tier 2 — OpenAI TTS** (freemium — new accounts get free credits, then $0.015/1k chars):
```typescript
async function tryOpenAI(text: string, outputPath: string, emotion: VoiceEmotion): Promise<boolean> {
  const apiKey = process.env.OPENAI_API_KEY;
  if (!apiKey) return false;

  // Map emotion → best OpenAI voice + speed
  const map: Record<VoiceEmotion, { voice: string; speed: number }> = {
    calm:       { voice: 'nova',    speed: 1.00 },
    energetic:  { voice: 'onyx',    speed: 1.18 },
    urgent:     { voice: 'fable',   speed: 1.28 },
    warm:       { voice: 'shimmer', speed: 0.95 },
    whisper:    { voice: 'alloy',   speed: 0.87 },
    confident:  { voice: 'echo',    speed: 1.08 },
  };
  const { voice, speed } = map[emotion];

  try {
    const res = await fetch('https://api.openai.com/v1/audio/speech', {
      method: 'POST',
      headers: { Authorization: `Bearer ${apiKey}`, 'Content-Type': 'application/json' },
      body: JSON.stringify({ model: 'tts-1', input: text, voice, speed }),
    });
    if (!res.ok) { console.warn(`  OpenAI TTS: ${res.status}`); return false; }
    const mp3Path = outputPath.endsWith('.mp3') ? outputPath : outputPath + '.mp3';
    fs.writeFileSync(mp3Path, Buffer.from(await res.arrayBuffer()));
    console.log(`  ✓ OpenAI TTS [${emotion}/${voice}]: ${mp3Path}`);
    return true;
  } catch (e) { console.warn(`  OpenAI TTS failed: ${e}`); return false; }
}
```

**Tier 3 — Google Cloud TTS** (free: 4M standard chars/month, 1M WaveNet/month):
```typescript
async function tryGoogleTTS(text: string, outputPath: string, emotion: VoiceEmotion): Promise<boolean> {
  const apiKey = process.env.GOOGLE_TTS_API_KEY;
  if (!apiKey) return false;

  const speedMap: Record<VoiceEmotion, number> = {
    calm: 1.0, energetic: 1.2, urgent: 1.35, warm: 0.95, whisper: 0.85, confident: 1.1
  };

  try {
    const res = await fetch(`https://texttospeech.googleapis.com/v1/text:synthesize?key=${apiKey}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        input: { text },
        voice: { languageCode: 'en-US', name: 'en-US-Neural2-F' }, // free Neural2
        audioConfig: { audioEncoding: 'MP3', speakingRate: speedMap[emotion] },
      }),
    });
    if (!res.ok) return false;
    const { audioContent } = await res.json() as { audioContent: string };
    const mp3Path = outputPath.endsWith('.mp3') ? outputPath : outputPath + '.mp3';
    fs.writeFileSync(mp3Path, Buffer.from(audioContent, 'base64'));
    console.log(`  ✓ Google TTS [${emotion}]: ${mp3Path}`);
    return true;
  } catch (e) { console.warn(`  Google TTS failed: ${e}`); return false; }
}
```

**Tier 4 — Piper TTS** (free, local neural):
- `echo "text" | piper --model en_US-lessac-high.onnx --length-scale SCALE --output_file out.wav`
- Length scale by emotion: calm=1.0, energetic=0.85, urgent=0.78, warm=1.05, whisper=1.15, confident=0.92
- Convert WAV→MP3 with FFmpeg after

**Tier 5 — macOS `say` / Windows SAPI** (free, built-in):
- macOS: `say -r RATE -o out.aiff "text"` (rates: calm=150, energetic=185, urgent=200, warm=140, whisper=130, confident=165)
- Windows SAPI: PowerShell `$s = New-Object System.Speech.Synthesis.SpeechSynthesizer; $s.Rate = RATE; $s.SetOutputToWaveFile(path); $s.Speak(text)`
- SAPI rates: calm=0, energetic=3, urgent=5, warm=-1, whisper=-3, confident=2

**Tier 6 — Silent placeholder** (always available):
- `ffmpeg -f lavfi -i anullsrc -t 30 out.mp3`

After any TTS: use `ffprobe` to get audio duration for Remotion timing sync.

---

### scripts/music.ts (NEW — Background Music)

**3-tier music chain:**

```typescript
async function generateMusic(durationSec: number, mood: string, outputPath: string): Promise<void> {
  if (await tryMubert(durationSec, mood, outputPath)) return;
  if (await tryPixabayMusic(mood, outputPath))        return;
  console.warn('  No background music — video will be voice + SFX only');
}
```

**Tier 1 — Mubert API** (freemium — limited free renders):
```typescript
async function tryMubert(durationSec: number, mood: string, outputPath: string): Promise<boolean> {
  const apiKey = process.env.MUBERT_API_KEY;
  if (!apiKey) return false;
  // POST https://api.mubert.com/v2/GetTrackByTags
  // tags: ["cinematic", "tech", "ambient"] based on mood
  // duration: durationSec
  // → returns mp3 URL → download to outputPath
  // Mood mapping: 'launch' → ['cinematic','epic'], 'tiktok' → ['energetic','pop'], etc.
  ...
}
```

**Tier 2 — Pixabay Music API** (completely free, no attribution needed):
```typescript
async function tryPixabayMusic(mood: string, outputPath: string): Promise<boolean> {
  // GET https://pixabay.com/api/videos/music/?key=KEY&q=MOOD&per_page=5
  // No key needed for basic search! Use: https://pixabay.com/api/music/?q=cinematic
  // Download first result, trim/loop to match video duration with FFmpeg
  ...
}
```

Mix background music at -18dB under voiceover using FFmpeg `amix` filter.

---

### scripts/stock.ts (NEW — Stock Footage)

Fetch B-roll footage to use in video transitions or background scenes:

**Pexels API** (completely free, high quality):
```typescript
async function fetchStockClip(query: string, outputPath: string): Promise<string | null> {
  const apiKey = process.env.PEXELS_API_KEY;
  if (!apiKey) return null;

  const res = await fetch(`https://api.pexels.com/videos/search?query=${encodeURIComponent(query)}&per_page=5&orientation=landscape`, {
    headers: { Authorization: apiKey },
  });
  const data = await res.json();
  const video = data.videos?.[0];
  const hdFile = video?.video_files?.find((f: any) => f.quality === 'hd');
  if (!hdFile) return null;

  // Download mp4
  const clip = await fetch(hdFile.link);
  fs.writeFileSync(outputPath, Buffer.from(await clip.arrayBuffer()));
  return outputPath;
}
```

Queries to use: `'technology dashboard'`, `'team collaboration'`, `'laptop workflow'`, `'startup office'`
Save to `remotion/public/stock/tech-bg.mp4` etc. Use as background in `<OffthreadVideo>` in Remotion.

---

### scripts/render.ts

Key rules (ALL of these are required):
- `findFfmpeg()` — winget portable path search on Windows
- Entry point: `remotion/src/index.ts` (NOT Root.tsx)
- **Write props to temp JSON file** (avoids Windows shell quote-stripping):
  ```typescript
  const propsFile = path.join(os.tmpdir(), `remotion-props-${Date.now()}.json`);
  fs.writeFileSync(propsFile, JSON.stringify(props || {}));
  // cmd includes: --props="${propsFile}"
  ```
- Run with `cwd: REMOTION_DIR`
- **Read captures.json and include in props**:
  ```typescript
  const capturesManifest = path.join(REMOTION_DIR, 'public', 'captures', 'captures.json');
  const captures = fs.existsSync(capturesManifest)
    ? JSON.parse(fs.readFileSync(capturesManifest, 'utf8'))
    : [];
  const fullProps = { ...props, captures };
  ```

```typescript
function findFfmpeg(): string {
  try { cp.execSync('ffmpeg -version', { stdio: 'pipe' }); return 'ffmpeg'; } catch {}
  const wingetBase = path.join(process.env.LOCALAPPDATA || '', 'Microsoft', 'WinGet', 'Packages');
  if (fs.existsSync(wingetBase)) {
    for (const pkg of fs.readdirSync(wingetBase)) {
      if (pkg.startsWith('Gyan.FFmpeg')) {
        for (const sub of fs.readdirSync(path.join(wingetBase, pkg))) {
          const exe = path.join(wingetBase, pkg, sub, 'bin', 'ffmpeg.exe');
          if (fs.existsSync(exe)) return `"${exe}"`;
        }
      }
    }
  }
  return 'ffmpeg';
}
```

---

### scripts/ffmpeg-pipeline.ts

Same `findFfmpeg()` as render.ts.

Social variants with dark padding (`0x0a0a0f`):
- YouTube 1920×1080 — direct scale
- TikTok 1080×1920 — pad with dark bg
- Instagram 1080×1080 — pad with dark bg
- Twitter 1280×720

Color grading:
```
eq=brightness=0.02:contrast=1.05:saturation=1.1,curves=preset=stronger_contrast,colorbalance=rs=-0.05:gs=0:bs=0.05
```

Subtitle burn-in: `FontName=Inter,FontSize=28,PrimaryColour=&HFFFFFF&,OutlineColour=&H40000000&,Outline=1.5,Shadow=1`

**Background music mix** (if `remotion/public/music/bg.mp3` exists):
```typescript
// ffmpeg -i video.mp4 -i bg.mp3 -filter_complex "[1:a]volume=0.12[bg];[0:a][bg]amix=inputs=2:duration=first" output.mp4
```

---

### scripts/promo.ts (Master Orchestrator)

```typescript
import minimist = require('minimist');
const argv = minimist(process.argv.slice(2));
const config = {
  template:      argv.template || argv.t || 'launch',
  duration:      parseInt(argv.duration || argv.d || '0', 10),
  skipCapture:   Boolean(argv['skip-capture'] || argv['no-capture']),
  skipVoiceover: Boolean(argv['skip-voice']   || argv['no-voice']),
  skipRender:    Boolean(argv['skip-render']  || argv['no-render']),
  skipComposite: Boolean(argv['skip-composite']),
  skipSocial:    Boolean(argv['skip-social']  || argv['no-social']),
  outputName:    argv.output || argv.o || `promo-${argv.template || 'launch'}`,
};
```

**7-step pipeline** (print numbered progress [1/7]):
1. `[1/7]` Capture UI → Playwright screenshots saved to `remotion/public/captures/`
2. `[2/7]` Fetch stock footage → `remotion/public/stock/` (if `PEXELS_API_KEY` set)
3. `[3/7]` Generate background music → `remotion/public/music/bg.mp3` (if `MUBERT_API_KEY` or Pixabay)
4. `[4/7]` Generate voiceovers → per-scene MP3s with emotion (ElevenLabs/OpenAI/Piper/SAPI)
5. `[5/7]` Generate subtitles → Whisper or placeholder JSON
6. `[6/7]` Render Remotion (reads `captures.json` automatically via render.ts)
7. `[7/7]` FFmpeg composite + social exports

**After step 1**, read captures.json and log which screenshots were captured:
```typescript
const manifestPath = path.join('remotion', 'public', 'captures', 'captures.json');
const captures = fs.existsSync(manifestPath)
  ? JSON.parse(fs.readFileSync(manifestPath, 'utf8'))
  : [];
console.log(`  Captured ${captures.filter((c: any) => c.path).length} screenshots`);
```

---

### scripts/analyze.ts

If `OPENAI_API_KEY` is available, use GPT-4o to generate richer product analysis:
```typescript
async function analyzeWithAI(repoText: string): Promise<string> {
  const apiKey = process.env.OPENAI_API_KEY;
  if (!apiKey) return fallbackAnalysis(repoText);

  const res = await fetch('https://api.openai.com/v1/chat/completions', {
    method: 'POST',
    headers: { Authorization: `Bearer ${apiKey}`, 'Content-Type': 'application/json' },
    body: JSON.stringify({
      model: 'gpt-4o-mini',   // cheap + fast
      messages: [{
        role: 'user',
        content: `You are a SaaS marketing expert. Analyse this codebase summary and extract:
1. Product name and one-line tagline
2. Top 6 features (each max 4 words)
3. Primary pain point this solves
4. Target audience
5. Three emotional hooks (curiosity/urgency/social proof)
6. Best narrative structure for a 30-second promo (choose from: Rage Hook, Transformation, Social Proof Storm, Whisper Reveal, Problem Agitator, Founder Story, Speed Run)

Codebase summary:
${repoText.slice(0, 4000)}

Respond in JSON.`
      }],
      response_format: { type: 'json_object' },
    }),
  });
  const data = await res.json() as any;
  return data.choices[0].message.content;
}
```

---

### scripts/ltx-generate.ts

If `RUNWAY_API_KEY` or `FAL_API_KEY` is available, use AI video generation as an alternative to Playwright:

**Runway ML** (free: 125 credits/month ≈ 5–10 short clips):
```typescript
async function generateWithRunway(prompt: string, outputPath: string): Promise<boolean> {
  const apiKey = process.env.RUNWAY_API_KEY;
  if (!apiKey) return false;
  // POST https://api.runwayml.com/v1/image_to_video or text_to_video
  // model: 'gen3a_turbo' (fastest, uses fewer credits)
  // Poll status URL until complete, then download mp4
  ...
}
```

**FAL.ai** (freemium, very cheap — $0.025 per 5s clip):
```typescript
async function generateWithFal(prompt: string, outputPath: string): Promise<boolean> {
  const apiKey = process.env.FAL_API_KEY;
  if (!apiKey) return false;
  // POST https://fal.run/fal-ai/kling-video/v1.5/standard/text-to-video
  // or: fal-ai/fast-svd-lcm (cheapest, $0.003/frame)
  // Headers: Authorization: Key {FAL_API_KEY}
  ...
}
```

**Stability AI** (free: 25 credits — use for still images/backgrounds):
```typescript
async function generateBackground(prompt: string, outputPath: string): Promise<boolean> {
  const apiKey = process.env.STABILITY_API_KEY;
  if (!apiKey) return false;
  // POST https://api.stability.ai/v2beta/stable-image/generate/core
  // body: { prompt, output_format: 'png', aspect_ratio: '16:9' }
  // Use as: background layer in Hero scene
  ...
}
```

**Local LTX Video** (GPU required — keep as fallback):
```python
# python scripts/ltx_gen.py "prompt" output.mp4
# Requires: CUDA 12.1+, ~20GB VRAM
# pip install ltx-video
```

---

## Phase 6: Remotion Components

### CRITICAL Rules for All Remotion Components

1. **NEVER call `useCurrentFrame()` inside `.map()`** — capture at component top:
   ```typescript
   const frame = useCurrentFrame(); // TOP of component
   items.map((item, i) => {
     const delay = i * 8;
     const progress = spring({ frame: Math.max(0, frame - delay), fps, config: cinematicSpring });
     return <div style={{ opacity: progress }} />;
   });
   ```

2. **`import * as React from 'react'` must be first line** of every TSX file.

3. **`gradients.ts`**: React import at TOP.

4. **ALL compositions must accept `captures` prop** and distribute screenshots to scenes:
   ```typescript
   interface CompositionProps {
     captures?: Array<{ name: string; path: string; description: string }>;
     durationSeconds?: number;
     productName?: string;
     tagline?: string;
     features?: string[];
   }
   ```

---

### remotion/src/index.ts ← ENTRY POINT

```typescript
import { registerRoot } from 'remotion';
import { RemotionRoot } from './Root';
registerRoot(RemotionRoot);
```

**Why**: Remotion auto-discovery only finds `src/index.ts` or `src/index.tsx`. `Root.tsx` alone is NOT discovered.

---

### remotion/src/Root.tsx ← PURE COMPONENT (no registerRoot)

```typescript
import * as React from 'react';
import { Composition } from 'remotion';  // NO registerRoot import
import { LaunchVideo } from './compositions/LaunchVideo';
import { TikTokAd } from './compositions/TikTokAd';
import { OnboardingDemo } from './compositions/OnboardingDemo';
import { FeatureReveal } from './compositions/FeatureReveal';
import { StartupPromo } from './compositions/StartupPromo';

export const RemotionRoot: React.FC = () => (
  <>
    <Composition id="LaunchVideo"    component={LaunchVideo}    durationInFrames={1800} fps={30} width={1920} height={1080} defaultProps={{ captures: [], productName: 'Product' }} />
    <Composition id="TikTokAd"       component={TikTokAd}       durationInFrames={450}  fps={30} width={1080} height={1920} defaultProps={{ captures: [] }} />
    <Composition id="OnboardingDemo" component={OnboardingDemo} durationInFrames={3600} fps={30} width={1920} height={1080} defaultProps={{ captures: [] }} />
    <Composition id="FeatureReveal"  component={FeatureReveal}  durationInFrames={720}  fps={30} width={1920} height={1080} defaultProps={{ captures: [] }} />
    <Composition id="StartupPromo"   component={StartupPromo}   durationInFrames={1350} fps={30} width={1920} height={1080} defaultProps={{ captures: [] }} />
  </>
);
// DO NOT call registerRoot here
```

---

### remotion/src/scenes/UICapture.tsx ← SCREENSHOT FIX

**This is the key component that must display real screenshots:**

```typescript
import * as React from 'react';
import { Img, staticFile, useCurrentFrame, useVideoConfig, spring } from 'remotion';
import { cinematicSpring, colors } from '../motion/cinematicSpring';
import { CursorHighlight } from '../motion/cursorHighlight';

interface UICapturePropTypes {
  screenshotPath?: string;   // e.g. "captures/01-dashboard.png" — relative to remotion/public/
  showBrowser?: boolean;     // show browser chrome frame
  label?: string;            // floating pill label
  highlightPos?: { x: number; y: number }; // cursor position
}

// Mock UI — only shown when no screenshot is available
const MockUI: React.FC = () => (
  <div style={{ width: '100%', height: '100%', background: colors.navy, display: 'flex', flexDirection: 'column', gap: 12, padding: 24 }}>
    <div style={{ height: 48, background: colors.cardBg, borderRadius: 8, border: `1px solid ${colors.border}` }} />
    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4,1fr)', gap: 12, flex: '0 0 auto' }}>
      {[0,1,2,3].map(i => (
        <div key={i} style={{ height: 80, background: colors.cardBg, borderRadius: 8, border: `1px solid ${colors.border}` }} />
      ))}
    </div>
    <div style={{ flex: 1, background: colors.cardBg, borderRadius: 8, border: `1px solid ${colors.border}` }} />
  </div>
);

export const UICapture: React.FC<UICapturePropTypes> = ({
  screenshotPath,
  showBrowser = true,
  label,
  highlightPos = { x: 0.6, y: 0.4 },
}) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();

  // Slide in from right
  const slideX = spring({ frame, fps, config: cinematicSpring, from: 80, to: 0 });
  const opacity = spring({ frame, fps, config: { mass: 0.8, damping: 20, stiffness: 80 }, from: 0, to: 1 });

  return (
    <div style={{ position: 'absolute', inset: 0, transform: `translateX(${slideX}px)`, opacity }}>
      {showBrowser && (
        <div style={{ position: 'absolute', top: 0, left: 0, right: 0, height: 36, background: '#1a1a2e', display: 'flex', alignItems: 'center', gap: 6, padding: '0 12px', borderRadius: '8px 8px 0 0', zIndex: 2 }}>
          {['#FF5F57','#FFBD2E','#28CA41'].map((c, i) => (
            <div key={i} style={{ width: 12, height: 12, borderRadius: '50%', background: c }} />
          ))}
          <div style={{ flex: 1, height: 20, background: 'rgba(255,255,255,0.06)', borderRadius: 4, marginLeft: 8 }} />
        </div>
      )}

      {/* Screenshot area */}
      <div style={{ position: 'absolute', top: showBrowser ? 36 : 0, left: 0, right: 0, bottom: 0, overflow: 'hidden', borderRadius: showBrowser ? '0 0 8px 8px' : 8 }}>
        {screenshotPath
          ? (
            // REAL screenshot from Playwright capture
            <Img
              src={staticFile(screenshotPath)}
              style={{ width: '100%', height: '100%', objectFit: 'cover', objectPosition: 'top' }}
            />
          )
          : <MockUI />  // Fallback — only if capture was skipped
        }
        <CursorHighlight x={highlightPos.x} y={highlightPos.y} frame={frame} fps={fps} />
      </div>

      {label && (
        <div style={{ position: 'absolute', bottom: 20, left: '50%', transform: 'translateX(-50%)', background: 'rgba(107,65,248,0.9)', backdropFilter: 'blur(8px)', color: '#fff', padding: '6px 16px', borderRadius: 20, fontSize: 13, fontWeight: 600, whiteSpace: 'nowrap' }}>
          {label}
        </div>
      )}
    </div>
  );
};
```

---

### remotion/src/compositions/LaunchVideo.tsx (screenshot-aware)

```typescript
import * as React from 'react';
import { Sequence } from 'remotion';

interface Capture { name: string; path: string; description: string; }

interface Props {
  captures?: Capture[];
  productName?: string;
  tagline?: string;
  features?: string[];
}

export const LaunchVideo: React.FC<Props> = ({
  captures = [],
  productName = 'Product',
  tagline = 'Your product tagline',
  features = ['Feature 1', 'Feature 2', 'Feature 3'],
}) => {
  // Map captures to scene slots by name pattern
  const get = (pattern: string) =>
    captures.find(c => c.name.toLowerCase().includes(pattern))?.path || undefined;

  const dashboardShot = get('dashboard') || get('home') || get('02');
  const featureShot   = get('feature')  || get('03');
  const loginShot     = get('login')    || get('01');

  return (
    <>
      <Sequence from={0}   durationInFrames={90}>
        <Hero productName={productName} />
      </Sequence>
      <Sequence from={90}  durationInFrames={120}>
        <KineticText text={tagline} mode="slide-up" emotion="whisper" />
      </Sequence>
      <Sequence from={210} durationInFrames={240}>
        <UICapture screenshotPath={dashboardShot} showBrowser label="Dashboard" />
      </Sequence>
      <Sequence from={450} durationInFrames={300}>
        <FeatureShowcase features={features} screenshotPath={featureShot} />
      </Sequence>
      <Sequence from={750} durationInFrames={750}>
        <UICapture screenshotPath={dashboardShot} showBrowser label="Live Data" />
      </Sequence>
      <Sequence from={1500} durationInFrames={300}>
        <CTA headline={`Try ${productName} free`} subtext="No credit card required" />
      </Sequence>
    </>
  );
};
```

Apply the same pattern to ALL other compositions — each one receives `captures` prop and uses `captures.find(c => c.name.includes('pattern'))?.path` to get the right screenshot for each scene.

---

### remotion/src/motion/cinematicSpring.ts

```typescript
export const cinematicSpring = { mass: 0.8, damping: 20, stiffness: 90 };
export const snappySpring    = { mass: 0.5, damping: 18, stiffness: 150 };
export const gentleSpring    = { mass: 1.2, damping: 28, stiffness: 60  };

export const colors = {
  bg: '#0a0a0f', navy: '#12102a', navyLight: '#1e1b4b',
  accent: '#6B41F8', blue: '#4361EE', green: '#00C896',
  glow: '#a855f7', text: '#f8fafc', muted: '#64748b',
  border: 'rgba(107, 65, 248, 0.2)', cardBg: 'rgba(255, 255, 255, 0.04)',
};

export const gradients = {
  heroGradient: 'radial-gradient(ellipse at 20% 50%, #1e1b4b 0%, #0a0a0f 50%, #0c1a0c 100%)',
  accentGlow:   'radial-gradient(ellipse at center, rgba(107,65,248,0.3) 0%, transparent 70%)',
  cardGradient: 'linear-gradient(135deg, rgba(255,255,255,0.06) 0%, rgba(255,255,255,0.02) 100%)',
  textGradient: 'linear-gradient(135deg, #6B41F8 0%, #4361EE 100%)',
};
```

Customise `colors.accent` from brand scan (Brandfetch API > Tailwind > CSS vars).

---

### remotion/src/motion/gradients.ts

```typescript
import * as React from 'react';  // MUST be first line

export function animatedGradientStyle(frame: number): React.CSSProperties {
  const shift = (frame / 2) % 360;
  return {
    background: `radial-gradient(ellipse at ${50 + 30 * Math.sin(shift * 0.017)}% ${50 + 20 * Math.cos(shift * 0.013)}%, #1e1b4b 0%, #0a0a0f 60%, #0c1a0c 100%)`,
  };
}

export function pulseGlowStyle(frame: number, color = 'rgba(107,65,248,0.4)'): React.CSSProperties {
  const pulse = 0.5 + 0.5 * Math.sin((frame / 30) * Math.PI);
  return {
    boxShadow: `0 0 ${40 + 20 * pulse}px ${color}, 0 0 ${80 + 40 * pulse}px ${color.replace('0.4', '0.15')}`,
  };
}
```

### Particles (deterministic — never Math.random() inside render)

```typescript
const SEED_PARTICLES = Array.from({ length: 80 }, (_, i) => ({
  id: i, x: (i * 137.508 + 23) % 100, y: (i * 73.1 + 11) % 100,
  size: 1 + (i % 3), speed: 0.15 + (i % 5) * 0.08,
  opacity: 0.1 + (i % 4) * 0.07, drift: (i % 7 - 3) * 0.03,
}));
```

### Composition Timing (30fps)

| Composition | Duration | Key scenes |
|-------------|----------|------------|
| LaunchVideo | 1800fr (60s) | 0–90: logo, 90–210: tagline, 210–450: dashboard screenshot, 450–750: features, 1500–1800: CTA |
| TikTokAd | 450fr (15s) | 0–60: hook, 60–150: problem, 150–360: UI screenshot, 360–450: CTA |
| OnboardingDemo | 3600fr (2min) | 8 steps × 360fr each — each step shows its own screenshot |
| FeatureReveal | 720fr (24s) | 4 features × 180fr — each with feature screenshot |
| StartupPromo | 1350fr (45s) | 0–150: punch stat, 150–360: CountUp, 360–750: split-screen screenshot |

---

## Phase 7: Marketing Content Files

### prompts/hooks.md — 20+ hooks

Use all 7 narrative structures. For each, write 2–3 hooks customised to the real product from ANALYSIS.md.

### prompts/ad-scripts.md — Full scripts for all 5 templates

Label each scene's emotion: `[EMOTION: urgent]`, `[EMOTION: warm]`, etc.
Write at 15s / 30s / 60s / 2min durations.

### prompts/cta-copy.md — 15+ CTA variants

### templates/*.md — Scene-by-scene breakdowns with timing markers

---

## Phase 8: README

Generate `promo/README.md` with:
- Quick start (3 commands)
- All commands table
- All flags: `--template`, `--duration`, `--skip-*`, `--no-social`
- `.env` API key guide (which key unlocks what)
- Narrative structures overview
- Freemium API tiers table
- Customisation guide (voice model, colours, Playwright flows)
- Troubleshooting section

---

## Implementation Rules

1. **`npx ts-node`** — always prefix with `npx`
2. **No hooks inside `.map()`** — capture `frame` at component top
3. **React imports first** — `import * as React from 'react'` first line of every TSX
4. **Cross-platform FFmpeg** — `findFfmpeg()` with winget path search
5. **App-not-running is graceful** — capture.ts falls back to placeholder manifest
6. **`UICapture` uses `staticFile()`** — NEVER use absolute or relative path strings for Remotion `<Img>`. Always: `<Img src={staticFile(screenshotPath)} />`
7. **`captures.json` paths are relative to `remotion/public/`** — write `"captures/01-dashboard.png"` not the full disk path
8. **`render.ts` always reads `captures.json`** — merges into props before writing temp file
9. **All compositions receive `captures` prop** — and use `.find()` to route screenshots to the right scene
10. **Windows SAPI is the free TTS** — auto-detect and use SAPI without Piper
11. **Remotion entry = `src/index.ts`** — NOT Root.tsx. `registerRoot` ONLY in `index.ts`
12. **Props via temp file** — write Remotion props to tmpdir JSON, pass `--props="file.json"`
13. **No BOM on Windows** — `[System.IO.File]::WriteAllText` with `UTF8Encoding::new($false)` in PS1
14. **Deterministic particles** — precompute seed array, never `Math.random()` inside render
15. **TTS is 6-tier** — ElevenLabs → OpenAI → Google → Piper → SAPI/say → silent
16. **`music.ts` mixes at -18dB** — background music never drowns voiceover
17. **Stock footage is optional** — Pexels only if `PEXELS_API_KEY` set; skip silently if not
18. **AI video gen is optional** — Runway/FAL only if keys set; fall back to Playwright screenshots
19. **Phase 0 first** — always run environment + API key detection before writing files
20. **Brand colors from Brandfetch first** — fall back to Tailwind → CSS vars → defaults

---

## Completion Checklist

- [ ] Phase 0 env + API key table printed
- [ ] `promo/ANALYSIS.md` — real data + chosen narrative + brand colors source noted (Brandfetch/Tailwind/CSS/default)
- [ ] `promo/.env` — full template with all API key slots and comments
- [ ] `promo/package.json` — includes `node-fetch`, `minimist`, `dotenv`, `@types/fluent-ffmpeg`
- [ ] `promo/tsconfig.json`
- [ ] `promo/install.sh` + `promo/install.ps1`
- [ ] `promo/scripts/analyze.ts` — GPT-4o enhanced if OPENAI_API_KEY available
- [ ] `promo/scripts/capture.ts` — manifest paths relative to `remotion/public/`
- [ ] `promo/scripts/voiceover.ts` — 6-tier chain with emotion per scene
- [ ] `promo/scripts/music.ts` — Mubert → Pixabay → silent
- [ ] `promo/scripts/stock.ts` — Pexels fetch + download
- [ ] `promo/scripts/subtitles.ts`
- [ ] `promo/scripts/ffmpeg-pipeline.ts` — `findFfmpeg()` + music mix + social exports
- [ ] `promo/scripts/render.ts` — reads `captures.json` → merges into props → temp file
- [ ] `promo/scripts/promo.ts` — 7-step pipeline + reads captures count after step 1
- [ ] `promo/scripts/social.ts`
- [ ] `promo/scripts/ltx-generate.ts` — Runway → FAL → Stability → local LTX fallback
- [ ] `remotion/package.json`
- [ ] `remotion/tsconfig.json` — `"strict": false`
- [ ] `remotion/remotion.config.ts`
- [ ] `remotion/src/index.ts` — `registerRoot(RemotionRoot)` ONLY
- [ ] `remotion/src/Root.tsx` — pure component, `defaultProps: { captures: [] }`, NO registerRoot
- [ ] `remotion/src/motion/cinematicSpring.ts`
- [ ] `remotion/src/motion/gradients.ts` — React import first
- [ ] `remotion/src/motion/cursorHighlight.tsx`
- [ ] `remotion/src/motion/focusZoom.tsx`
- [ ] `remotion/src/motion/particles.tsx` — deterministic seeds
- [ ] `remotion/src/scenes/UICapture.tsx` — `<Img src={staticFile(screenshotPath)} />`, MockUI fallback
- [ ] `remotion/src/scenes/KineticText.tsx` — emotion prop, no hooks in map
- [ ] `remotion/src/scenes/Hero.tsx`
- [ ] `remotion/src/scenes/FeatureShowcase.tsx` — no hooks in map
- [ ] `remotion/src/scenes/CTA.tsx`
- [ ] `remotion/src/scenes/Transition.tsx`
- [ ] `remotion/src/compositions/LaunchVideo.tsx` — `captures` prop, screenshot routing via `.find()`
- [ ] `remotion/src/compositions/TikTokAd.tsx` — `captures` prop
- [ ] `remotion/src/compositions/OnboardingDemo.tsx` — `captures` prop, each step gets own screenshot
- [ ] `remotion/src/compositions/FeatureReveal.tsx` — `captures` prop, no hooks in map
- [ ] `remotion/src/compositions/StartupPromo.tsx` — `captures` prop, CountUp component
- [ ] `remotion/public/captures/` directory
- [ ] `remotion/public/audio/` directory
- [ ] `remotion/public/music/` directory
- [ ] `remotion/public/stock/` directory
- [ ] `promo/output/renders/` + `promo/output/social/`
- [ ] `promo/prompts/hooks.md` — 20+ hooks across all 7 structures
- [ ] `promo/prompts/ad-scripts.md` — with emotion labels per scene
- [ ] `promo/prompts/cta-copy.md`
- [ ] `promo/templates/*.md`
- [ ] `promo/README.md`

After all files, print:

```
✓ SaaS Promo Studio built in promo/
  Narrative: [STRUCTURE]  |  TTS: [ENGINE]  |  Screenshots: [N] captured
  Brand: [COLOR] from [SOURCE]  |  Logo: [found/not found]

APIs active: [list which keys were found]

Quick start:
  1. Edit promo/.env (your app URL + any API keys)
  2. Start your app → php artisan serve / npm run dev
  3. cd promo && bash install.sh  (or: powershell -File install.ps1)
  4. npm run promo

Flags:
  --template=tiktok --duration=30
  --skip-capture --skip-voice   (re-render only)
  --no-social                   (skip platform exports)

Output:
  promo/output/renders/  ← master MP4
  promo/output/social/   ← TikTok / YouTube / Instagram / Twitter

Remotion Studio (visual editor):
  npm run remotion:studio  → http://localhost:3000
```
