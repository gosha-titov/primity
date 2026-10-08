// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

// SPDX-FileCopyrightText: Copyright (c) 2026 gosha
// SPDX-License-Identifier: MIT

import PackageDescription

let package = Package(
    name: "Primity",
    products: [
        .library(
            name: "Primity",
            targets: ["Primity"]
        )
    ],
    targets: [
        .target(
            name: "Primity",
            path: "sources"
        ),
        .testTarget(
            name: "PrimityTests",
            dependencies: ["Primity"],
            path: "tests"
        )
    ],
    swiftLanguageModes: [.v6]
)
