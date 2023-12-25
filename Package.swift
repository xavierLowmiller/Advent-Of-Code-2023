// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "Advent of Code 2023",
  platforms: [.macOS(.v13)],
  dependencies: [
    .package(url: "https://github.com/apple/swift-algorithms", from: "1.2.0"),
    .package(url: "https://github.com/apple/swift-collections", from: "1.1.0"),
  ],
  targets: [
    .target(name: "AOCAlgorithms", dependencies: [
      .product(name: "DequeModule", package: "swift-collections"),
      .product(name: "HeapModule", package: "swift-collections"),
    ]),
    .testTarget(name: "AOCAlgorithmsTests", dependencies: ["AOCAlgorithms"]),
  ]
)

for day in 1...25 {
  let day = "Day\(day)"
  package.targets.append(.target(name: day, dependencies: [
    "AOCAlgorithms",
    .product(name: "Algorithms", package: "swift-algorithms"),
  ]))
  package.targets.append(.testTarget(name: day + "Tests", dependencies: [.target(name: day)]))
  package.products.append(.library(name: day, targets: [day]))
}
