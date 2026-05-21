---
name: saas-promo-studio
description: Autonomously builds a complete AI SaaS promo video production system inside the current repository using Remotion, Playwright, FFmpeg, Piper TTS, and LTX Video. Use when the user wants to generate cinematic launch videos, onboarding demos, TikTok ads, or startup-style promos from their existing SaaS app — triggered by phrases like "build promo studio", "set up video pipeline", "create promo video system", or invoking /saas-promo-studio.
---

# AI SaaS Promo Video Studio

You are an elite AI systems engineer, motion designer, and SaaS launch filmmaker.

Build a **complete, autonomous "AI SaaS Promo Video Studio"** inside the current repository. Generate every file from scratch — production-ready, no TODOs in critical paths.

---

## Phase 1: Repository Analysis

Read these files before writing anything:
- `package.json`, `composer.json`, `README.md`, any config files
- Route files to understand URL structure and user flows
- `.env.example` for app URL / port hints

Identify:
- Product name and tagline
- Primary colour palette (extract hex values)
- Key user flows (auth → dashboard → core features)
- "Wow moments" — features most impressive in a demo
- Emotional selling points (time saved, pain eliminated)
- Default app URL (check for `APP_URL`, `VITE_APP_URL`, or assume `http://localhost:8000`)

Write your findings to `promo/ANALYSIS.md` before generating any other files.

---

## Phase 2: Folder Structure

Create this EXACT structure:

```
promo/
├── ANALYSIS.md
├── package.json              ← root promo scripts + non-remotion deps
├── tsconfig.json             ← for scripts/ compilation
├── install.sh                ← Unix one-command installer
├── install.ps1               ← Windows one-command installer (opt-in TTS/Whisper)
├── .env                      ← PROMO_APP_URL, PROMO_EMAIL, PROMO_PASSWORD
├── scripts/
│   ├── analyze.ts            ← exports product name, tagline, features, hooks, colors
│   ├── capture.ts            ← Playwright UI recorder
│   ├── voiceover.ts          ← Piper TTS / macOS say / Windows SAPI fallback chain
│   ├── subtitles.ts          ← Whisper subtitle generator
│   ├── ffmpeg-pipeline.ts    ← FFmpeg compositor + social exports
│   ├── render.ts             ← Remotion render runner
│   ├── social.ts             ← Social format exporter (calls ffmpeg-pipeline)
│   ├── ltx-generate.ts       ← LTX Video AI scene generator (GPU optional)
│   └── promo.ts              ← Master orchestrator — what npm run promo calls
├── remotion/                 ← SEPARATE Remotion sub-project with its own package.json
│   ├── package.json          ← remotion deps only
│   ├── tsconfig.json         ← "strict": false, jsx: "react"
│   ├── remotion.config.ts    ← Config.setVideoImageFormat + Config.setOverwriteOutput
│   └── src/
│       ├── Root.tsx          ← registerRoot() entry point with all 5 Compositions
│       ├── compositions/
│       │   ├── LaunchVideo.tsx
│       │   ├── TikTokAd.tsx
│       │   ├── OnboardingDemo.tsx
│       │   ├── FeatureReveal.tsx
│       │   └── StartupPromo.tsx
│       ├── scenes/
│       │   ├── Hero.tsx
│       │   ├── FeatureShowcase.tsx
│       │   ├── UICapture.tsx
│       │   ├── KineticText.tsx
│       │   ├── CTA.tsx
│       │   └── Transition.tsx
│       └── motion/
│           ├── cinematicSpring.ts   ← exports spring configs + colors + gradients
│           ├── gradients.ts         ← animated gradient helpers (import React at TOP)
│           ├── cursorHighlight.tsx
│           ├── focusZoom.tsx
│           └── particles.tsx
├── remotion/public/
│   ├── captures/             ← Playwright screenshots + captures.json manifest
│   └── audio/                ← Piper TTS MP3s + subtitles JSON
├── templates/
│   ├── apple-launch.md
│   ├── linear-promo.md
│   ├── tiktok-ad.md
│   └── onboarding.md
├── prompts/
│   ├── hooks.md
│   ├── ad-scripts.md
│   ├── cta-copy.md
│   └── scene-ideas.md
└── output/
    ├── renders/              ← Final master MP4s
    └── social/               ← Platform-sized exports
```

