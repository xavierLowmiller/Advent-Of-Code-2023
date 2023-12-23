struct Point: Comparable, Hashable {
  let x, y: Int

  var neighbors: Set<Point> {
    [
      Point(x: x, y: y + 1),
      Point(x: x, y: y - 1),
      Point(x: x + 1, y: y),
      Point(x: x - 1, y: y),
    ]
  }

  static func < (lhs: Self, rhs: Self) -> Bool {
    if lhs.y == rhs.y {
      lhs.x < rhs.x
    } else {
      lhs.y < rhs.y
    }
  }
}

struct PointTuple: Hashable {
  let from: Point
  let to: Point

  init(_ a: Point, _ b: Point) {
    from = min(a, b)
    to = max(a, b)
  }
}

typealias Path = [(p: Point, length: Int)]

struct Maze {

  let start: Point
  let goal: Point
  let rocks: Set<Point>
  let rightOnly: Set<Point>
  let downOnly: Set<Point>
  let branchPoints: Set<Point>
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

    self.start = Point(x: 1, y: 0)
    self.goal = Point(x: bounds.x - 1, y: bounds.y)
    self.rocks = rocks
    self.rightOnly = rightOnly
    self.downOnly = downOnly
    self.bounds = bounds

    var branchPoints: Set<Point> = []
    for y in 0...bounds.y {
      for x in 0...bounds.x {
        let p = Point(x: x, y: y)
        guard !rocks.contains(p) else { continue }

        if p.neighbors.count(where: {
          0...bounds.x ~= $0.x && 0...bounds.y ~= $0.y && !rocks.contains($0)
        }) > 2 {
          branchPoints.insert(p)
        }
      }
    }

    self.branchPoints = branchPoints
  }

  func longestPathFromStartToFinish(canGoUpSlopes: Bool) -> Int {
    var pathMap: [Point: [(p: Point, length: Int)]] = [:]
    // Build graph
    for point in branchPoints + [start] {
      pathMap[point] = findNextBranchPoints(from: point, canGoUpSlopes: canGoUpSlopes)
    }

    // Find longest path from start to goal
    let allPaths = allPaths(graph: pathMap, start: start, length: 0)
    var currentMax: Int = 0
    for path in allPaths {
      let steps = path.reduce(0) { $0 + $1.length }
      if steps > currentMax {
        currentMax = steps
      }
    }

    return currentMax - 1
  }

  func options(for point: Point, canGoUpSlopes: Bool, seen: Set<Point> = []) -> Set<Point> {
    let options: Set<Point>
    if canGoUpSlopes {
      options = point.neighbors.filter {
        0...bounds.x ~= $0.x && 0...bounds.y ~= $0.y && !rocks.contains($0)
      }
    } else {
        if rightOnly.contains(point) {
          options = [Point(x: point.x + 1, y: point.y)]
        } else if downOnly.contains(point) {
          options = [Point(x: point.x, y: point.y + 1)]
        } else {
          options = point.neighbors.filter {
            0...bounds.x ~= $0.x && 0...bounds.y ~= $0.y && !rocks.contains($0)
          }
        }
    }

    return options.subtracting(seen)
  }

  func allPaths(graph: [Point: Path], start: Point, length: Int, path: Path = []) -> [Path] {
    let path = path + [(start, length + 1)]
    guard start != goal else { return [path] }

    var paths: [Path] = []
    for node in graph[start]! {
      if !path.contains(where: { $0.p == node.p }) {
        let newPaths = allPaths(graph: graph, start: node.p, length: node.length, path: path)
        for newPath in newPaths {
          paths.append(newPath)
        }
      }
    }

    return paths
  }

  func findNextBranchPoints(from point: Point, canGoUpSlopes: Bool) -> [(p: Point, length: Int)] {
    var result: [(p: Point, length: Int)] = []

    outerLoop:
    for option in options(for: point, canGoUpSlopes: canGoUpSlopes) {
      var current = option
      var currentLength = 0
      var seen: Set<Point> = [point, option]
      while current != start, current != goal, !branchPoints.contains(current) {
        let options = options(for: current, canGoUpSlopes: canGoUpSlopes, seen: seen)
        guard options.count == 1 else { continue outerLoop }
        current = options.first!
        seen.insert(current)
        currentLength += 1
      }
      result.append((current, currentLength))
    }

    return result
  }
}

public func longestPathFromStartToFinish(in input: String, canGoUpSlopes: Bool) -> Int {
  let maze = Maze(input)
  return maze.longestPathFromStartToFinish(canGoUpSlopes: canGoUpSlopes)
}
