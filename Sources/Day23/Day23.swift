struct Point: Hashable {
    let x, y: Int

    var neighbors: Set<Point> {
        [
            Point(x: x, y: y + 1),
            Point(x: x, y: y - 1),
            Point(x: x + 1, y: y),
            Point(x: x - 1, y: y),
        ]
    }
}

struct Maze {

    let goal: Point
    let rocks: Set<Point>
    let rightOnly: Set<Point>
    let downOnly: Set<Point>
    let bounds: (x: Int, y: Int)

    init(_ input: String) {
        var bounds: (x: Int, y: Int) = (0, 0)
        var rocks: Set<Point> = []
        var rightOnly: Set<Point> = []
        var downOnly: Set<Point> = []
        for (y, line) in input.split(separator: "\n").enumerated() {
            bounds.y = max(bounds.y, y)
            for (x, c) in line.enumerated() {
                bounds.x = max(bounds.x, x)
                switch c {
                case ".":
                    break
                case "#":
                    rocks.insert(Point(x: x, y: y))
                case ">":
                    rightOnly.insert(Point(x: x, y: y))
                case "v":
                    downOnly.insert(Point(x: x, y: y))
                default:
                    fatalError()
                }
            }
        }

        self.goal = Point(x: bounds.x - 1, y: bounds.y)
        self.rocks = rocks
        self.rightOnly = rightOnly
        self.downOnly = downOnly
        self.bounds = bounds
    }

    func pathsToFinish(of position: Point, seen: Set<Point>, canGoUpSlopes: Bool) -> [Set<Point>] {

        var validPaths: [Set<Point>] = []
        var backlog: [(Point, Set<Point>)] = [(position, seen)]

        while !backlog.isEmpty {
            var (point, seen) = backlog.removeFirst()

            while true {
                var nextSteps = nextSteps(of: point, seen: seen, canGoUpSlopes: canGoUpSlopes)

                guard !nextSteps.isEmpty else { break }

                point = nextSteps.removeFirst()
                backlog.append(contentsOf: nextSteps.map { ($0, seen.union([$0])) })

                if point == goal {
                    validPaths.append(seen)
                    break
                } else {
                    seen.insert(point)
                }

            }
        }
        return validPaths

//        nextSteps(of: position, seen: seen, canGoUpSlopes: canGoUpSlopes).flatMap { (p: Point) in
//            guard p != goal else { return [seen] }
//
//            return pathsToFinish(
//                of: p,
//                seen: seen.union([p]),
//                canGoUpSlopes: canGoUpSlopes
//            )
//        }
    }

    func nextSteps(of position: Point, seen: Set<Point>, canGoUpSlopes: Bool) -> Set<Point> {
        let options: Set<Point>
        if canGoUpSlopes {
            options = position.neighbors
                .filter { 0...bounds.x ~= $0.x && 0...bounds.y ~= $0.y && !rocks.contains($0) }
        } else {
            if rightOnly.contains(position) {
               options = [Point(x: position.x + 1, y: position.y)]
           } else if downOnly.contains(position) {
               options = [Point(x: position.x, y: position.y + 1)]
           } else {
               options = position.neighbors
                   .filter { 0...bounds.x ~= $0.x && 0...bounds.y ~= $0.y && !rocks.contains($0) }
           }
        }
        return options.filter { !seen.contains($0) }
    }

    func description(for path: some Sequence<Point>) -> String {
        return String(
            (0...bounds.y).flatMap { y in
                (0...bounds.x).map { x in
                    let point = Point(x: x, y: y)
                    if rocks.contains(point) {
                        return "#"
                    } else if path.contains(point) {
                        return "O"
                    } else if rightOnly.contains(point) {
                        return ">"
                    } else if downOnly.contains(point) {
                        return "v"
                    } else {
                        return "."
                    }
                } + ["\n"]
            }
        )
    }
}

public func longestHike(in input: String, canGoUpSlopes: Bool = false) -> Int {
    let maze = Maze(input)
    let initialPosition = Point(x: 1, y: 0)
    let possibleSolutions = maze.pathsToFinish(
        of: initialPosition,
        seen: [initialPosition],
        canGoUpSlopes: canGoUpSlopes
    )
    return possibleSolutions.map(\.count).max() ?? 0
}