**Critical**: `remotion/` is a SEPARATE Node project. It has its own `package.json` and gets `npm install` run inside it. The root `promo/package.json` handles scripts and non-Remotion dependencies.

---

## Phase 3: Root Files

### promo/package.json

```json
{
  "name": "saas-promo-studio",
  "version": "1.0.0",
  "scripts": {
    "promo":        "npx ts-node scripts/promo.ts",
    "capture":      "npx ts-node scripts/capture.ts",
    "render":       "npx ts-node scripts/render.ts",
    "social":       "npx ts-node scripts/social.ts",
    "launch-video": "npx ts-node scripts/promo.ts --template=launch",
    "tiktok":       "npx ts-node scripts/promo.ts --template=tiktok",
    "onboarding":   "npx ts-node scripts/promo.ts --template=onboarding",
    "feature":      "npx ts-node scripts/promo.ts --template=feature",
    "startup":      "npx ts-node scripts/promo.ts --template=startup",
    "voiceover":    "npx ts-node scripts/voiceover.ts",
    "subtitles":    "npx ts-node scripts/subtitles.ts",
    "remotion:studio": "cd remotion && npx remotion studio",
    "remotion:render": "cd remotion && npx remotion render",
    "analyze":      "npx ts-node scripts/analyze.ts",
    "install:all":  "node -e \"require('child_process').execSync(process.platform==='win32'?'powershell -ExecutionPolicy Bypass -File install.ps1':'bash install.sh',{stdio:'inherit'})\""
  },
  "dependencies": {
    "remotion": "^4.0.0",
    "@remotion/player": "^4.0.0",
    "@remotion/cli": "^4.0.0",
    "@playwright/test": "^1.44.0",
    "playwright": "^1.44.0",
    "fluent-ffmpeg": "^2.1.3",
    "@types/fluent-ffmpeg": "^2.1.24",
    "motion": "^11.0.0",
    "framer-motion": "^11.0.0",
    "ts-node": "^10.9.2",
    "typescript": "^5.4.0",
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "@types/react": "^18.2.0",
    "@types/react-dom": "^18.2.0",
    "minimist": "^1.2.8",
    "@types/minimist": "^1.2.5",
    "dotenv": "^16.4.5"
  },
  "devDependencies": {
    "@types/node": "^20.14.0"
  }
}
```

### promo/tsconfig.json (root — for scripts only)

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
  "include": ["scripts/**/*", "remotion/src/**/*"],
  "exclude": ["node_modules", "dist"]
}
```

### remotion/package.json (Remotion sub-project)

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

### remotion/remotion.config.ts

```typescript
import { Config } from '@remotion/cli/config';

Config.setVideoImageFormat('jpeg');
Config.setOverwriteOutput(true);
```

### promo/.env

```env
PROMO_APP_URL=http://localhost:8000
PROMO_EMAIL=admin@yourorg.test
PROMO_PASSWORD=password
```

---

## Phase 4: Install Scripts

### install.sh (Unix)

```bash
#!/usr/bin/env bash
set -e

RESET='\033[0m'; BOLD='\033[1m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'; YELLOW='\033[1;33m'
log()  { echo -e "${CYAN}[promo]${RESET} $1"; }
ok()   { echo -e "${GREEN}✓${RESET} $1"; }
warn() { echo -e "${YELLOW}⚠${RESET}  $1"; }

echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${BOLD}  SaaS Promo Studio — Installer${RESET}"
echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"

# FFmpeg
if command -v ffmpeg &>/dev/null; then
  ok "FFmpeg already installed"
else
  log "Installing FFmpeg..."
  if command -v brew &>/dev/null; then brew install ffmpeg
  elif command -v apt-get &>/dev/null; then sudo apt-get install -y ffmpeg
  elif command -v dnf &>/dev/null; then sudo dnf install -y ffmpeg
  elif command -v pacman &>/dev/null; then sudo pacman -S --noconfirm ffmpeg
  else warn "Install FFmpeg manually from https://ffmpeg.org/download.html"; fi
