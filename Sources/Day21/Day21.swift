struct Point: Hashable {
    let x, y: Int

    var neighbors: Set<Point> {
        [
            Point(x: x + 1, y: y),
            Point(x: x - 1, y: y),
            Point(x: x, y: y + 1),
            Point(x: x, y: y - 1),
        ]
    }
}

typealias Bounds = (x: Int, y: Int)

private func parse(_ input: String) -> (rocks: Set<Point>, start: Point, bounds: Bounds) {
    var rocks: Set<Point> = []
    var start: Point?
    var maxX = 0
    var maxY = 0

    for (y, line) in input.split(separator: "\n").enumerated() {
        for (x, c) in line.enumerated() {
            switch c {
            case "#":
                rocks.insert(Point(x: x, y: y))
            case "S":
                start = Point(x: x, y: y)
            case ".":
                break
            default:
                fatalError()
            }
            maxX = max(maxX, x)
        }
        maxY = max(maxY, y)
    }

    return (rocks, start!, (maxX, maxY))
}

struct CacheKey: Hashable {
    let position: Point
    let remainingSteps: Int
}

var cache: [CacheKey: Set<Point>] = [:]

public func possiblePositions(after steps: Int, input: String) -> Int {
    let (rocks, start, bounds) = parse(input)

    let result = possiblePositions(
        remainingSteps: steps,
        position: start,
        rocks: rocks,
        bounds: bounds
    ).count

    return result
}

func possiblePositions(
    remainingSteps: Int,
    position: Point,
    rocks: Set<Point>,
    bounds: Bounds
) -> Set<Point> {
    guard remainingSteps > 0 else { return [position] }

    let key = CacheKey(position: position, remainingSteps: remainingSteps)
    if let hit = cache[key] { return hit }

    let result = Set(position.neighbors
        .filter {
            0...bounds.x ~= $0.x && 0...bounds.y ~= $0.y && !rocks.contains($0)
        }
        .flatMap {
            possiblePositions(
                remainingSteps: remainingSteps - 1,
                position: $0,
                rocks: rocks,
                bounds: bounds
            )
        })

    cache[key] = result
    return result
}
