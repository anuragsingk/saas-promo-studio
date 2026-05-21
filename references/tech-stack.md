# Tech Stack Reference

## Core (required)
| Tool | Role | Install |
|------|------|---------|
| Remotion | React → video renderer | `npm i remotion @remotion/cli` |
| Playwright | UI recording / screenshots | `npm i playwright` |
| FFmpeg | Video compositing / encoding | OS package manager |
| Piper TTS | Local neural voiceover | `pip install piper-tts` |
| Whisper | Auto-subtitles from audio | `pip install openai-whisper` |

## Optional
| Tool | Role | Notes |
|------|------|-------|
| LTX Video | AI-generated video clips | Needs GPU |
| Ollama | Local LLM for copy/hooks | `ollama pull llama3` |
| Stable Diffusion | Background image generation | ComfyUI or Automatic1111 |
| Motion.dev / GSAP | Web animation (inside Remotion) | `npm i motion` |

## Piper TTS Models (English)
- `en_US-lessac-high` — best quality, neutral voice
- `en_US-ryan-high` — male, natural
- `en_GB-alba-medium` — British female

Download: `python -m piper --download-dir ./models en_US-lessac-high`

## FFmpeg Social Exports
```bash
# 9:16 (TikTok / Reels)
ffmpeg -i input.mp4 -vf "scale=1080:1920,boxblur=20:20,scale=1080:1920[bg];[0:v]scale=1080:-1[fg];[bg][fg]overlay=(W-w)/2:(H-h)/2" output_916.mp4

# 1:1 (Instagram)
ffmpeg -i input.mp4 -vf "scale=1080:1080,boxblur=20:20,scale=1080:1080[bg];[0:v]scale=1080:-1[fg];[bg][fg]overlay=(W-w)/2:(H-h)/2" output_11.mp4
```

## Remotion Render Command
```bash
npx remotion render remotion/src/Root.tsx LaunchVideo output/renders/launch.mp4 --codec=h264
```