fi

# Piper TTS
if command -v piper &>/dev/null || python3 -c "import piper" 2>/dev/null; then
  ok "Piper TTS available"
else
  log "Installing Piper TTS..."
  pip3 install piper-tts 2>/dev/null || pip install piper-tts || warn "Piper TTS failed — macOS say / Windows SAPI fallback will be used"
fi

# Whisper
if command -v whisper &>/dev/null || python3 -c "import whisper" 2>/dev/null; then
  ok "Whisper available"
else
  log "Installing OpenAI Whisper..."
  pip3 install openai-whisper 2>/dev/null || pip install openai-whisper || warn "Whisper failed — placeholder subtitles will be used"
fi

# Node deps (root promo project)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"
log "Installing Node dependencies..."
npm install
ok "Node dependencies installed"

# Remotion sub-project
if [ ! -d "remotion/node_modules" ]; then
  log "Installing Remotion dependencies..."
  cd remotion && npm install && cd ..
  ok "Remotion dependencies installed"
fi

# Playwright browsers
log "Installing Playwright Chromium..."
npx playwright install chromium 2>/dev/null || warn "Playwright browser install failed — run: npx playwright install chromium"
ok "Playwright Chromium ready"

# Piper voice model
MODEL_DIR="$HOME/.local/share/piper-voices"
if [ ! -f "$MODEL_DIR/en_US-lessac-high.onnx" ]; then
  log "Downloading Piper voice model (en_US-lessac-high, ~65MB)..."
  mkdir -p "$MODEL_DIR"
  BASE_URL="https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_US/lessac/high"
  curl -L "$BASE_URL/en_US-lessac-high.onnx"      -o "$MODEL_DIR/en_US-lessac-high.onnx"      2>/dev/null || warn "Voice model download failed — macOS say fallback will be used"
  curl -L "$BASE_URL/en_US-lessac-high.onnx.json" -o "$MODEL_DIR/en_US-lessac-high.onnx.json" 2>/dev/null || true
fi

echo ""
echo -e "${BOLD}${GREEN}Setup complete!${RESET}"
echo ""
echo -e "  ${BOLD}npm run promo${RESET}         → Full pipeline"
echo -e "  ${BOLD}npm run launch-video${RESET}  → 60s Apple-style launch video"
echo -e "  ${BOLD}npm run tiktok${RESET}         → 15s TikTok ad"
```

### install.ps1 (Windows) — Key design decisions:
- Piper TTS and Whisper are **opt-in** via flags (`-WithTTS`, `-WithWhisper`) — they are heavy deps
- Default install (no flags): FFmpeg via winget, Node deps, Remotion setup, Playwright Chromium
- Windows SAPI TTS is the automatic voiceover fallback (built into Windows — no install needed)
- FFmpeg installs via `winget install --id Gyan.FFmpeg`
- Remotion `package.json` written with `[System.IO.File]::WriteAllText` using no-BOM UTF-8 (avoids PS 5.1 BOM issues)
- Must `Set-Location $scriptDir` at start since `$PSScriptRoot` may differ

Generate the full PowerShell install.ps1 with these patterns:

```powershell
#Requires -Version 5.1
param([switch]$WithTTS, [switch]$WithWhisper)
$ErrorActionPreference = 'Stop'

# ... helper functions Write-Step, Write-Ok, Write-Warn ...

# FFmpeg via winget (with choco fallback)
# Node deps: npm install in script dir
# Remotion: check if remotion/package.json exists, if not write it + npm install
#   CRITICAL: Write package.json using [System.IO.File]::WriteAllText with no-BOM UTF-8:
#   $utf8NoBom = [System.Text.UTF8Encoding]::new($false)
#   [System.IO.File]::WriteAllText($pkgPath, ($jsonLines -join "`r`n"), $utf8NoBom)
# Playwright: npx playwright install chromium
# Piper TTS (only if -WithTTS): pip install piper-tts + download model to $env:LOCALAPPDATA\piper-voices
# Whisper (only if -WithWhisper): pip install openai-whisper
```

---

## Phase 5: Scripts

### scripts/analyze.ts

Export functions (do NOT write to files — promo.ts calls these functions):

```typescript
import * as fs from 'fs';
import * as path from 'path';

