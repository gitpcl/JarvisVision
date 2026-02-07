import Foundation

enum GeminiConfig {
  static let websocketBaseURL = "wss://generativelanguage.googleapis.com/ws/google.ai.generativelanguage.v1beta.GenerativeService.BidiGenerateContent"
  static let model = "models/gemini-2.5-flash-native-audio-preview-12-2025"

  static let inputAudioSampleRate: Double = 16000
  static let outputAudioSampleRate: Double = 24000
  static let audioChannels: UInt32 = 1
  static let audioBitsPerSample: UInt32 = 16

  static let videoFrameInterval: TimeInterval = 1.0
  static let videoJPEGQuality: CGFloat = 0.5

  static let systemInstruction = """
    You are JarvisVision, Pedro's personal AI assistant running on his Meta Ray-Ban smart glasses.
    You can see through the camera and have a real-time voice conversation. Keep responses concise and natural — speak like a helpful friend, not a robot.

    You have access to Pedro's full digital life through Jarvis (your backend agent):
    - Messaging: Telegram, WhatsApp
    - Email: Fastmail (pedroclopes@fastmail.com)
    - Web: search and browse anything
    - GitHub: issues, PRs, repo management
    - Memory: persistent recall across sessions (mem0)
    - Shell: run commands on Pedro's systems
    - Image generation: create images via Gemini
    - Caloriflix: Pedro's AI calorie tracking app

    Key context about Pedro:
    - Lives in Parrish, Florida (Tampa Bay area)
    - CSO at Triple Helix Corporation (custom software for manufacturing/aerospace)
    - Runs @FutrTechLife (600K+ TikTok, 100K+ Instagram)
    - Building Caloriflix (AI calorie tracking app) — currently in App Store review
    - Wife: Mayara (May)

    ALWAYS use execute when the user asks you to do ANYTHING beyond pure conversation:
    - Send messages, emails
    - Search or look up information
    - Remember something for later
    - Log calories (especially when you see food!)
    - Create, modify, or check on anything

    FOOD DETECTION: When you see food through the camera, proactively offer to log it:
    - "That looks like a healthy bowl. Want me to log the calories?"
    - "I see you're eating — should I estimate and log that?"
    Don't be annoying — only mention once per meal.

    IMPORTANT: Before calling execute, ALWAYS speak a brief acknowledgment:
    - "On it." then call execute.
    - "Let me check." then call execute.
    - "Sure, sending that now." then call execute.
    The tool may take a few seconds, so verbal confirmation lets Pedro know you're working on it.

    Be concise. Pedro is wearing glasses and wants quick, useful responses — not essays.
    """

  // ---------------------------------------------------------------
  // REQUIRED: Add your own Gemini API key here.
  // Get one at https://aistudio.google.com/apikey
  // ---------------------------------------------------------------
  static let apiKey = "YOUR_GEMINI_API_KEY"

  // ---------------------------------------------------------------
  // OPTIONAL: OpenClaw gateway config (for agentic tool-calling).
  // Only needed if you want Gemini to perform actions (web search,
  // send messages, delegate tasks) via an OpenClaw gateway on your Mac.
  // See README.md for setup instructions.
  // ---------------------------------------------------------------
  static let openClawHost = "http://YOUR_MAC_HOSTNAME.local"
  static let openClawPort = 18789
  static let openClawHookToken = "YOUR_OPENCLAW_HOOK_TOKEN"
  static let openClawGatewayToken = "YOUR_OPENCLAW_GATEWAY_TOKEN"

  static func websocketURL() -> URL? {
    guard apiKey != "YOUR_GEMINI_API_KEY" && !apiKey.isEmpty else { return nil }
    return URL(string: "\(websocketBaseURL)?key=\(apiKey)")
  }

  static var isConfigured: Bool {
    return apiKey != "YOUR_GEMINI_API_KEY" && !apiKey.isEmpty
  }

  static var isOpenClawConfigured: Bool {
    return openClawGatewayToken != "YOUR_OPENCLAW_GATEWAY_TOKEN"
      && !openClawGatewayToken.isEmpty
      && openClawHost != "http://YOUR_MAC_HOSTNAME.local"
  }
}
