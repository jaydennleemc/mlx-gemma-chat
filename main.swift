import Foundation
import MLX
import MLXLLM
import MLXLMCommon
import Tokenizers
import ArgumentParser

// MARK: - Configuration
struct Config {
    static let maxTokens = 100
    static let temperature: Float = 0.7
    static let topP: Float = 0.9
}

// MARK: - Extensions
extension String {
    func repeated(_ count: Int) -> String {
        return String(repeating: self, count: count)
    }
}

// MARK: - Progress Bar Helper
struct ProgressBar {
    static func update(_ progress: Progress, width: Int = 50) {
        let percentage = Int(progress.fractionCompleted * 100)
        let completedBlocks = Int(Double(width) * progress.fractionCompleted)
        
        let bar = String(repeating: "=", count: completedBlocks)
        let empty = String(repeating: " ", count: width - completedBlocks)
        let progressBar = "[" + bar + empty + "]"
        
        // Print on the same line using carriage return, without repeating progress.localizedDescription
        print("\r\(progressBar) \(percentage)%", terminator: "")
        fflush(stdout)
        
        if progress.fractionCompleted >= 1.0 {
            print("\n✅ Model download complete!")
        }
    }
}

// MARK: - Main Program
struct LLMInference {
    var modelId: String = "mlx-community/quantized-gemma-2b-it"
    var maxTokens: Int = Config.maxTokens
    var temperature: Float = Config.temperature
    
    func run() async throws {
        print("🚀 MLX Swift Gemma 2B Chat")
        print("Using high-level MLXLLM API")
        print("=".repeated(50))
        
        do {
            // Load model using the simple API
            let modelContainer = try await self.loadModel(id: modelId)
            
            print("\n🎉 Ready! Model loaded successfully.")
            print("Now you can chat just like your example:")
            
            // Example from your message:
            print("\n👨‍💻 Example usage:")
            var conversation: [Chat.Message] = [.system("")] // Add an empty system message to start
            
            print("👤 You: What are two things to see in San Francisco?")
            print("🤖 LLM: ", terminator: "")
            let response1 = try await generateResponse(prompt: "What are two things to see in San Francisco?", modelContainer: modelContainer, conversation: conversation)
            conversation.append(.user("What are two things to see in San Francisco?", images: [], videos: []))
            conversation.append(.assistant(response1))
            print("") // Add newline after response
            
            print("👤 You: How about a great place to eat?")
            print("🤖 LLM: ", terminator: "")
            let response2 = try await generateResponse(prompt: "How about a great place to eat?", modelContainer: modelContainer, conversation: conversation)
            conversation.append(.user("How about a great place to eat?", images: [], videos: []))
            conversation.append(.assistant(response2))
            print("") // Add newline after response
            
            print("\n💬 Interactive Chat:")
            print("Type your messages (or 'quit' to exit):")
            print("-".repeated(40))
            
            // Interactive chat loop - maintaining a context of the conversation
            while true {
                print("👤 You: ", terminator: "")
                guard let input = readLine(), !input.isEmpty else {
                    continue
                }
                
                if input.lowercased() == "quit" || input.lowercased() == "exit" {
                    print("\n👋 Goodbye!")
                    break
                }
                
                print("🤖 Gemma: ", terminator: "")
                let response = try await generateResponse(prompt: input, modelContainer: modelContainer, conversation: conversation)
                conversation.append(.user(input, images: [], videos: []))
                conversation.append(.assistant(response))
                print("") // Add newline after response
            }
            
        } catch {
            print("❌ Error: \(error)")
            if error.localizedDescription.contains("metallib") {
                print("\n💡 This might be a MetalLib issue. Try:")
                print("   1. Make sure you're on Apple Silicon Mac")
                print("   2. Try a different model like: mlx-community/Mistral-7B-v0.1-hf-4bit-mlx")
            }
            exit(1)
        }
    }
    
    // Generate response for a given prompt
    func generateResponse(prompt: String, modelContainer: ModelContainer, conversation: [Chat.Message]) async throws -> String {
        // Add user message to conversation
        var fullConversation = conversation
        fullConversation.append(.user(prompt, images: [], videos: []))
        
        // Prepare input with the current conversation
        let userInput = UserInput(chat: fullConversation, processing: .init())
        let input = try await modelContainer.perform { context in
            try await context.processor.prepare(input: userInput) // Make sure to await this call
        }
        
        // Generate parameters
        let parameters = GenerateParameters(
            maxTokens: Config.maxTokens,
            temperature: Config.temperature,
            topP: Config.topP
        )
        
        // Generate the response using the model context
        var chunks: [String] = []
        
        try await modelContainer.perform { context in
            let cache = context.model.newCache(parameters: parameters)
            
            for await item in try MLXLMCommon.generate(input: input, cache: cache, parameters: parameters, context: context) {
                switch item {
                case .chunk(let string):
                    chunks.append(string)
                    print(string, terminator: "")
                    fflush(stdout)
                case .info(_):
                    // Handle completion info if needed
                    break
                case .toolCall:
                    break
                }
            }
        }
        
        return chunks.joined()
    }
    
    // MARK: - Load Model Function (using the high-level API)
    func loadModel(id: String) async throws -> ModelContainer {
        print("📥 Loading model: " + id + "...")
        
        let configuration = ModelConfiguration(id: id)
        let modelContainer = try await LLMModelFactory.shared.loadContainer(configuration: configuration) { progress in
            // Only show progress updates when there's actual progress
            if progress.fractionCompleted > 0 && progress.fractionCompleted < 1.0 {
                ProgressBar.update(progress)
            } else if progress.fractionCompleted >= 1.0 {
                // Clear the progress bar line and show completion message
                print("\r✅ Model loaded successfully!                      ")
            }
        }
        
        return modelContainer
    }
}

// MARK: - Main Function for Xcode Compatibility
// Using a traditional main function approach for Xcode compatibility
import Darwin

let arguments = LLMInference()

// Run the main functionality in an async context
Task {
    do {
        try await arguments.run()
    } catch {
        print("❌ Application error: \(error)")
        exit(1)
    }
}

// Keep the main thread alive to allow async operations to complete
RunLoop.main.run()