const ANALYSIS_PATH = path.join(__dirname, '..', 'ANALYSIS.md');

export function readAnalysis(): string {
  return fs.existsSync(ANALYSIS_PATH) ? fs.readFileSync(ANALYSIS_PATH, 'utf8') : '';
}
export function getProductName(): string { return 'YourProduct'; }      // set from analysis
export function getTagline(): string { return 'Your product tagline'; }  // set from analysis
export function getFeatures(): string[] { return [/* top 6-10 features */]; }
export function getHooks(): string[] { return [/* 5 marketing hooks */]; }
export function getColors() {
  return { bg: '#0a0a0f', navy: '#12102a', accent: '#6B41F8', blue: '#4361EE',
           green: '#00C896', text: '#f8fafc', muted: '#64748b', glow: '#a855f7' };
}
// Customise all values based on the actual product from ANALYSIS.md
```

### scripts/capture.ts

Key implementation rules:
- `APP_URL = process.env.PROMO_APP_URL || 'http://localhost:8000'` (auto-detect from env)
- Load `.env` via `dotenv.config({ path: path.join(__dirname, '..', '.env') })`
- **App reachability check**: if `page.goto(APP_URL)` fails → call `writePlaceholderManifest()` and return (do NOT throw)
- Login: try to fill email/password fields — wrap in try/catch, continue if login form not found
- Each step has a **1500ms breathing room** between requests (PHP artisan serve is single-threaded)
- `waitFor` selector uses `.catch(() => {})` — never hard-fail on missing elements
- `highlight`: adds `outline: 3px solid #6B41F8` via `page.evaluate()`
- After all steps: write `captures.json` manifest with relative paths using forward slashes
- `writePlaceholderManifest()`: creates manifest with expected file paths even if screenshots failed

FLOWS array structure:
```typescript
interface CaptureStep {
  name: string;       // e.g. '01-login'
  url: string;        // e.g. '/login'
  waitFor?: string;   // CSS selector to wait for
  actions?: Array<{ type: 'click'|'hover'|'scroll'|'wait'; selector?: string; ms?: number }>;
  description: string;
  highlight?: string; // CSS selector to outline in purple
}
```

Generate FLOWS based on the app's actual URL structure from ANALYSIS.md.

### scripts/voiceover.ts

Three-tier fallback chain (try in order):
1. **Piper TTS** (neural): `echo "text" | piper --model path.onnx --output_file out.wav`
   - Model paths: Linux/Mac: `~/.local/share/piper-voices/en_US-lessac-high.onnx`
   - Windows: `%LOCALAPPDATA%\piper-voices\en_US-lessac-high.onnx`
2. **macOS `say`** (if `process.platform === 'darwin'`): `say -o out.aiff "text"`
3. **Windows SAPI** (if `process.platform === 'win32'`): PowerShell `System.Speech.Synthesis.SpeechSynthesizer`
4. **Silent placeholder**: `ffmpeg -f lavfi -i anullsrc -t 30 out.mp3`

Always convert WAV/AIFF → MP3 using FFmpeg after TTS renders.
Use `ffprobe` to get audio duration for Remotion timing sync.

### scripts/subtitles.ts

- Try `whisper` CLI first, then `python -m whisper`
- If neither available: write placeholder subtitle JSON with hardcoded timing
- Parse SRT into `Array<{ index, startMs, endMs, text }>` JSON
- Save both `.srt` and `.json` to `remotion/public/audio/`

### scripts/ffmpeg-pipeline.ts

**Critical**: `findFfmpeg()` must search winget portable install paths on Windows:

