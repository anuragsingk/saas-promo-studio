# saas-promo-studio

[![Watch Demo](https://img.shields.io/badge/▶%20Watch-Demo%20Video-6B41F8?style=for-the-badge)](https://github.com/anuragsingk/saas-promo-studio/blob/main/LaunchVideo.mp4)

A Claude Code skill that autonomously builds a **complete AI SaaS promo video production system** inside any existing web application repository.

One command. Full pipeline. Cinematic output.

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

1. **Analyse your app** — reads your codebase, identifies features, user flows, selling points, and brand colours
2. **Build the entire video system** — generates every file from scratch inside a `promo/` folder
3. **Record your UI** — Playwright screenshots and videos of your actual running app
4. **Generate voiceovers** — Piper TTS (neural), macOS `say`, or Windows SAPI fallback
5. **Auto-subtitle** — Whisper transcription → SRT → burned into video
6. **Render cinematic video** — Remotion React compositions with spring animations
7. **Export all social formats** — YouTube, TikTok, Instagram, Twitter via FFmpeg

**Output**: master MP4 + 4 platform-sized social variants, ready to post.

---

## Tech stack

| Tool | Role | License |
|------|------|---------|
| [Remotion](https://remotion.dev) | React → video renderer | Free (open source) |
| [Playwright](https://playwright.dev) | UI capture / browser automation | Apache 2.0 |
| [FFmpeg](https://ffmpeg.org) | Video compositing + social exports | LGPL |
| [Piper TTS](https://github.com/rhasspy/piper) | Neural offline voiceover | MIT |
| [Whisper](https://github.com/openai/whisper) | Auto-subtitles from audio | MIT |
| [LTX Video](https://github.com/Lightricks/LTX-Video) | AI-generated video clips (GPU, optional) | Apache 2.0 |

**No API keys. No subscriptions. Runs fully offline.**

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

Claude will analyse your repo and generate the entire `promo/` system.

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
| `npm run promo` | Full pipeline — capture → voice → subtitles → render → composite → social |
| `npm run launch-video` | 60s Apple-style launch video |
| `npm run tiktok` | 15s TikTok / Instagram Reels ad (9:16) |
| `npm run onboarding` | 2-minute product walkthrough (8 steps) |
| `npm run feature` | Feature reveal — 4 features × 6s |
| `npm run startup` | 45s Stripe/Arc-style startup promo |
| `npm run capture` | Playwright UI capture only |
| `npm run voiceover` | Generate voiceovers only |
| `npm run subtitles` | Generate subtitles from audio |
| `npm run render` | Remotion render only |
| `npm run social` | Export social format variants only |
| `npm run remotion:studio` | Open Remotion visual editor in browser |
| `npm run analyze` | Re-run product analysis |

### Template flag
```bash
npm run promo -- --template=tiktok
npm run promo -- --template=onboarding --output=my-walkthrough
```

### Skip flags (for faster re-runs)
```bash
npm run promo -- --skip-capture    # reuse existing screenshots
npm run promo -- --skip-voice      # reuse existing audio
npm run promo -- --skip-render     # skip Remotion render
npm run promo -- --no-social       # skip social format exports
```

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
├── ANALYSIS.md              ← auto-generated product analysis
├── package.json
├── tsconfig.json
├── install.sh               ← Mac/Linux one-command installer
├── install.ps1              ← Windows installer (opt-in -WithTTS -WithWhisper)
├── .env                     ← PROMO_APP_URL, credentials
├── scripts/
│   ├── analyze.ts           ← product name, tagline, features, hooks, colours
│   ├── capture.ts           ← Playwright UI recorder (10 key screens)
│   ├── voiceover.ts         ← Piper → say → SAPI → silent fallback
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
├── prompts/                 ← hooks, ad scripts, CTA copy, scene ideas
└── output/
    ├── renders/             ← master videos
    └── social/              ← platform variants
```

---

## Environment variables

Create `promo/.env`:

```env
# Required — URL where your app is running during Playwright capture
PROMO_APP_URL=http://localhost:8000

# Optional — login credentials for Playwright to authenticate
PROMO_EMAIL=admin@yourorg.test
PROMO_PASSWORD=yourpassword
```

If `PROMO_APP_URL` is unreachable when you run `npm run promo`, capture is skipped gracefully — the system creates a placeholder manifest and renders with mock UI instead of crashing.

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

## Voiceover fallback chain

The skill automatically selects the best available TTS engine:

| Priority | Engine | Quality | Requires |
|----------|--------|---------|----------|
| 1 | Piper TTS | Neural (best) | `pip install piper-tts` + model download |
| 2 | macOS `say` | System voice | macOS only |
| 3 | Windows SAPI | System voice | Windows built-in — zero install |
| 4 | Silent placeholder | No audio | Always available |

On Windows without Piper installed, SAPI kicks in automatically — you get voiceovers with zero setup.

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

Windows SAPI fallback is used automatically. For Piper:
```powershell
.\install.ps1 -WithTTS
```

---

## How it works internally

```
/saas-promo-studio
       │
       ▼
  Phase 1: Analyse repo
  (reads package.json, routes, README)
       │
       ▼
  Phase 2: Write all files
  (scripts/, remotion/, templates/, prompts/)
       │
       ▼
npm run promo
  ├── [1/6] capture.ts → Playwright screenshots
  ├── [2/6] voiceover.ts → MP3 via Piper/SAPI/say
  ├── [3/6] subtitles.ts → SRT via Whisper
  ├── [4/6] render.ts → Remotion → raw MP4
  ├── [5/6] ffmpeg-pipeline.ts → master MP4
  └── [6/6] social.ts → 4 platform variants
```

---

## Contributing

Found a bug or want to improve the skill? Open an issue or PR.

The skill is a single `SKILL.md` file — all logic lives in the instructions Claude follows. To test changes, update `SKILL.md`, restart Claude Code, and run `/saas-promo-studio` in a test project.

---

## License

MIT — use freely, modify, share.


