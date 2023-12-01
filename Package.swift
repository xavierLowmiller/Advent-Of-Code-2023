// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Advent of Code 2023",
    platforms: [.macOS(.v13)],
    products: [
        .library(name: "Day1", targets: ["Day1"]),
        .library(name: "Day2", targets: ["Day2"]),
        .library(name: "Day3", targets: ["Day3"]),
        .library(name: "Day4", targets: ["Day4"]),
        .library(name: "Day5", targets: ["Day5"]),
        .library(name: "Day6", targets: ["Day6"]),
        .library(name: "Day7", targets: ["Day7"]),
        .library(name: "Day8", targets: ["Day8"]),
        .library(name: "Day9", targets: ["Day9"]),
        .library(name: "Day10", targets: ["Day10"]),
        .library(name: "Day11", targets: ["Day11"]),
        .library(name: "Day12", targets: ["Day12"]),
        .library(name: "Day13", targets: ["Day13"]),
        .library(name: "Day14", targets: ["Day14"]),
        .library(name: "Day15", targets: ["Day15"]),
        .library(name: "Day16", targets: ["Day16"]),
        .library(name: "Day17", targets: ["Day17"]),
        .library(name: "Day18", targets: ["Day18"]),
        .library(name: "Day19", targets: ["Day19"]),
        .library(name: "Day20", targets: ["Day20"]),
        .library(name: "Day21", targets: ["Day21"]),
        .library(name: "Day22", targets: ["Day22"]),
        .library(name: "Day23", targets: ["Day23"]),
        .library(name: "Day24", targets: ["Day24"]),
        .library(name: "Day25", targets: ["Day25"]),
    ],
    targets: [
        .target(name: "Day1"),
        .target(name: "Day2"),
        .target(name: "Day3"),
        .target(name: "Day4"),
        .target(name: "Day5"),
        .target(name: "Day6"),
        .target(name: "Day7"),
        .target(name: "Day8"),
        .target(name: "Day9"),
        .target(name: "Day10"),
        .target(name: "Day11"),
        .target(name: "Day12"),
        .target(name: "Day13"),
        .target(name: "Day14"),
        .target(name: "Day15"),
        .target(name: "Day16"),
        .target(name: "Day17"),
        .target(name: "Day18"),
        .target(name: "Day19"),
        .target(name: "Day20"),
        .target(name: "Day21"),
        .target(name: "Day22"),
        .target(name: "Day23"),
        .target(name: "Day24"),
        .target(name: "Day25"),
        .testTarget(name: "Day1Tests", dependencies: ["Day1"]),
        .testTarget(name: "Day2Tests", dependencies: ["Day2"]),
        .testTarget(name: "Day3Tests", dependencies: ["Day3"]),
        .testTarget(name: "Day4Tests", dependencies: ["Day4"]),
        .testTarget(name: "Day5Tests", dependencies: ["Day5"]),
        .testTarget(name: "Day6Tests", dependencies: ["Day6"]),
        .testTarget(name: "Day7Tests", dependencies: ["Day7"]),
        .testTarget(name: "Day8Tests", dependencies: ["Day8"]),
        .testTarget(name: "Day9Tests", dependencies: ["Day9"]),
        .testTarget(name: "Day10Tests", dependencies: ["Day10"]),
        .testTarget(name: "Day11Tests", dependencies: ["Day11"]),
        .testTarget(name: "Day12Tests", dependencies: ["Day12"]),
        .testTarget(name: "Day13Tests", dependencies: ["Day13"]),
        .testTarget(name: "Day14Tests", dependencies: ["Day14"]),
        .testTarget(name: "Day15Tests", dependencies: ["Day15"]),
        .testTarget(name: "Day16Tests", dependencies: ["Day16"]),
        .testTarget(name: "Day17Tests", dependencies: ["Day17"]),
        .testTarget(name: "Day18Tests", dependencies: ["Day18"]),
        .testTarget(name: "Day19Tests", dependencies: ["Day19"]),
        .testTarget(name: "Day20Tests", dependencies: ["Day20"]),
        .testTarget(name: "Day21Tests", dependencies: ["Day21"]),
        .testTarget(name: "Day22Tests", dependencies: ["Day22"]),
        .testTarget(name: "Day23Tests", dependencies: ["Day23"]),
        .testTarget(name: "Day24Tests", dependencies: ["Day24"]),
        .testTarget(name: "Day25Tests", dependencies: ["Day25"]),
    ]
)