```typescript
function findFfmpeg(): string {
  try { cp.execSync('ffmpeg -version', { stdio: 'pipe' }); return 'ffmpeg'; } catch {}
  // Search winget portable install
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

Social variants (use padding with `color=0x0a0a0f` for non-16:9):
- YouTube/LinkedIn: 1920×1080 (direct scale, no padding needed)
- TikTok/Reels: 1080×1920 (pad with dark bg)
- Instagram: 1080×1080 (pad with dark bg)
- Twitter/X: 1280×720

Color grading filter:
```
eq=brightness=0.02:contrast=1.05:saturation=1.1,curves=preset=stronger_contrast,colorbalance=rs=-0.05:gs=0:bs=0.05
```

SRT subtitle burn-in style: `FontName=Inter,FontSize=28,PrimaryColour=&HFFFFFF&,OutlineColour=&H40000000&,Outline=1.5,Shadow=1`

### scripts/render.ts

Key rules:
- `findFfmpeg()` — same winget search as ffmpeg-pipeline.ts
- Remotion binary: check `remotion/node_modules/.bin/remotion` first, then `node_modules/.bin/remotion`
- Entry point: `remotion/src/index.ts` (NOT Root.tsx — Remotion auto-discovery requires this)
- **Write props to temp JSON file** to avoid Windows shell quote-stripping:
  ```typescript
  const propsFile = path.join(os.tmpdir(), `remotion-props-${Date.now()}.json`);
  fs.writeFileSync(propsFile, JSON.stringify(props || {}));
  // Pass as: --props="${propsFile}"
  ```
- Run with `cwd: REMOTION_DIR` (the remotion subfolder)
- If render fails: create placeholder video with FFmpeg (`-f lavfi -i color=c=0x0a0a0f`)

### scripts/promo.ts (Master Orchestrator)

Parse args with `minimist`:
```typescript
import minimist = require('minimist');
const argv = minimist(process.argv.slice(2));
const config = {
  template:      argv.template || argv.t || 'launch',
  skipCapture:   Boolean(argv['skip-capture'] || argv['no-capture']),
  skipVoiceover: Boolean(argv['skip-voice']   || argv['no-voice']),
  skipRender:    Boolean(argv['skip-render']  || argv['no-render']),
  skipComposite: Boolean(argv['skip-composite']),
  skipSocial:    Boolean(argv['skip-social']  || argv['no-social']),
  outputName:    argv.output || argv.o || `promo-${argv.template || 'launch'}`,
};
```

Pipeline steps (print numbered progress: [1/6], [2/6], etc.):
1. Capture UI (unless `skipCapture`)
2. Generate voiceover using script from `VOICEOVER_SCRIPTS[template]`
3. Generate subtitles from audio
4. Render Remotion composition
5. Composite video + audio + subtitles with FFmpeg
6. Export social variants

Print ASCII banner at start. Print output paths at end. Print elapsed time.

---

## Phase 6: Remotion Components

### CRITICAL Rules for All Remotion Components

1. **NEVER call `useCurrentFrame()` inside `.map()` or any callback** — it violates React hooks rules. Capture `frame` at the component top level and use it inside map:
   ```typescript
   const frame = useCurrentFrame(); // at top of component
   // Inside .map():
   const progress = spring({ frame: Math.max(0, frame - delay), fps, ... }); // use captured frame
   ```

2. **All imports at TOP of file** — `import * as React from 'react'` must be first line in TSX files.

3. **`gradients.ts`**: Import React at the TOP, not the bottom.

### remotion/src/motion/cinematicSpring.ts

Export three spring configs + shared color palette + gradients:

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

Customise `colors.accent` and `gradients` to match the product's brand palette from ANALYSIS.md.

### remotion/src/motion/gradients.ts

```typescript
import * as React from 'react';  // ← MUST be at top

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

### remotion/src/scenes/KineticText.tsx

Supports modes: `'fade' | 'slide-up' | 'scale-in' | 'scramble'`

- Word-by-word animation (default) or char-by-char (`byChar`)
- `gradient` prop: applies `linear-gradient(135deg, #6B41F8, #4361EE)` via `-webkit-background-clip: text`
- `delay` prop: frame offset before animation starts
- Each word gets staggered spring using `frame` captured at component top (no hook calls inside map)

