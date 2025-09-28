// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MlxGemmaChat",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(
            name: "gemma-inference",
            targets: ["MlxGemmaChat"]
        )
    ],
    dependencies: [
        // MLX Swift framework
        .package(url: "https://github.com/ml-explore/mlx-swift", from: "0.25.0"),
        
        // MLX Swift examples with MLXLLM - using a more recent commit that has the fix
        .package(url: "https://github.com/ml-explore/mlx-swift-examples", branch: "main"),
        
        // Additional utilities
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "MlxGemmaChat",
            dependencies: [
                .product(name: "MLX", package: "mlx-swift"),
                .product(name: "MLXRandom", package: "mlx-swift"),
                .product(name: "MLXNN", package: "mlx-swift"),
                .product(name: "MLXFast", package: "mlx-swift"),
                .product(name: "MLXLLM", package: "mlx-swift-examples"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: ".",
            exclude: ["README.md", "QWEN.md"],
            sources: ["main.swift"]
        )
    ]
)