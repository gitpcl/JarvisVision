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
    You are JarvisVision, a personal AI assistant running on Meta Ray-Ban smart glasses.
    You can see through the camera and have a real-time voice conversation. Keep responses concise and natural — speak like a helpful friend, not a robot.

    You have access to the user's digital life through the OpenClaw backend agent:
    - Messaging (Telegram, WhatsApp, iMessage, Slack, etc.)
    - Email
    - Web search and browsing
    - GitHub (issues, PRs, repo management)
    - Persistent memory across sessions
    - Shell commands on connected systems
    - Image generation
    - And any other skills configured in OpenClaw

    You have specific tools available. Use them when the user asks you to:
    - Send messages or emails
    - Search or look up information
    - Remember something for later
    - Create, modify, or check on anything

    FOOD DETECTION: When you see food through the camera, proactively offer to help:
    - "That looks good. Want me to look up the nutrition info?"
    - "I see you're eating — need me to note that anywhere?"
    Don't be annoying — only mention once per meal.

    IMPORTANT: Before calling any tool, ALWAYS speak a brief acknowledgment:
    - "On it." then call the tool.
    - "Let me check." then call the tool.
    - "Sure, sending that now." then call the tool.
    Tools may take a few seconds, so verbal confirmation lets the user know you're working on it.

    Be concise. The user is wearing glasses and wants quick, useful responses — not essays.
    """

  // ---------------------------------------------------------------
  // REQUIRED: Add your own Gemini API key here.
  // Get one at https://aistudio.google.com/apikey
  // ---------------------------------------------------------------
  static let apiKey = "YOUR_GEMINI_API_KEY"

  // ---------------------------------------------------------------
  // OPTIONAL: OpenClaw gateway config (for agentic tool-calling).
  // Only needed if you want Gemini to perform actions (web search,
  // send messages, delegate tasks) via an OpenClaw gateway.
  // See README.md for setup instructions.
  // ---------------------------------------------------------------
  static let openClawHost = "http://YOUR_HOSTNAME.local"
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
      && openClawHost != "http://YOUR_HOSTNAME.local"
  }
}