### remotion/src/scenes/UICapture.tsx

- Shows browser chrome bar (traffic light dots + URL bar) when `showBrowser={true}`
- If `screenshotPath` provided: render `<Img src={screenshotPath} />`
- If no screenshot: render a dark mock UI (header bar + 4 metric cards + table placeholder)
- Slides in from right with spring animation
- Shows `<CursorHighlight>` positioned inside the screenshot area
- Shows floating pill label at bottom when `label` prop provided

### remotion/src/index.ts  ← ENTRY POINT (Remotion auto-discovers this)

```typescript
import { registerRoot } from 'remotion';
import { RemotionRoot } from './Root';

registerRoot(RemotionRoot);
```

**Why this file exists**: Remotion's auto-discovery only looks for `src/index.ts` or `src/index.tsx`. It will NOT find `Root.tsx` on its own. This thin entry file is the bridge. `Root.tsx` stays a pure component — `registerRoot` lives ONLY here.

### remotion/src/Root.tsx  ← PURE COMPONENT (no registerRoot here)

```typescript
import * as React from 'react';
import { Composition } from 'remotion';   // ← NO registerRoot import
import { LaunchVideo } from './compositions/LaunchVideo';
import { TikTokAd } from './compositions/TikTokAd';
import { OnboardingDemo } from './compositions/OnboardingDemo';
import { FeatureReveal } from './compositions/FeatureReveal';
import { StartupPromo } from './compositions/StartupPromo';

export const RemotionRoot: React.FC = () => (
  <>
    <Composition id="LaunchVideo"    component={LaunchVideo}    durationInFrames={1800} fps={30} width={1920} height={1080} defaultProps={{}} />
    <Composition id="TikTokAd"       component={TikTokAd}       durationInFrames={450}  fps={30} width={1080} height={1920} defaultProps={{}} />
    <Composition id="OnboardingDemo" component={OnboardingDemo} durationInFrames={3600} fps={30} width={1920} height={1080} defaultProps={{}} />
    <Composition id="FeatureReveal"  component={FeatureReveal}  durationInFrames={720}  fps={30} width={1920} height={1080} defaultProps={{}} />
    <Composition id="StartupPromo"   component={StartupPromo}   durationInFrames={1350} fps={30} width={1920} height={1080} defaultProps={{}} />
  </>
);
// DO NOT call registerRoot here — it lives in index.ts only
```

### Composition Timing (30fps)

| Composition | Duration | Scenes |
|-------------|----------|--------|
| LaunchVideo | 1800fr (60s) | 0–90: logo, 90–210: tagline, 210–450: dashboard, 450–750: features, 750–1500: callouts, 1500–1800: CTA |
| TikTokAd | 450fr (15s) | 0–60: hook, 60–150: problem, 150–360: UI demo, 360–450: CTA |
| OnboardingDemo | 3600fr (2min) | 8 steps × 360fr + 720fr CTA |
| FeatureReveal | 720fr (24s) | 4 features × 180fr |
| StartupPromo | 1350fr (45s) | 0–150: punch, 150–360: numbers, 360–750: split-screen, 750–1050: product, 1050–1350: CTA |

### StartupPromo: CountUp component

```typescript
const CountUp: React.FC<{ target: number; label: string; suffix?: string; delay?: number }> = ({ target, label, suffix = '', delay = 0 }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const progress = spring({ frame: Math.max(0, frame - delay), fps, config: { mass: 1, damping: 30, stiffness: 100 }, from: 0, to: 1 });
  const value = Math.round(target * progress);
  return (
    <div style={{ textAlign: 'center' }}>
      <div style={{ fontSize: 72, fontWeight: 900, background: 'linear-gradient(135deg, #6B41F8, #4361EE)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent', backgroundClip: 'text', fontFamily: 'Inter, sans-serif' }}>
        {value}{suffix}
      </div>
      <div style={{ color: 'rgba(248,250,252,0.5)', fontSize: 16, marginTop: 4 }}>{label}</div>
    </div>
  );
};
```

### Particles component

