struct Point: Hashable {
    var x, y, z: Int
}

extension Point {
    init(_ input: Substring) {
        let coords = input.split(separator: ",").compactMap { Int($0) }
        x = coords[0]
        y = coords[1]
        z = coords[2]
    }
}

struct Brick: Hashable {
    var from: Point
    var to: Point

    var lowerZ: Int {
        min(from.z, to.z)
    }

    var upperZ: Int {
        max(from.z, to.z)
    }

    mutating func moveDown(by z: Int) {
        from.z -= z
        to.z -= z
    }

    var xRange: ClosedRange<Int> {
        from.x...to.x
    }

    var yRange: ClosedRange<Int> {
        from.y...to.y
    }

    func hasOverlappingFootprint(with other: Brick) -> Bool {
        other.xRange.overlaps(xRange) && other.yRange.overlaps(yRange)
    }

    func maxStepsToMoveDown(in bricks: some Sequence<Brick>) -> Int {
        let overlappingBricks = bricks.filter { $0.hasOverlappingFootprint(with: self) }
        assert(overlappingBricks.allSatisfy { $0.upperZ < lowerZ })
        let maxZ = overlappingBricks.map(\.upperZ).max() ?? 0

        let stepsToMoveDown = lowerZ - maxZ - 1
        assert(stepsToMoveDown >= 0)
        return stepsToMoveDown
    }

    mutating func moveDownAsFarAsPossible(among bricks: some Sequence<Brick>) {
        moveDown(by: maxStepsToMoveDown(in: bricks))
    }
}

extension Brick {
    init(_ input: Substring) {
        from = Point(input.split(separator: "~")[0])
        to = Point(input.split(separator: "~")[1])
    }
}

public func numberOfRemovableBricks(_ input: String) -> Int {
    let bricks = input.split(separator: "\n").map(Brick.init)
    return bricks
        .compacted
        .structurallyIrrelevantBricks
        .count
}

public func bricksThatFallAfterDisintegrating(_ input: String) -> Int {
    let bricks = input.split(separator: "\n").map(Brick.init).compacted

    let removableBricks = Set(bricks.structurallyIrrelevantBricks)
    let bricksThatCauseOtherBricksToFall = bricks.filter { !removableBricks.contains($0) }

    return bricksThatCauseOtherBricksToFall
        .reduce(0) { $0 + bricks.numberOfMovingBricks(whenRemoving: $1) }
}

extension [Brick] {
    var compacted: [Brick] {
        var fallenBricks: [Brick] = []
        for var brick in sorted(by: { $0.lowerZ < $1.lowerZ }) {
            brick.moveDownAsFarAsPossible(among: fallenBricks)
            fallenBricks.append(brick)
        }
        return fallenBricks.sorted(by: { $0.lowerZ < $1.lowerZ })
    }

    var structurallyIrrelevantBricks: [Brick] {
        filter { brick in
            let bricksDirectlyAbove = filter { $0.lowerZ == brick.upperZ + 1 }
            guard !bricksDirectlyAbove.isEmpty else { return true }

            let bricksAtSameLevel = filter { $0.upperZ == brick.upperZ && $0 != brick }
            return bricksDirectlyAbove.allSatisfy { aboveBrick in
                bricksAtSameLevel.contains(where: { $0.hasOverlappingFootprint(with: aboveBrick) })
            }
        }
    }

    func numberOfMovingBricks(whenRemoving brick: Brick) -> Int {
        let bricks = filter { $0 != brick }

        var fallenBricks: [Brick] = []
        var movingBricks = 0
        for var brick in bricks {
            let before = brick
            brick.moveDownAsFarAsPossible(among: fallenBricks)
            if before != brick {
                movingBricks += 1
            }
            fallenBricks.append(brick)
        }

        return movingBricks
    }
}
