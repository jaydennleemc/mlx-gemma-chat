# MLX Gemma Chat

这是一个使用 MLX Swift 框架运行 Google Gemma 2B 模型的 Swift 项目。

## 功能特性

- 🚀 基于 MLX 框架的高性能推理
- 💬 交互式聊天界面
- 🔧 4-bit 量化优化
- 🎛️ 可配置的生成参数
- 📱 原生 macOS 支持
- 📈 改进的进度条显示（带实时进度更新）

## 系统要求

- macOS 14.0+ 
- Swift 5.9+
- Apple Silicon Mac (M1/M2/M3)
- 至少 8GB RAM

## 安装和运行

### 1. 安装依赖

首先确保你的 Mac 支持 MLX 框架：

```bash
# 检查系统兼容性
system_profiler SPHardwareDataType | grep "Chip"
```

### 2. 构建项目

```bash
# 下载依赖并构建
swift build -c release

# 或者用于开发调试
swift build
```

### 3. 运行应用

```bash
# 运行编译后的可执行文件
swift run gemma-inference

# 或者直接运行 main.swift
swift run
```

## 使用方法

1. **启动应用**：运行后会自动下载和加载 Gemma 2B 模型，您将看到实时的进度条显示模型下载进度
2. **开始对话**：在提示符后输入你的问题
3. **退出应用**：输入 `quit` 或 `exit`

### 示例对话

```
🚀 Starting Gemma 2B inference with MLX...
📥 Loading Gemma 2B model...
[==========      ] 40%
✅ Model loaded successfully!

💬 Interactive chat started!
Type your messages (or 'quit' to exit):
==================================================

👤 You: 什么是机器学习？
🤖 Gemma: 机器学习是人工智能的一个分支...

👤 You: quit
👋 Goodbye!
```

## 配置选项

在 `main.swift` 的 `Config` 结构体中可以调整：

- `maxTokens`: 最大生成 token 数量
- `temperature`: 生成随机性（0.0-1.0）
- `topP`: nucleus sampling 参数

```swift
struct Config {
    static let maxTokens = 100
    static let temperature: Float = 0.7
    static let topP: Float = 0.9
}
```

## 进度条功能

新添加的 `ProgressBar` 结构体提供了：
- 实时进度更新
- 平滑的进度条动画
- 百分比完成度显示
- 下载完成提示

## 项目结构

```
mlx-gemma-chat/
├── main.swift          # 主程序文件
├── Package.swift       # Swift Package Manager 配置
└── README.md          # 项目说明文档
```

## 开发说明

当前实现包含了完整的应用架构，包括：

1. **模型加载器**：使用 MLXLLM 高级 API
2. **文本生成**：基于 MLX 框架的高效生成
3. **令牌化**：集成的 tokenizer 处理
4. **流式输出**：实时响应生成
5. **进度条**：模型下载进度可视化

## 故障排除

### 常见问题

**Q: 编译错误 - 找不到 MLX 模块**
A: 确保使用的是 Apple Silicon Mac，并且安装了最新的 Xcode

**Q: 模型下载失败**
A: 检查网络连接，模型会从 Hugging Face 自动下载

**Q: 内存不足错误**
A: 尝试减少 `maxTokens` 或使用更小的模型

## 参考资源

- [MLX Swift 官方文档](https://github.com/ml-explore/mlx-swift)
- [Gemma 模型文档](https://ai.google.dev/gemma)
- [Swift Package Manager](https://swift.org/package-manager/)

## 许可证

本项目遵循 MIT 许可证。