Use deterministic seeded particles (NOT `Math.random()` — it changes every render):

```typescript
const SEED_PARTICLES = Array.from({ length: 80 }, (_, i) => ({
  id: i,
  x:       (i * 137.508 + 23) % 100,
  y:       (i * 73.1 + 11) % 100,
  size:    1 + (i % 3),
  speed:   0.15 + (i % 5) * 0.08,
  opacity: 0.1 + (i % 4) * 0.07,
  drift:   (i % 7 - 3) * 0.03,
}));
```

---

## Phase 7: Marketing Content Files

### prompts/hooks.md — 20 hook templates
Pain, curiosity, social proof, and transformation hooks — customised for the actual product from ANALYSIS.md.

### prompts/ad-scripts.md — Complete voiceover scripts for all 5 templates
Lengths: 15s, 30s, 60s, 2min — natural spoken language, approx 150 words/minute.

### prompts/cta-copy.md — CTA variants
Urgency, social-proof, and benefit-led variants. At least 15 variations.

### templates/*.md — Scene-by-scene breakdowns
Each template: timing markers, voiceover cue points, motion direction notes.

---

## Phase 8: README

Generate `promo/README.md` with:
- 3-command quick start
- All npm run commands table with descriptions
- Skip flags: `--skip-capture`, `--skip-voice`, `--skip-render`, `--no-social`
- How to add new Playwright flows to capture.ts
- How to swap voice models
- FFmpeg color grading customisation
- Output format reference table
- LTX Video optional section
- Environment variables reference

---

## Implementation Rules

1. **`npx ts-node`** — always prefix with `npx`, not bare `ts-node`
2. **Hooks at top level** — never call `useCurrentFrame()`, `useVideoConfig()`, `spring()`, etc. inside `.map()` or nested functions. Capture at component top.
3. **React imports first** — `import * as React from 'react'` must be the first line of every TSX file
4. **Cross-platform FFmpeg** — use `findFfmpeg()` with winget path search, never assume `ffmpeg` is on PATH on Windows
5. **App-not-running is graceful** — capture.ts must fall back to placeholder manifest, never throw on unreachable app
6. **Windows SAPI is the free TTS** — voiceover.ts must auto-detect Windows and use SAPI without requiring Piper
7. **Remotion runs from its own directory** — `cwd: REMOTION_DIR` in all execSync calls that invoke remotion CLI
8. **Props via temp file** — write Remotion props to tmpdir JSON file, avoid Windows shell quote issues
9. **No BOM on Windows** — use `[System.IO.File]::WriteAllText` with `UTF8Encoding::new($false)` in PS1
10. **Deterministic particles** — precompute seed array, never use `Math.random()` inside render functions
11. **Remotion entry = `src/index.ts`** — Remotion auto-discovery only finds `src/index.ts` or `src/index.tsx`. Always create this thin file. `Root.tsx` is a pure component. `registerRoot` lives ONLY in `index.ts`. The `render.ts` entry point arg must point to `src/index.ts`, not `Root.tsx`.

---

## Completion Checklist

Before reporting done, verify every item:

