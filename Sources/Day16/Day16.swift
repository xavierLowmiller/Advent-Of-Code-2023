struct LaserArray {
    struct Point: Hashable {
        var x, y: Int

        mutating func move(in direction: Direction) {
            switch direction {
            case .right: x += 1
            case .left: x -= 1
            case .up: y -= 1
            case .down: y += 1
            }
        }
    }

    enum Direction {
        case right, left, up, down
    }

    enum Object {
        case splitter(Character)
        case mirror(Character)
    }

    var objects: [Point: Object] = [:]
    let bounds: (x: Int, y: Int)

    init(_ input: String) {
        var maxX = 0
        var maxY = 0
        for (y, line) in input.split(separator: "\n").enumerated() {
            for (x, c) in line.enumerated() {
                let point = Point(x: x, y: y)
                switch c {
                case ".":
                    break
                case "/", "\\":
                    objects[point] = .mirror(c)
                case "|", "-":
                    objects[point] = .splitter(c)
                default:
                    fatalError("unknown character \(c)")
                }
                maxX = max(maxX, x)
            }
            maxY = max(maxY, y)
        }

        bounds = (maxX, maxY)
    }

    var energizedTiles: Int {
        pointsTheLightTouches(from: Point(x: -1, y: 0), in: .right).count
    }

    var maxEnergizedTiles: Int {
        var maxTiles = 0
        for x in 0...bounds.x {
            maxTiles = max(maxTiles, pointsTheLightTouches(from: Point(x: x, y: -1), in: .down).count)
            maxTiles = max(maxTiles, pointsTheLightTouches(from: Point(x: x, y: bounds.y + 1), in: .up).count)
        }
        for y in 0...bounds.y {
            maxTiles = max(maxTiles, pointsTheLightTouches(from: Point(x: -1, y: y), in: .right).count)
            maxTiles = max(maxTiles, pointsTheLightTouches(from: Point(x: bounds.x + 1, y: y), in: .left).count)
        }
        return maxTiles
    }

    private func pointsTheLightTouches(
        from point: Point,
        in direction: Direction
    ) -> Set<Point> {
        var touchedPoints: Set<Point> = []

        var pointsToCheck = [(point, direction)]

        struct CacheKey: Hashable {
            let point: Point
            let direction: Direction
        }
        var usedMirrors: Set<CacheKey> = []
        var usedSplitters: Set<Point> = []

        while var (point, direction) = pointsToCheck.popLast() {

            outerLoop:
            while true {
                point.move(in: direction)

                guard 0...bounds.x ~= point.x, 0...bounds.y ~= point.y
                else { break }

                touchedPoints.insert(point)

                switch objects[point] {
                case .mirror(let c):
                    let key = CacheKey(point: point, direction: direction)
                    if usedMirrors.contains(key) {
                        break outerLoop
                    } else {
                        usedMirrors.insert(key)
                        if c == "/" {
                            direction = switch direction {
                            case .right: .up
                            case .left: .down
                            case .up: .right
                            case .down: .left
                            }
                        } else {
                            direction = switch direction {
                            case .right: .down
                            case .left: .up
                            case .up: .left
                            case .down: .right
                            }
                        }
                    }

                case .splitter("|") where direction == .left || direction == .right:
                    if !usedSplitters.contains(point) {
                        pointsToCheck += [(point, .up), (point, .down)]
                        usedSplitters.insert(point)
                    }
                    break outerLoop

                case .splitter("-") where direction == .up || direction == .down:
                    if !usedSplitters.contains(point) {
                        pointsToCheck += [(point, .left), (point, .right)]
                        usedSplitters.insert(point)
                    }
                    break outerLoop

                default:
                    continue
                }
            }
        }

        return touchedPoints
    }
}
