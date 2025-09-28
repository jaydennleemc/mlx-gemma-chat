# Swift Inference Gemma 2B - Project Context

## Project Overview

This is a Swift project that implements high-performance inference for Google's Gemma 2B language model using the MLX Swift framework. The project provides an interactive chat interface that runs natively on Apple Silicon Macs with 4-bit quantization optimization for efficient performance. The project now includes enhanced progress bar functionality during model download.

**Key Features:**
- 🚀 High-performance inference using MLX framework
- 💬 Interactive chat interface for conversational AI
- 🔧 4-bit quantization optimization for efficient memory usage
- 🎛️ Configurable generation parameters (temperature, topP, max tokens)
- 📱 Native macOS support on Apple Silicon (M1/M2/M3)
- 📈 Enhanced progress bar with smooth updates during model download

## Technologies and Dependencies

The project utilizes:
- **MLX Swift Framework**: High-performance machine learning framework for Apple Silicon
- **MLX Swift Examples**: Provides LLM-specific functionality
- **Swift Argument Parser**: For command-line argument handling
- **Swift Package Manager**: For dependency management

## Project Structure

```
swift_inference_gemma2b/
├── main.swift          # Main application entry point with chat interface
├── Package.swift       # Swift Package Manager configuration
├── Package.resolved    # Resolved dependency versions
├── README.md          # Project documentation
└── QWEN.md            # Project context documentation
```

## Building and Running

### Prerequisites
- macOS 14.0+
- Swift 5.9+
- Apple Silicon Mac (M1/M2/M3)
- At least 8GB RAM

### Build Commands
```bash
# Build the project in release mode
swift build -c release

# Build for development/debugging
swift build

# Run the application directly
swift run gemma-inference
# or
swift run
```

### Running with Custom Parameters
```bash
# Run with custom model ID
swift run gemma-inference mlx-community/gemma-2-2b-it-4bit

# Run with custom parameters
swift run gemma-inference --maxTokens 200 --temperature 0.8
```

## Configuration Options

The project includes configurable parameters in the `Config` struct in `main.swift`:
- `maxTokens`: Maximum number of tokens to generate (default: 100)
- `temperature`: Generation randomness (0.0-1.0, default: 0.7)
- `topP`: Nucleus sampling parameter (default: 0.9)

## Progress Bar Features

The `ProgressBar` struct in `main.swift` provides:
- Smooth progress bar visualization with `[==========      ]` format
- Real-time percentage completion display
- Proper terminal line overwriting with carriage return (`\r`)
- Clean completion message when download finishes
- Proper Swift string interpolation for dynamic values

## Development Conventions

- The code follows Swift best practices and idioms
- Uses async/await for asynchronous operations like model loading and generation
- Implements a ChatSession class to manage conversation context
- Leverages MLX Swift's high-level API for model loading and inference
- Includes robust progress tracking during model downloads

## Core Implementation Details

The main components of the implementation include:
1. **ChatSession class**: Manages the conversation state and generates responses
2. **loadModel function**: Handles model loading with progress tracking
3. **GemmaInference command-line tool**: Provides argument parsing and interactive chat interface
4. **Model configuration**: Uses the model's chat template for proper prompt formatting
5. **ProgressBar class**: Visualizes model download progress with smooth updates

## Troubleshooting

Common issues and solutions:
- **Metallib errors**: May indicate issues with Apple Silicon compatibility or Metal framework
- **Model download failures**: Check network connectivity as models are downloaded from Hugging Face
- **Memory issues**: Reduce maxTokens or try with a smaller model
- **Progress bar issues**: Ensure proper terminal support for carriage return (`\r`) characters

## External Dependencies (Package.resolved)

The project uses specific versions of:
- MLX Swift (v0.25.6)
- MLX Swift Examples (v0.12.1)
- Swift Argument Parser (v1.6.1)
- Additional dependencies for async algorithms, collections, numerics, and transformers

This project represents a complete implementation of a Swift-based AI chat interface using Apple's MLX framework optimized for Apple Silicon hardware with enhanced user experience through proper progress visualization.