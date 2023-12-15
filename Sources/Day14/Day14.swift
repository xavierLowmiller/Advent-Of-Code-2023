public struct Panel {
    struct Point: Hashable {
        var x,y: Int

        mutating func move(_ direction: Direction, in bounds: (x: Int, y: Int), blocked: Set<Self>) {
            let oldValue = self

            switch direction {
            case .north: y -= 1
            case .west: x -= 1
            case .south: y += 1
            case .east: x += 1
            }

            if !(0...bounds.x).contains(x) ||
               !(0...bounds.y).contains(y) ||
               blocked.contains(self) {
                self = oldValue
            }
        }
    }

    enum Direction {
        case north, west, south, east
    }

    var rollingRocks: Set<Point> = []
    var staticRocks: Set<Point> = []
    var bounds: (x: Int, y: Int)

    public init(_ input: String) {
        for (y, line) in input.split(separator: "\n").enumerated() {
            for (x, c) in line.enumerated() {
                let point = Point(x: x, y: y)
                switch c {
                case ".":
                    break
                case "O":
                    rollingRocks.insert(point)
                case "#":
                    staticRocks.insert(point)
                default:
                    fatalError("unknown character \(c)")
                }
            }
        }
        bounds = (
            x: (rollingRocks.union(staticRocks)).map(\.x).max() ?? 0,
            y: (rollingRocks.union(staticRocks)).map(\.y).max() ?? 0
        )
    }

    public var loadAfterTiltingNorth: Int {
        let rocks = rollingRocks.move(.north, within: bounds, obstructions: staticRocks)

        return totalLoad(of: rocks)
    }

    public var loadAfterSpinning: Int {

        let cycles = 1000000000
        var cycle = 0
        var rocks = rollingRocks

        var cache: [Set<Point>: Int] = [:]

        while cycle < cycles {
            rocks = rocks.move(.north, within: bounds, obstructions: staticRocks)
            rocks = rocks.move(.west, within: bounds, obstructions: staticRocks)
            rocks = rocks.move(.south, within: bounds, obstructions: staticRocks)
            rocks = rocks.move(.east, within: bounds, obstructions: staticRocks)
            cycle += 1

            if let hit = cache[rocks] {
                // Cycle detected -> fast forward
                let diff = cycle - hit
                while cycle + diff < cycles {
                    cycle += diff
                }
            } else {
                cache[rocks] = cycle
            }
        }

        assert(cycle == cycles)
        return totalLoad(of: rocks)
    }

    private func totalLoad(of positions: Set<Panel.Point>) -> Int {
        positions.reduce(0) { $0 + bounds.y + 1 - $1.y }
    }
}

extension Set<Panel.Point> {
    func move(
        _ direction: Panel.Direction,
        within bounds: (x: Int, y: Int),
        obstructions: Set<Panel.Point>
    ) -> Self {

        var before: Set<Panel.Point> = []
        var rocks = self

        while before != rocks {
            before = rocks
            var blocked = obstructions
            rocks = Set(minimumCapacity: rocks.count)
            let sortedRocks = before.sorted { p1, p2 in
                switch direction {
                case .north: p1.y < p2.y
                case .west: p1.x < p2.x
                case .south: p1.y > p2.y
                case .east: p1.x > p2.x
                }
            }

            for var rock in sortedRocks {
                rock.move(direction, in: bounds, blocked: blocked)
                blocked.insert(rock)
                rocks.insert(rock)
            }
        }

        return rocks
    }
}
