# MLX Gemma Chat

This is a Swift project that runs Google's Gemma 2B model using the MLX Swift framework.

## Features

- 🚀 High-performance inference using MLX framework
- 💬 Interactive chat interface
- 🔧 4-bit quantization optimization
- 🎛️ Configurable generation parameters
- 📱 Native macOS support
- 📈 Enhanced progress bar display (with real-time progress updates)

## System Requirements

- macOS 14.0+ 
- Swift 5.9+
- Apple Silicon Mac (M1/M2/M3)
- At least 8GB RAM

## Installation and Running

### 1. Install Dependencies

First, ensure your Mac supports the MLX framework:

```bash
# Check system compatibility
system_profiler SPHardwareDataType | grep "Chip"
```

### 2. Build the Project

```bash
# Download dependencies and build
swift build -c release

# Or for development/debugging
swift build
```

### 3. Run the Application

```bash
# Run the compiled executable
swift run gemma-inference

# Or run main.swift directly
swift run
```

## Usage

1. **Start the application**: After running, the Gemma 2B model will be automatically downloaded and loaded, and you will see a real-time progress bar showing the model download progress
2. **Start a conversation**: Enter your question after the prompt
3. **Exit the application**: Type `quit` or `exit`

### Example Conversation

```
🚀 Starting Gemma 2B inference with MLX...
📥 Loading Gemma 2B model...
[==========      ] 40%
✅ Model loaded successfully!

💬 Interactive chat started!
Type your messages (or 'quit' to exit):
==================================================

👤 You: What is machine learning?
🤖 Gemma: Machine learning is a branch of artificial intelligence...

👤 You: quit
👋 Goodbye!
```

## Configuration Options

Adjustable in the `Config` struct in `main.swift`:

- `maxTokens`: Maximum number of generated tokens
- `temperature`: Generation randomness (0.0-1.0)
- `topP`: Nucleus sampling parameter

```swift
struct Config {
    static let maxTokens = 100
    static let temperature: Float = 0.7
    static let topP: Float = 0.9
}
```

## Progress Bar Features

The newly added `ProgressBar` struct provides:
- Real-time progress updates
- Smooth progress bar animation
- Percentage completion display
- Download completion notification

## Project Structure

```
mlx-gemma-chat/
├── main.swift          # Main program file
├── Package.swift       # Swift Package Manager configuration
└── README.md          # Project documentation
```

## Development Notes

The current implementation includes a complete application architecture, including:

1. **Model loader**: Using MLXLLM high-level API
2. **Text generation**: Efficient generation based on MLX framework
3. **Tokenization**: Integrated tokenizer processing
4. **Streaming output**: Real-time response generation
5. **Progress bar**: Visual model download progress

## Troubleshooting

### Common Issues

**Q: Compilation error - Cannot find MLX module**
A: Ensure you are using an Apple Silicon Mac with the latest Xcode installed

**Q: Model download failure**
A: Check your network connection; the model will be automatically downloaded from Hugging Face

**Q: Out of memory error**
A: Try reducing `maxTokens` or use a smaller model

## Resources

- [MLX Swift Official Documentation](https://github.com/ml-explore/mlx-swift)
- [Gemma Model Documentation](https://ai.google.dev/gemma)
- [Swift Package Manager](https://swift.org/package-manager/)

## License

This project is licensed under the MIT License.