# JarvisVision

AI-powered smart glasses assistant with full agentic capabilities. Built for Meta Ray-Ban smart glasses.

## Features

- 🎤 **Real-time voice conversation** via Gemini 2.5 Flash
- 📸 **Visual understanding** through glasses camera
- 🤖 **Full agent integration** with OpenClaw/Jarvis
- 📱 **Multi-platform messaging** (Telegram, WhatsApp, iMessage)
- 📧 **Email** (Fastmail)
- 🔍 **Web search & browsing**
- 🧠 **Persistent memory** across sessions (mem0)
- 🍎 **Caloriflix integration** - log calories by looking at food
- 🌐 **Works anywhere** via Cloudflare tunnel (not just home WiFi)

## Architecture

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│  Meta Ray-Ban   │────▶│  iPhone App      │────▶│  OpenClaw       │
│  Smart Glasses  │     │  (JarvisVision)  │     │  Gateway        │
└─────────────────┘     └──────────────────┘     └─────────────────┘
                              │                         │
                              ▼                         ▼
                        ┌──────────┐            ┌─────────────────┐
                        │  Gemini  │            │  Jarvis (Claude)│
                        │  Live    │            │  + All Skills   │
                        └──────────┘            └─────────────────┘
```

## Requirements

- iPhone with iOS 17.0+
- Meta Ray-Ban smart glasses (optional - iPhone camera works for testing)
- Gemini API key ([get one here](https://aistudio.google.com/apikey))
- OpenClaw gateway running with `chatCompletions.enabled: true`

## Setup

1. Open `JarvisVision.xcodeproj` in Xcode
2. Update `GeminiConfig.swift` with your API keys:
   - `apiKey` - Your Gemini API key
   - `openClawHost` - Your OpenClaw gateway URL
   - `openClawGatewayToken` - Your gateway token
3. Set your Apple Developer team for signing
4. Build and run on your iPhone

## Remote Access (Cloudflare Tunnel)

To use JarvisVision from anywhere (not just home WiFi):

```bash
# On your Mac/server running OpenClaw
cloudflared tunnel create jarvisvision
cloudflared tunnel route dns jarvisvision gateway.yourdomain.com
cloudflared tunnel run jarvisvision
```

Then update `GeminiConfig.swift`:
```swift
static let openClawHost = "https://gateway.yourdomain.com"
static let openClawPort = 443
```

## Credits

Forked from [VisionClaw](https://github.com/sseanliu/VisionClaw) by Sean Liu.

## License

MIT
