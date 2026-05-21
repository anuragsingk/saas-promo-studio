# saas-promo-studio

[![Watch Demo](https://img.shields.io/badge/▶%20Watch-Demo%20Video-6B41F8?style=for-the-badge)](https://github.com/anuragsingk/saas-promo-studio/blob/main/LaunchVideo.mp4)

A Claude Code skill that autonomously builds a **complete AI SaaS promo video production system** inside any existing web application repository.

One command. Full pipeline. Cinematic output.

> **No API keys. No subscriptions. Runs fully offline.**

---

## Before you start — install these two things

> **New to this? Start here.** You only do this once.

### 1. Node.js (free)
Download the **LTS** version from **[nodejs.org](https://nodejs.org)** and install it.
Verify it worked: open a terminal and type `node -v` — you should see a version number.

### 2. Claude Code (free)
This skill runs inside Claude Code — Anthropic's AI coding tool.

```bash
# Mac / Linux — paste this in your terminal:
curl -fsSL https://claude.ai/install.sh | sh

# Windows — download the installer from:
# https://claude.ai/claude-code
```

After installing, type `claude` in your terminal to open it.

---

## Install the skill — one command

Once Claude Code is installed, run this once to add the skill:

**Mac / Linux** — paste in Terminal:
```bash
curl -fsSL https://raw.githubusercontent.com/anuragsingk/saas-promo-studio/main/install.sh | bash
```

**Windows** — paste in PowerShell:
```powershell
irm https://raw.githubusercontent.com/anuragsingk/saas-promo-studio/main/install.ps1 | iex
```

Restart Claude Code → the skill is ready. No other installs needed at this point.

---

## What it does

Drop this skill into Claude Code, open any SaaS project, and type `/saas-promo-studio`. Claude will:

1. **Validate your environment** — checks Node.js, FFmpeg, Python, Playwright + all API keys upfront. Prints a clear status table.
2. **Analyse your app** — reads your codebase, identifies features, user flows, selling points, and brand colours
3. **Auto-scan your brand** — Brandfetch API → Tailwind config → CSS variables → logo file detection
4. **Choose a narrative structure** — picks the best storytelling arc (Rage Hook, Transformation, Social Proof Storm, etc.) for your product type
5. **Build the entire video system** — generates every file from scratch inside a `promo/` folder
6. **Record your UI** — Playwright screenshots saved directly to Remotion's public folder — **actually used in videos**
7. **Fetch stock footage** — Pexels API (free) for B-roll and background clips
8. **Generate voiceovers** — ElevenLabs → OpenAI → Google → Piper → SAPI/say → silent (6-tier chain, per-scene emotion)
9. **Generate background music** — Mubert AI → Pixabay (both free tiers) → mixed at -18dB under voice
10. **Auto-subtitle** — Whisper transcription → SRT → burned into video
11. **Render cinematic video** — Remotion React compositions with spring animations, using your real UI screenshots
12. **Export all social formats** — YouTube, TikTok, Instagram, Twitter via FFmpeg

**Output**: master MP4 + 4 platform-sized social variants, ready to post.

---

## Tech stack — Core (zero API keys required)

| Tool | Role | License |
|------|------|---------|
| [Remotion](https://remotion.dev) | React → video renderer | Free (open source) |
| [Playwright](https://playwright.dev) | UI capture / browser automation | Apache 2.0 |
| [FFmpeg](https://ffmpeg.org) | Video compositing + social exports | LGPL |
| [Piper TTS](https://github.com/rhasspy/piper) | Neural offline voiceover | MIT |
| [Whisper](https://github.com/openai/whisper) | Auto-subtitles from audio | MIT |
| [LTX Video](https://github.com/Lightricks/LTX-Video) | AI-generated video clips (GPU, optional) | Apache 2.0 |

**Works 100% offline with zero API keys. Add optional keys to unlock better quality.**

---

## Freemium API Integrations

Every API below has a **free tier**. Add the key to `promo/.env` — the skill auto-detects it and upgrades that pipeline step automatically. No key = graceful fallback.

### Voice / TTS

| Service | Free Tier | What you get | Key |
|---------|-----------|--------------|-----|
| [ElevenLabs](https://elevenlabs.io) | **10,000 chars/month** | Best quality, 6 emotion modes, 1000s of voices | `ELEVENLABS_API_KEY` |
| [OpenAI TTS](https://platform.openai.com/docs/guides/text-to-speech) | **Free credits for new accounts** | Excellent quality, 6 voices, speed control | `OPENAI_API_KEY` |
| [Google Cloud TTS](https://cloud.google.com/text-to-speech/pricing) | **4M chars/month** (standard), 1M Neural2 | Good quality, many voices | `GOOGLE_TTS_API_KEY` |
| Piper TTS | **Free forever** (local) | Offline neural voice | `pip install piper-tts` |
| macOS `say` | **Free** (built-in) | System voice | No key needed |
| Windows SAPI | **Free** (built-in) | System voice + emotion rate | No key needed |

### AI Video Generation

| Service | Free Tier | What you get | Key |
|---------|-----------|--------------|-----|
| [Runway ML](https://runwayml.com) | **125 credits/month** (~5–10 clips) | Gen-3 Alpha video from text/image | `RUNWAY_API_KEY` |
| [FAL.ai](https://fal.ai) | **Freemium** ($0.025 per 5s clip) | Fast video generation, multiple models | `FAL_API_KEY` |
| [Stability AI](https://platform.stability.ai) | **25 free credits** | AI backgrounds + still images | `STABILITY_API_KEY` |
| Local LTX Video | **Free** (needs NVIDIA GPU) | Offline AI video, ~20GB VRAM | `pip install ltx-video` |

### Stock Footage & Photos

| Service | Free Tier | What you get | Key |
|---------|-----------|--------------|-----|
| [Pexels](https://www.pexels.com/api) | **Unlimited** (free) | HD stock footage + photos, no attribution | `PEXELS_API_KEY` |
| [Pixabay](https://pixabay.com/api/docs) | **Unlimited** (free) | Stock video + photos + music | No key (or get one for more results) |

### Background Music

| Service | Free Tier | What you get | Key |
|---------|-----------|--------------|-----|
| [Mubert](https://mubert.com/render/pricing) | **Freemium** | AI-generated music matched to mood | `MUBERT_API_KEY` |
| Pixabay Music | **Free** | Royalty-free tracks by genre | No key needed |

### Brand Detection

| Service | Free Tier | What you get | Key |
|---------|-----------|--------------|-----|
| [Brandfetch](https://developers.brandfetch.com) | **10,000 req/month** | Official brand colors + logos by domain | `BRANDFETCH_API_KEY` |

### AI Copy & Analysis

| Service | Free Tier | What you get | Key |
|---------|-----------|--------------|-----|
| [OpenAI GPT-4o mini](https://platform.openai.com) | **Free credits** for new accounts | Better product analysis, smarter hooks | `OPENAI_API_KEY` (same key as TTS) |

---

### Which keys to get first?

**Priority order** (biggest quality uplift per 5 minutes of effort):

1. **`PEXELS_API_KEY`** — takes 30 seconds, completely free, huge visual upgrade
2. **`ELEVENLABS_API_KEY`** — takes 2 minutes, free 10k chars/month, voice quality jumps dramatically
3. **`BRANDFETCH_API_KEY`** — takes 2 minutes, free 10k req/month, auto-fills your real brand colors
4. **`OPENAI_API_KEY`** — if you already have one, unlocks both TTS and smarter analysis
5. **`RUNWAY_API_KEY`** — only needed if you want AI-generated B-roll scenes

---

## Requirements

| Requirement | Why | Install |
|-------------|-----|---------|
| **Node.js 18+** | Runs the promo scripts and Remotion | [nodejs.org](https://nodejs.org) → click LTS |
| **Claude Code** | The app this skill runs inside | [claude.ai/claude-code](https://claude.ai/claude-code) |
| FFmpeg | Video compositing — **auto-installed** by our script | Nothing to do |
| Python 3.10+ | Neural TTS + auto-subtitles — **optional** | [python.org](https://python.org) |

**Minimum setup**: Node.js + Claude Code. Everything else is handled automatically or optional.

---

## Installation

### Option A — One-liner (recommended, no git needed)

**Mac / Linux**
```bash
curl -fsSL https://raw.githubusercontent.com/anuragsingk/saas-promo-studio/main/install.sh | bash
```

**Windows (PowerShell)**
```powershell
irm https://raw.githubusercontent.com/anuragsingk/saas-promo-studio/main/install.ps1 | iex
```

### Option B — Git clone

**Mac / Linux**
```bash
git clone https://github.com/anuragsingk/saas-promo-studio \
  ~/.claude/skills/saas-promo-studio
```

**Windows**
```powershell
git clone https://github.com/anuragsingk/saas-promo-studio `
  "$env:USERPROFILE\.claude\skills\saas-promo-studio"
```

### After installing — restart Claude Code

Close and reopen Claude Code. The skill appears automatically — no config needed.

---

## Usage

### 1. Open your SaaS project in Claude Code

```bash
cd /path/to/your-saas-app
claude
```

### 2. Invoke the skill

```
/saas-promo-studio
```

Claude will:
- Run an **environment check** (prints a clear status table — know exactly what works)
- **Auto-scan your brand** (extracts Tailwind colours, CSS variables, logo files)
- **Pick a narrative structure** that matches your product type
- Generate the entire `promo/` system

### 3. Configure your app URL

Edit `promo/.env`:
```env
PROMO_APP_URL=http://localhost:8000    # your dev server URL
PROMO_EMAIL=admin@yourorg.test         # login credentials for Playwright capture
PROMO_PASSWORD=yourpassword
```

### 4. Start your app + run the installer

```bash
# Terminal 1 — start your app
php artisan serve          # Laravel
# or: npm run dev          # Next.js / Vite
# or: python manage.py runserver  # Django

# Terminal 2 — install promo deps
cd promo

# Mac / Linux
bash install.sh

# Windows (core — fast, no heavy Python deps)
powershell -ExecutionPolicy Bypass -File install.ps1

# Windows with neural TTS
powershell -ExecutionPolicy Bypass -File install.ps1 -WithTTS

# Windows with auto-subtitles
powershell -ExecutionPolicy Bypass -File install.ps1 -WithTTS -WithWhisper
```

### 5. Generate your first video

```bash
npm run promo
```

Your video is saved to `promo/output/renders/` with social variants in `promo/output/social/`.

---

## All commands

| Command | What it does |
|---------|-------------|
| `npm run promo` | Full 7-step pipeline — capture → stock → music → voice → subtitles → render → social |
| `npm run launch-video` | 60s Apple-style launch video |
| `npm run tiktok` | 15s TikTok / Instagram Reels ad (9:16) |
| `npm run onboarding` | 2-minute product walkthrough (8 steps) |
| `npm run feature` | Feature reveal — 4 features × 6s |
| `npm run startup` | 45s Stripe/Arc-style startup promo |
| `npm run capture` | Playwright UI capture only (saves real screenshots to Remotion) |
| `npm run voiceover` | Generate voiceovers only (ElevenLabs/OpenAI/Piper/SAPI) |
| `npm run music` | Generate background music only (Mubert/Pixabay) |
| `npm run stock` | Fetch stock footage only (Pexels) |
| `npm run subtitles` | Generate subtitles from audio |
| `npm run render` | Remotion render only (uses captured screenshots automatically) |
| `npm run social` | Export social format variants only |
| `npm run remotion:studio` | Open Remotion visual editor in browser |
| `npm run analyze` | Re-run product analysis (GPT-4o enhanced if OPENAI_API_KEY set) |

### Template flag
```bash
npm run promo -- --template=tiktok
npm run promo -- --template=onboarding --output=my-walkthrough
```

### Duration flag
```bash
npm run promo -- --duration=30   # 30-second video
npm run promo -- --duration=60   # 60-second video (default for launch)
npm run promo -- --duration=90   # 90-second video
```

### Skip flags (for faster re-runs)
```bash
npm run promo -- --skip-capture    # reuse existing screenshots
npm run promo -- --skip-voice      # reuse existing audio
npm run promo -- --skip-render     # skip Remotion render
npm run promo -- --no-social       # skip social format exports
```

---

## Narrative Story Structures

One of this skill's most powerful features: Claude automatically picks the best **narrative arc** for your product, then writes all voiceover scripts, hook copy, and Remotion scene ordering to match.

### The 7 Structures

**THE RAGE HOOK** — *Best for: tools that fix genuinely painful workflows*
> Frustration → Silence → Whisper → Reveal → CTA
> Dark, cathartic pacing. "Enough." moment in the middle.

**THE TRANSFORMATION** — *Best for: before/after tools, productivity apps*
> Before (pain) → Pivot ("With [Product]:") → After (vivid side-by-side) → Proof stat → CTA
> Split-screen contrast. Counter-up numbers as proof.

**THE SOCIAL PROOF STORM** — *Best for: apps with users, reviews, or team adoption*
> Hook stat → Rapid testimonial cuts → Silent demo → Numbers → "Join them."
> Social momentum and FOMO. Testimonials speak for you.

**THE WHISPER REVEAL** — *Best for: AI tools, automation, "magic" features*
> Question → Magic activation → Output materialises → "One click." → CTA
> Mysterious, wonder-building. Let the result do the talking.

**THE PROBLEM AGITATOR** — *Best for: compliance, security, ops tools*
> Scary stat → Agitate the risk → Solution protecting them → Reassurance → CTA
> Alarming → tension → relief → safety.

**THE FOUNDER STORY** — *Best for: indie SaaS, personal brand products*
> Origin → Build montage → Community → Invitation → CTA
> Authentic, humble, inspiring.

**THE SPEED RUN** — *Best for: complex tools proving simplicity*
> Bold claim → Live uncut demo with timer → Result on screen → "You just watched it." → CTA
> Proof by doing. No hype — just the real thing.

The chosen structure is recorded in `promo/ANALYSIS.md` and `promo/prompts/ad-scripts.md`.

---

## Output files

| File | Dimensions | Best for |
|------|-----------|----------|
| `*-master.mp4` | 1920×1080 | Source master |
| `*-youtube.mp4` | 1920×1080 | YouTube, LinkedIn |
| `*-tiktok.mp4` | 1080×1920 | TikTok, Instagram Reels |
| `*-instagram.mp4` | 1080×1080 | Instagram square |
| `*-twitter.mp4` | 1280×720 | Twitter / X |

All outputs: H.264, AAC audio, web-compatible.

---

## Video templates

### LaunchVideo — 60s, 16:9
Apple event-style cinematic launch video.
- Logo reveal with glow + particle field
- Hero tagline with word-by-word spring animation
- Dashboard screenshot with browser chrome frame
- Feature grid with staggered card animations
- AI feature callouts (split-screen text + UI)
- CTA with particle burst

### TikTokAd — 15s, 9:16
Hook → Problem → Demo → CTA.
- Hook text slap with scale-in animation
- Pain point list sliding in from left
- Rapid-cut UI demo with product badge
- CTA with star rating social proof

### OnboardingDemo — 2min, 16:9
8-step product walkthrough. Left panel shows step info + progress bar; right panel shows the live UI capture.

### FeatureReveal — 24s, 16:9
Linear / Vercel aesthetic. 4 features × 6 seconds each. Feature name, tagline, bullet points with animated dots, UI screenshot.

### StartupPromo — 45s, 16:9
Stripe / Arc inspired. Opening punch stat → social proof counter-up numbers → before/after split screen → dashboard product shot → CTA.

---

## What gets generated

```
promo/
├── ANALYSIS.md              ← auto-generated product analysis + narrative structure
├── package.json
├── tsconfig.json
├── install.sh               ← Mac/Linux one-command installer
├── install.ps1              ← Windows installer (opt-in -WithTTS -WithWhisper)
├── .env                     ← PROMO_APP_URL, credentials
├── scripts/
│   ├── analyze.ts           ← product name, tagline, features, hooks, colours
│   ├── capture.ts           ← Playwright UI recorder (10 key screens)
│   ├── voiceover.ts         ← Piper → say → SAPI → silent (+ emotion per scene)
│   ├── subtitles.ts         ← Whisper SRT → JSON timing
│   ├── ffmpeg-pipeline.ts   ← composite + colour grade + social exports
│   ├── render.ts            ← Remotion render runner
│   ├── social.ts            ← social format exporter
│   ├── ltx-generate.ts      ← LTX Video AI scenes (GPU optional)
│   └── promo.ts             ← master orchestrator (npm run promo)
├── remotion/
│   ├── package.json         ← Remotion sub-project (own node_modules)
│   ├── tsconfig.json
│   ├── remotion.config.ts
│   └── src/
│       ├── index.ts         ← Remotion entry point (registerRoot here)
│       ├── Root.tsx         ← pure component, all 5 Compositions
│       ├── compositions/    ← 5 video templates
│       ├── scenes/          ← Hero, UICapture, KineticText, CTA, Transition, FeatureShowcase
│       └── motion/          ← cinematicSpring, particles, cursorHighlight, focusZoom, gradients
├── templates/               ← scene-by-scene breakdowns per template
├── prompts/                 ← hooks (all 7 structures), ad scripts, CTA copy, scene ideas
└── output/
    ├── renders/             ← master videos
    └── social/              ← platform variants
```

---

## Environment variables

`promo/.env` — generated automatically when you run `/saas-promo-studio`:

```env
# ── Required ──────────────────────────────────────────────
PROMO_APP_URL=http://localhost:8000
PROMO_EMAIL=admin@yourorg.test
PROMO_PASSWORD=yourpassword

# ── TTS / Voice (uncomment + add key to unlock) ───────────
# ElevenLabs: free 10k chars/month → https://elevenlabs.io
# ELEVENLABS_API_KEY=
# ELEVENLABS_VOICE_ID=EXAVITQu4vr4xnSDxMaL   # Sarah (free voice)

# OpenAI TTS + GPT analysis → https://platform.openai.com
# OPENAI_API_KEY=

# Google Cloud TTS: free 4M chars/month
# GOOGLE_TTS_API_KEY=

# ── AI Video Generation ───────────────────────────────────
# Runway ML Gen-3: free 125 credits/month → https://runwayml.com
# RUNWAY_API_KEY=

# FAL.ai: freemium → https://fal.ai
# FAL_API_KEY=

# Stability AI: free 25 credits → https://platform.stability.ai
# STABILITY_API_KEY=

# ── Stock Assets (free) ───────────────────────────────────
# Pexels: unlimited free → https://www.pexels.com/api
# PEXELS_API_KEY=

# ── Background Music ──────────────────────────────────────
# Mubert: freemium → https://mubert.com
# MUBERT_API_KEY=

# ── Brand Auto-Detect (free 10k req/month) ────────────────
# Brandfetch → https://developers.brandfetch.com
# BRANDFETCH_API_KEY=
```

If `PROMO_APP_URL` is unreachable, capture is skipped gracefully — placeholder manifest is created and videos render with mock UI instead of crashing.

---

## Voiceover fallback chain

The skill automatically selects the best available TTS engine **and controls emotion per scene**:

| Priority | Engine | Quality | Requires |
|----------|--------|---------|----------|
| 1 | Piper TTS | Neural (best) | `pip install piper-tts` + model download |
| 2 | macOS `say` | System voice | macOS only |
| 3 | Windows SAPI | System voice | Windows built-in — zero install |
| 4 | Silent placeholder | No audio | Always available |

**Emotion control** — each scene gets a delivery style:
| Emotion | Piper speed | SAPI rate | Use for |
|---------|-------------|-----------|---------|
| `calm` | 1.0× | 0 | Taglines, demos |
| `energetic` | 1.18× | +3 | Feature lists, reveals |
| `urgent` | 1.28× | +5 | Hook lines |
| `warm` | 0.95× | -1 | Onboarding, explainers |
| `whisper` | 0.87× | -3 | Dramatic reveals |
| `confident` | 1.09× | +2 | CTAs, stats |

On Windows without Piper installed, SAPI kicks in automatically with emotion rate control — you get expressive voiceovers with zero setup.

---

## Customisation

### Change the voice model

In `scripts/voiceover.ts`, update `MODEL_PATHS` to use a different Piper voice:

```typescript
const MODEL_PATHS = {
  win32: path.join(process.env.LOCALAPPDATA!, 'piper-voices', 'en_US-ryan-high.onnx'),
  // Options: en_US-lessac-high, en_US-amy-medium, en_US-ryan-high, en_GB-alan-medium
};
```

Browse all voices: https://huggingface.co/rhasspy/piper-voices

### Add new Playwright flows

In `scripts/capture.ts`, add to the `FLOWS` array:

```typescript
{
  name: '11-my-feature',
  url: '/company/my-feature',
  waitFor: '.my-selector',
  description: 'What this screen shows',
  highlight: '.key-element',   // adds purple outline
}
```

### Change colour palette

In `remotion/src/motion/cinematicSpring.ts`, update `colors`:

```typescript
export const colors = {
  bg:     '#0a0a0f',
  accent: '#YOUR_BRAND_COLOR',
  blue:   '#YOUR_SECONDARY',
  green:  '#YOUR_SUCCESS_COLOR',
  // ...
};
```

Note: when `/saas-promo-studio` runs, it auto-scans your Tailwind config and CSS variables to pre-fill these colours with your real brand palette.

### FFmpeg colour grading

In `scripts/ffmpeg-pipeline.ts`:

```typescript
const cinematicFilter = [
  'eq=brightness=0.02:contrast=1.05:saturation=1.1',
  'curves=preset=stronger_contrast',
  'colorbalance=rs=-0.05:gs=0:bs=0.05',  // cool tint — remove for neutral
].join(',');
```

### Open Remotion visual editor

```bash
cd promo
npm run remotion:studio
# Opens at http://localhost:3000
# Scrub timeline, edit props live, see changes instantly
```

---

## LTX Video (AI-generated scenes)

If you have an NVIDIA GPU with CUDA:

```bash
pip install ltx-video
cd promo
npx ts-node scripts/ltx-generate.ts "Your scene description prompt" scene-name
```

Generated clips are saved to `remotion/public/captures/` and can be used as `screenshotPath` in `UICapture` compositions.

Requirements: Python 3.10+, CUDA 12.1+, ~20GB VRAM (24GB recommended).

---

## Troubleshooting

**FFmpeg not found on Windows**

winget installs FFmpeg to a non-PATH location. The scripts auto-detect it. If it still fails:
```powershell
# Add manually to PATH after winget install
$ffmpegDir = (Get-ChildItem "$env:LOCALAPPDATA\Microsoft\WinGet\Packages\Gyan.FFmpeg*" -Recurse -Filter "ffmpeg.exe" | Select-Object -First 1).DirectoryName
[System.Environment]::SetEnvironmentVariable("PATH", "$env:PATH;$ffmpegDir", "User")
```

**Remotion renders blank / wrong composition**

Check that `remotion/src/index.ts` exists with exactly:
```typescript
import { registerRoot } from 'remotion';
import { RemotionRoot } from './Root';
registerRoot(RemotionRoot);
```
Remotion auto-discovery only scans `src/index.ts` or `src/index.tsx`. `Root.tsx` alone is not discovered.

**Playwright capture skipped ("App not reachable")**

Your app needs to be running before `npm run promo`. Start your dev server in a separate terminal, then run the promo command. The capture step is skipped gracefully — mock UI is used if the app is offline.

**`Cannot find module 'minimist'`**

```bash
cd promo && npm install
```

**Piper TTS fails on Windows**

Windows SAPI fallback is used automatically (with emotion control). For Piper:
```powershell
.\install.ps1 -WithTTS
```

**Environment check shows red items**

Only Node.js 18+ is required. All other red items use fallbacks — your video will still render. Install the optional tools for better quality.

---

## How it works internally

```
/saas-promo-studio
       │
       ▼
  Phase 0: Environment + API Key Check
  (Node, FFmpeg, Python, Playwright + all API keys → status table)
       │
       ▼
  Phase 1: Analyse repo + Brand Auto-Scan
  (Brandfetch API → Tailwind → CSS vars → logo detection)
       │
       ▼
  Phase 1b: Choose Narrative Structure
  (Rage Hook / Transformation / Social Proof Storm / etc.)
       │
       ▼
  Phase 2–8: Write all files
  (scripts/, remotion/, templates/, prompts/)
       │
       ▼
npm run promo
  ├── [1/7] capture.ts   → Playwright screenshots → remotion/public/captures/
  │                         writes captures.json with relative paths for staticFile()
  ├── [2/7] stock.ts     → Pexels B-roll → remotion/public/stock/ (if PEXELS_API_KEY)
  ├── [3/7] music.ts     → Mubert/Pixabay music → remotion/public/music/bg.mp3
  ├── [4/7] voiceover.ts → ElevenLabs→OpenAI→Google→Piper→SAPI→silent (per-scene emotion)
  ├── [5/7] subtitles.ts → SRT via Whisper (or placeholder)
  ├── [6/7] render.ts    → reads captures.json → passes as props → Remotion → raw MP4
  │                         UICapture uses staticFile(screenshotPath) for real screenshots
  └── [7/7] social.ts    → FFmpeg → 4 platform variants + music mix
```

### Screenshot Pipeline (how your real UI gets into the video)

```
Playwright saves:  remotion/public/captures/01-dashboard.png
Manifest records:  { "path": "captures/01-dashboard.png" }  ← relative to public/
render.ts reads:   captures.json → merges into Remotion props
Composition uses:  captures.find(c => c.name.includes('dashboard'))?.path
UICapture shows:   <Img src={staticFile("captures/01-dashboard.png")} />
Result:            Your actual app UI appears in the video — not a mock
```

---

## Contributing

Found a bug or want to improve the skill? Open an issue or PR.

The skill is a single `SKILL.md` file — all logic lives in the instructions Claude follows. To test changes, update `SKILL.md`, restart Claude Code, and run `/saas-promo-studio` in a test project.

---

## License

MIT — use freely, modify, share.
