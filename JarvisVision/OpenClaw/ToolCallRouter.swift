import Foundation

@MainActor
class ToolCallRouter {
    private let bridge: OpenClawBridge
    private var inFlightTasks: [String: Task<Void, Never>] = [:]
    
    init(bridge: OpenClawBridge) {
        self.bridge = bridge
    }
    
    /// Route a tool call from Gemini to OpenClaw. Calls sendResponse with the
    /// JSON dictionary to send back as a toolResponse message.
    func handleToolCall(
        _ call: GeminiFunctionCall,
        sendResponse: @escaping ([String: Any]) -> Void
    ) {
        let callId = call.id
        let callName = call.name
        
        NSLog("[ToolCall] Received: %@ (id: %@) args: %@",
              callName, callId, String(describing: call.args))
        
        let task = Task { @MainActor in
            // Route to the appropriate handler based on tool name
            let taskDescription = self.buildTaskDescription(name: callName, args: call.args)
            let result = await bridge.delegateTask(task: taskDescription, toolName: callName)
            
            guard !Task.isCancelled else {
                NSLog("[ToolCall] Task %@ was cancelled, skipping response", callId)
                return
            }
            
            NSLog("[ToolCall] Result for %@ (id: %@): %@",
                  callName, callId, String(describing: result))
            
            let response = self.buildToolResponse(callId: callId, name: callName, result: result)
            sendResponse(response)
            
            self.inFlightTasks.removeValue(forKey: callId)
        }
        
        inFlightTasks[callId] = task
    }
    
    /// Cancel specific in-flight tool calls (from toolCallCancellation)
    func cancelToolCalls(ids: [String]) {
        for id in ids {
            if let task = inFlightTasks[id] {
                NSLog("[ToolCall] Cancelling in-flight call: %@", id)
                task.cancel()
                inFlightTasks.removeValue(forKey: id)
            }
        }
        bridge.lastToolCallStatus = .cancelled(ids.first ?? "unknown")
    }
    
    /// Cancel all in-flight tool calls (on session stop)
    func cancelAll() {
        for (id, task) in inFlightTasks {
            NSLog("[ToolCall] Cancelling in-flight call: %@", id)
            task.cancel()
        }
        inFlightTasks.removeAll()
    }
    
    // MARK: - Tool Routing
    
    /// Build a natural language task description from typed tool call
    private func buildTaskDescription(name: String, args: [String: Any]) -> String {
        switch name {
            
        // MARK: Messaging
        case "send_telegram":
            let contact = args["contact"] as? String ?? "unknown"
            let message = args["message"] as? String ?? ""
            return "Send a Telegram message to \(contact): \(message)"
            
        case "send_whatsapp":
            let contact = args["contact"] as? String ?? "unknown"
            let message = args["message"] as? String ?? ""
            return "Send a WhatsApp message to \(contact): \(message)"
            
        // MARK: Email
        case "send_email":
            let to = args["to"] as? String ?? ""
            let subject = args["subject"] as? String ?? ""
            let body = args["body"] as? String ?? ""
            return "Send an email to \(to) with subject '\(subject)': \(body)"
            
        // MARK: Web
        case "web_search":
            let query = args["query"] as? String ?? ""
            return "Search the web for: \(query)"
            
        case "web_fetch":
            let url = args["url"] as? String ?? ""
            return "Fetch and read the contents of this URL: \(url)"
            
        // MARK: Weather
        case "get_weather":
            let location = args["location"] as? String ?? "current location"
            return "Get the current weather for \(location)"
            
        // MARK: GitHub
        case "github_action":
            let command = args["command"] as? String ?? ""
            let extraArgs = args["args"] as? String ?? ""
            return "Run GitHub command: gh \(command) \(extraArgs)"
            
        // MARK: Image Generation
        case "generate_image":
            let prompt = args["prompt"] as? String ?? ""
            return "Generate an image: \(prompt)"
            
        // MARK: Memory
        case "remember":
            let fact = args["fact"] as? String ?? ""
            let category = args["category"] as? String
            if let cat = category {
                return "Remember this (\(cat)): \(fact)"
            }
            return "Remember this: \(fact)"
            
        case "recall":
            let query = args["query"] as? String ?? ""
            return "What do you remember about: \(query)"
            
        // MARK: Shell
        case "run_command":
            let command = args["command"] as? String ?? ""
            return "Run this shell command: \(command)"
            
        // MARK: Notifications
        case "send_notification":
            let title = args["title"] as? String ?? ""
            let body = args["body"] as? String ?? ""
            return "Send a notification with title '\(title)': \(body)"
            
        // MARK: Fallback (legacy execute tool)
        case "execute":
            return args["task"] as? String ?? String(describing: args)
            
        default:
            // Unknown tool - pass through as-is
            return "Execute tool '\(name)' with arguments: \(args)"
        }
    }
    
    // MARK: - Private
    
    private func buildToolResponse(
        callId: String,
        name: String,
        result: ToolResult
    ) -> [String: Any] {
        return [
            "toolResponse": [
                "functionResponses": [
                    [
                        "id": callId,
                        "name": name,
                        "response": result.responseValue
                    ]
                ]
            ]
        ]
    }
}