- [ ] `promo/ANALYSIS.md` — product analysis written with real data from the repo
- [ ] `promo/package.json` — valid JSON with all deps including `minimist`, `dotenv`, `@types/fluent-ffmpeg`
- [ ] `promo/tsconfig.json` — root tsconfig for scripts compilation
- [ ] `promo/install.sh` — idempotent Unix installer
- [ ] `promo/install.ps1` — Windows installer with `-WithTTS` / `-WithWhisper` opt-in flags
- [ ] `promo/.env` — env template with correct default APP_URL from analysis
- [ ] `promo/scripts/analyze.ts` — exports `getProductName`, `getTagline`, `getFeatures`, `getHooks`, `getColors`
- [ ] `promo/scripts/capture.ts` — has app reachability check + placeholder manifest fallback
- [ ] `promo/scripts/voiceover.ts` — Piper → say → SAPI → silent fallback chain
- [ ] `promo/scripts/subtitles.ts` — Whisper with placeholder fallback
- [ ] `promo/scripts/ffmpeg-pipeline.ts` — `findFfmpeg()` with winget path search
- [ ] `promo/scripts/render.ts` — `findFfmpeg()` + temp props file + `cwd: REMOTION_DIR`
- [ ] `promo/scripts/promo.ts` — `minimist` args + 6-step pipeline + ASCII banner
- [ ] `promo/scripts/social.ts` — finds latest master video, calls `exportSocialVariants`
- [ ] `promo/scripts/ltx-generate.ts` — GPU/LTX detection + Python script generation
- [ ] `remotion/package.json` — Remotion sub-project deps
- [ ] `remotion/tsconfig.json` — `"strict": false`, `"jsx": "react"`
- [ ] `remotion/remotion.config.ts` — `setVideoImageFormat` + `setOverwriteOutput`
- [ ] `remotion/src/index.ts` — thin entry file: `import { registerRoot } from 'remotion'; import { RemotionRoot } from './Root'; registerRoot(RemotionRoot);`
- [ ] `remotion/src/Root.tsx` — pure component exporting `RemotionRoot` with all 5 Compositions — NO `registerRoot` call
- [ ] `remotion/src/motion/cinematicSpring.ts` — 3 spring configs + colors + gradients
- [ ] `remotion/src/motion/gradients.ts` — React import at TOP
- [ ] `remotion/src/motion/cursorHighlight.tsx` — cursor dot + glow ring + click ripple
- [ ] `remotion/src/motion/focusZoom.tsx` — spring scale + vignette overlay
- [ ] `remotion/src/motion/particles.tsx` — deterministic seed array + ParticleBurst component
- [ ] `remotion/src/scenes/KineticText.tsx` — fade/slide-up/scale-in/scramble modes, NO hooks in map
- [ ] `remotion/src/scenes/Hero.tsx` — logo + badge + KineticText subtitle
- [ ] `remotion/src/scenes/FeatureShowcase.tsx` — 3-column grid, staggered cards, NO hooks in map
- [ ] `remotion/src/scenes/UICapture.tsx` — browser chrome + screenshot/placeholder + cursor + label
- [ ] `remotion/src/scenes/CTA.tsx` — headline + subtext + glowing button + particle burst
- [ ] `remotion/src/scenes/Transition.tsx` — wipe/cross-dissolve/scale-punch modes
- [ ] `remotion/src/compositions/LaunchVideo.tsx` — 6 scenes via `<Sequence>`
- [ ] `remotion/src/compositions/TikTokAd.tsx` — 4 scenes, 9:16 aware
- [ ] `remotion/src/compositions/OnboardingDemo.tsx` — 8 steps + CTA, NO hooks in map
- [ ] `remotion/src/compositions/FeatureReveal.tsx` — 4 features × 6s, NO hooks in map
- [ ] `remotion/src/compositions/StartupPromo.tsx` — CountUp + split-screen + CTA
- [ ] `promo/prompts/hooks.md` — 20 product-specific hooks
- [ ] `promo/prompts/ad-scripts.md` — scripts for all 5 templates
- [ ] `promo/prompts/cta-copy.md` — 15+ CTA variants
- [ ] `promo/templates/*.md` — 4 template breakdowns
- [ ] `promo/README.md` — quick start + all commands + customisation guide
- [ ] `remotion/public/captures/` directory exists
- [ ] `remotion/public/audio/` directory exists
- [ ] `promo/output/renders/` directory exists
- [ ] `promo/output/social/` directory exists

After all files are created, print:

```
✓ SaaS Promo Studio built in promo/

Next steps:
  1. Update promo/.env with your app URL and credentials
  2. Start your app (e.g. php artisan serve)
  3. cd promo && node -e "require('child_process').execSync('powershell -ExecutionPolicy Bypass -File install.ps1',{stdio:'inherit'})"
     (or: bash install.sh on Mac/Linux)
  4. npm run promo

Output will be saved to:
  promo/output/renders/   ← master video
  promo/output/social/    ← TikTok, YouTube, Instagram, Twitter variants

To preview compositions visually:
  npm run remotion:studio
```
