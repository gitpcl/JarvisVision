import Foundation

/// Typed tool declarations for Gemini Live API.
/// Each tool maps to a specific OpenClaw capability.
enum ToolDeclarations {
    
    /// All tools to register with Gemini
    static let allTools: [[String: Any]] = [
        // MARK: - Messaging
        [
            "name": "send_telegram",
            "description": "Send a message via Telegram to a contact",
            "parameters": [
                "type": "object",
                "properties": [
                    "contact": ["type": "string", "description": "Contact name or username"],
                    "message": ["type": "string", "description": "Message text to send"]
                ],
                "required": ["contact", "message"]
            ]
        ],
        [
            "name": "send_whatsapp",
            "description": "Send a WhatsApp message to a contact",
            "parameters": [
                "type": "object",
                "properties": [
                    "contact": ["type": "string", "description": "Contact name or phone number"],
                    "message": ["type": "string", "description": "Message text to send"]
                ],
                "required": ["contact", "message"]
            ]
        ],
        
        // MARK: - Email
        [
            "name": "send_email",
            "description": "Send an email",
            "parameters": [
                "type": "object",
                "properties": [
                    "to": ["type": "string", "description": "Recipient email address"],
                    "subject": ["type": "string", "description": "Email subject line"],
                    "body": ["type": "string", "description": "Email body text"]
                ],
                "required": ["to", "subject", "body"]
            ]
        ],
        
        // MARK: - Web
        [
            "name": "web_search",
            "description": "Search the web for information",
            "parameters": [
                "type": "object",
                "properties": [
                    "query": ["type": "string", "description": "Search query"]
                ],
                "required": ["query"]
            ]
        ],
        [
            "name": "web_fetch",
            "description": "Fetch and read the contents of a specific URL",
            "parameters": [
                "type": "object",
                "properties": [
                    "url": ["type": "string", "description": "The URL to fetch"]
                ],
                "required": ["url"]
            ]
        ],
        
        // MARK: - Weather
        [
            "name": "get_weather",
            "description": "Get current weather and forecast for a location",
            "parameters": [
                "type": "object",
                "properties": [
                    "location": ["type": "string", "description": "City name or location"]
                ],
                "required": []
            ]
        ],
        
        // MARK: - GitHub
        [
            "name": "github_action",
            "description": "Execute a GitHub CLI command. Can create issues, PRs, check status, etc.",
            "parameters": [
                "type": "object",
                "properties": [
                    "command": ["type": "string", "description": "The gh CLI command (e.g., 'issue create', 'pr list')"],
                    "args": ["type": "string", "description": "Additional arguments for the command"]
                ],
                "required": ["command"]
            ]
        ],
        
        // MARK: - Image Generation
        [
            "name": "generate_image",
            "description": "Generate an image from a text description",
            "parameters": [
                "type": "object",
                "properties": [
                    "prompt": ["type": "string", "description": "Description of the image to generate"]
                ],
                "required": ["prompt"]
            ]
        ],
        
        // MARK: - Memory
        [
            "name": "remember",
            "description": "Store a fact or piece of information in persistent memory for later recall",
            "parameters": [
                "type": "object",
                "properties": [
                    "fact": ["type": "string", "description": "The information to remember"],
                    "category": ["type": "string", "description": "Optional category (e.g., 'work', 'personal', 'health')"]
                ],
                "required": ["fact"]
            ]
        ],
        [
            "name": "recall",
            "description": "Search persistent memory for relevant information",
            "parameters": [
                "type": "object",
                "properties": [
                    "query": ["type": "string", "description": "What to search for in memory"]
                ],
                "required": ["query"]
            ]
        ],
        
        // MARK: - Shell
        [
            "name": "run_command",
            "description": "Execute a shell command on the connected system",
            "parameters": [
                "type": "object",
                "properties": [
                    "command": ["type": "string", "description": "Shell command to execute"]
                ],
                "required": ["command"]
            ]
        ],
        
        // MARK: - Notifications
        [
            "name": "send_notification",
            "description": "Send a push notification to the user's devices",
            "parameters": [
                "type": "object",
                "properties": [
                    "title": ["type": "string", "description": "Notification title"],
                    "body": ["type": "string", "description": "Notification body text"]
                ],
                "required": ["title", "body"]
            ]
        ]
    ]
    
    /// Get all function declarations for Gemini setup message
    static func allDeclarations() -> [[String: Any]] {
        return allTools
    }
}
