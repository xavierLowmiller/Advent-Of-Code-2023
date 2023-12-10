struct PipeMaze {
    struct Point: Hashable {
        let x: Int
        let y: Int

        var up: Point {
            Point(x: x, y: y - 1)
        }

        var down: Point {
            Point(x: x, y: y + 1)
        }

        var left: Point {
            Point(x: x - 1, y: y)
        }

        var right: Point {
            Point(x: x + 1, y: y)
        }
    }

    struct Pipe {
        enum Connection {
            case left, right, up, down
            
            var opposite: Connection {
                switch self {
                case .left: .right
                case .right: .left
                case .up: .down
                case .down: .up
                }
            }

            func turn(_ connections: Set<Connection>) -> Connection {
                let s = connections.filter { $0 != opposite }
                assert(s.count == 1)
                return s.first!
            }
        }
        let connections: Set<Connection>

        init?(_ c: Character) {
            switch c {
            case "-": connections = [.left, .right]
            case "|": connections = [.up, .down]
            case "L": connections = [.up, .right]
            case "J": connections = [.up, .left]
            case "F": connections = [.down, .right]
            case "7": connections = [.down, .left]
            default: return nil
            }
        }
    }

    let pipes: [Point: Pipe]
    let startingPoint: Point
    let emptyPoints: Set<Point>

    init(_ input: String) {
        var pipes: [Point: Pipe] = [:]
        var startingPoint = Point(x: 0, y: 0)
        var emptyPoints: Set<Point> = []
        for (y, line) in input.split(separator: "\n").enumerated() {
            for (x, c) in line.enumerated() {
                let point = Point(x: x, y: y)
                if let pipe = Pipe(c) {
                    pipes[point] = pipe
                } else if c == "S" {
                    startingPoint = point
                } else if c == "." {
                    emptyPoints.insert(point)
                } else {
                    fatalError()
                }
            }
        }

        // Find pipe of starting point
        let upNeighbor = startingPoint.up
        let downNeighbor = startingPoint.down
        let leftNeighbor = startingPoint.left
        let rightNeighbor = startingPoint.right
        if pipes[upNeighbor]?.connections.contains(.down) == true && pipes[downNeighbor]?.connections.contains(.up) == true {
            pipes[startingPoint] = Pipe("|")
        } else if pipes[leftNeighbor]?.connections.contains(.right) == true && pipes[rightNeighbor]?.connections.contains(.left) == true {
            pipes[startingPoint] = Pipe("-")
        } else if pipes[upNeighbor]?.connections.contains(.down) == true && pipes[leftNeighbor]?.connections.contains(.right) == true {
            pipes[startingPoint] = Pipe("J")
        } else if pipes[upNeighbor]?.connections.contains(.down) == true && pipes[rightNeighbor]?.connections.contains(.left) == true {
            pipes[startingPoint] = Pipe("L")
        } else if pipes[downNeighbor]?.connections.contains(.up) == true && pipes[leftNeighbor]?.connections.contains(.right) == true {
            pipes[startingPoint] = Pipe("7")
        } else if pipes[downNeighbor]?.connections.contains(.up) == true && pipes[rightNeighbor]?.connections.contains(.left) == true {
            pipes[startingPoint] = Pipe("F")
        } else {
            fatalError()
        }

        self.pipes = pipes
        self.startingPoint = startingPoint
        self.emptyPoints = emptyPoints
    }

    var mostStepsAwayFromS: Int {
        stepsToTraverseTheMaze / 2
    }

    var enclosedPoints: Int {
        var visitedPoints: Set<Point> = []
        var interiorPoints: Set<Point> = []
        var exteriorPoints: Set<Point> = []
        var angle = 0

        walkMaze { oldDirection, newDirection, position in
            visitedPoints.insert(position)

            switch (oldDirection, newDirection) {
            case (.up, .up):
                exteriorPoints.insert(position.left)
                interiorPoints.insert(position.right)
            case (.up, .left):
                interiorPoints.insert(position.right)
                interiorPoints.insert(position.up)
                angle -= 90
            case (.up, .right):
                exteriorPoints.insert(position.left)
                exteriorPoints.insert(position.up)
                angle += 90
            case (.down, .down):
                exteriorPoints.insert(position.right)
                interiorPoints.insert(position.left)
            case (.down, .left):
                exteriorPoints.insert(position.right)
                exteriorPoints.insert(position.down)
                angle += 90
            case (.down, .right):
                interiorPoints.insert(position.left)
                interiorPoints.insert(position.down)
                angle -= 90
            case (.left, .left):
                exteriorPoints.insert(position.down)
                interiorPoints.insert(position.up)
            case (.left, .up):
                exteriorPoints.insert(position.down)
                exteriorPoints.insert(position.left)
                angle += 90
            case (.left, .down):
                interiorPoints.insert(position.up)
                interiorPoints.insert(position.left)
                angle -= 90
            case (.right, .right):
                exteriorPoints.insert(position.up)
                interiorPoints.insert(position.down)
            case (.right, .up):
                interiorPoints.insert(position.down)
                interiorPoints.insert(position.right)
                angle -= 90
            case (.right, .down):
                exteriorPoints.insert(position.up)
                exteriorPoints.insert(position.right)
                angle += 90
            default:
                fatalError("Bad direction combination")
            }
        }

        interiorPoints.subtract(visitedPoints)
        exteriorPoints.subtract(visitedPoints)

        interiorPoints.subtract(interiorPoints.intersection(exteriorPoints))
        exteriorPoints.subtract(interiorPoints.intersection(exteriorPoints))

        assert(angle == 360 || angle == -360)
        var actualInteriorPoints = angle > 0 ? interiorPoints : exteriorPoints
        actualInteriorPoints.fillBounds(boundedBy: visitedPoints)
        return actualInteriorPoints.count
    }

    private var stepsToTraverseTheMaze: Int {
        var steps = 0
        walkMaze { _, _, _ in steps += 1 }
        return steps
    }

    private func walkMaze(
        _ performEachStep: (
            _ oldDirection: Pipe.Connection,
            _ newDirection: Pipe.Connection,
            _ position: Point
        ) -> ()
    ) {
        var position = startingPoint
        var direction = pipes[position]!.connections.first!

        repeat {
            let oldDirection = direction
            (position, direction) = move(in: direction, from: position)
            performEachStep(oldDirection, direction, position)
        } while position != startingPoint
    }

    private func move(in direction: Pipe.Connection, from position: Point) -> (position: Point, direction: Pipe.Connection) {
        let newPosition: Point
        switch direction {
        case .left:
            newPosition = position.left
        case .right:
            newPosition = position.right
        case .up:
            newPosition = position.up
        case .down:
            newPosition = position.down
        }
        let newDirection = direction.turn(pipes[newPosition]!.connections)

        return (newPosition, newDirection)
    }
}

private extension Set where Element == PipeMaze.Point {
    mutating func fillBounds(boundedBy border: Self) {
        var neighborsToCheck = Array(self)
            .flatMap { [$0.up, $0.down, $0.left, $0.right] }
            .filter { !self.contains($0) && !border.contains($0) }

        while !neighborsToCheck.isEmpty {
            for neighbor in neighborsToCheck {
                self.insert(neighbor)
            }
            neighborsToCheck = self
                .flatMap { [$0.up, $0.down, $0.left, $0.right] }
                .filter { !self.contains($0) && !border.contains($0) }
        }
    }
}
